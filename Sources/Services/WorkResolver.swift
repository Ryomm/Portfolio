import Foundation

/// Turns hand-written `Work` entries into render-ready `WorkItem`s by
/// fetching OGP metadata where needed and sorting by date (newest first).
///
/// OGP lookups go through `OpenGraphCache` (`ogp-cache.json`), so only URLs
/// not seen before touch the network.
enum WorkResolver {
    static func resolve(_ works: [Work]) async -> [WorkItem] {
        let cache = OpenGraphCache()
        await cache.load()

        let items = await withTaskGroup(of: WorkItem.self) { group in
            for work in works {
                group.addTask { await resolve(work, cache: cache) }
            }

            var results: [WorkItem] = []
            for await item in group {
                results.append(item)
            }
            return results
        }

        await cache.save()
        return items.sorted { $0.date > $1.date }
    }

    private static func resolve(_ work: Work, cache: OpenGraphCache) async -> WorkItem {
        switch work {
        case let .article(url, date):
            let parsed = Work.parseDate(date)
            let metadata = await fetchMetadata(url, cache: cache)
            return WorkItem(
                kind: .article,
                title: metadata?.title ?? url,
                date: parsed.date,
                dateText: parsed.display,
                description: nil,
                url: url,
                thumbnail: metadata?.image)

        case let .talk(title, date, url, description, thumbnail):
            let parsed = Work.parseDate(date)
            var resolvedThumbnail = thumbnail
            if resolvedThumbnail == nil, let url {
                resolvedThumbnail = await fetchMetadata(url, cache: cache)?.image
            }
            return WorkItem(
                kind: .talk,
                title: title,
                date: parsed.date,
                dateText: parsed.display,
                description: description,
                url: url,
                thumbnail: resolvedThumbnail)

        case let .project(title, date, url, description, thumbnail):
            let parsed = Work.parseDate(date)
            return WorkItem(
                kind: .project,
                title: title,
                date: parsed.date,
                dateText: parsed.display,
                description: description,
                url: url,
                thumbnail: thumbnail)
        }
    }

    /// Returns OGP metadata from the cache, or fetches and caches it.
    /// Logs and returns `nil` on failure so one unreachable page never
    /// breaks the whole build.
    private static func fetchMetadata(_ url: String, cache: OpenGraphCache) async -> OpenGraphMetadata? {
        if let cached = await cache.metadata(for: url) {
            return cached
        }

        do {
            let metadata = try await OpenGraphFetcher.fetch(url)
            await cache.store(metadata, for: url)
            return metadata
        } catch {
            print("⚠️ Works: failed to fetch OGP for \(url): \(error.localizedDescription)")
            return nil
        }
    }
}
