import Foundation

/// A JSON file cache for OGP lookups so builds don't hit the network for
/// pages that were already resolved.
///
/// - Location: `ogp-cache.json` next to `Package.swift`. Commit it so CI and
///   offline builds work without network access.
/// - Refresh: run with the environment variable `OGP_REFRESH=1` to ignore the
///   cache and fetch everything again (the file is then rewritten).
/// - Pruning: on save, only URLs requested during this build are kept, so
///   entries for removed works disappear automatically.
actor OpenGraphCache {
    /// One cached lookup.
    struct Entry: Codable, Sendable {
        var title: String?
        var image: String?
        var fetchedAt: Date

        var metadata: OpenGraphMetadata {
            OpenGraphMetadata(title: title, image: image)
        }
    }

    /// The cache file, resolved relative to this source file:
    /// Sources/Services/OpenGraphCache.swift → package root.
    static let fileURL: URL = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent() // Services
        .deletingLastPathComponent() // Sources
        .deletingLastPathComponent() // package root
        .appendingPathComponent("ogp-cache.json")

    private var entries: [String: Entry] = [:]
    private var requested: Set<String> = []
    private let isBypassed: Bool

    init() {
        isBypassed = ProcessInfo.processInfo.environment["OGP_REFRESH"] == "1"
    }

    /// Loads the cache file if it exists. Missing or unreadable files are
    /// treated as an empty cache.
    func load() {
        guard !isBypassed else {
            print("ℹ️ OGP cache bypassed (OGP_REFRESH=1)")
            return
        }

        guard let data = try? Data(contentsOf: Self.fileURL) else { return }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            entries = try decoder.decode([String: Entry].self, from: data)
        } catch {
            print("⚠️ OGP cache: could not read \(Self.fileURL.path): \(error.localizedDescription)")
        }
    }

    /// Returns cached metadata for a URL, if any, and marks the URL as in use.
    func metadata(for url: String) -> OpenGraphMetadata? {
        requested.insert(url)
        return entries[url]?.metadata
    }

    /// Records freshly fetched metadata for a URL.
    func store(_ metadata: OpenGraphMetadata, for url: String) {
        requested.insert(url)
        entries[url] = Entry(
            title: metadata.title,
            image: metadata.image,
            fetchedAt: Date())
    }

    /// Writes the cache back to disk. Output is deterministic (sorted keys,
    /// unchanged `fetchedAt` for cached entries), so an unchanged cache
    /// produces an identical file and no diff.
    func save() {
        let kept = entries.filter { requested.contains($0.key) }

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(kept)
            try data.write(to: Self.fileURL, options: .atomic)
            print("💾 OGP cache saved (\(kept.count) entries) → \(Self.fileURL.lastPathComponent)")
        } catch {
            print("⚠️ OGP cache: could not write \(Self.fileURL.path): \(error.localizedDescription)")
        }
    }
}
