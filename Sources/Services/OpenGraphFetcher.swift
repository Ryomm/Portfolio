import Foundation

/// The subset of Open Graph metadata we use for Works.
struct OpenGraphMetadata: Sendable {
    var title: String?
    var image: String?
}

/// Downloads a page and extracts its `og:*` meta tags.
///
/// This is deliberately dependency-free: OGP tags are simple enough that a
/// regex over `<meta>` elements is reliable, and it avoids adding SwiftSoup
/// as a direct dependency of the site target.
enum OpenGraphFetcher {
    /// Fetches OGP metadata for the given page URL.
    static func fetch(_ urlString: String) async throws -> OpenGraphMetadata {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url, timeoutInterval: 15)
        // Some hosts serve a stripped page to unknown user agents.
        request.setValue(
            "Mozilla/5.0 (Macintosh) AppleWebKit/605.1.15 (KHTML, like Gecko) PortfolioBuilder/1.0",
            forHTTPHeaderField: "User-Agent")

        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
            throw URLError(.badServerResponse)
        }

        guard let html = String(data: data, encoding: .utf8) ?? String(data: data, encoding: .isoLatin1) else {
            throw URLError(.cannotDecodeContentData)
        }

        return parse(html)
    }

    /// Extracts `og:title` and `og:image` from an HTML string.
    static func parse(_ html: String) -> OpenGraphMetadata {
        var metadata = OpenGraphMetadata()

        let metaTag = /<meta\b[^>]*>/.ignoresCase()
        let propertyAttribute = /(?:property|name)\s*=\s*(?:"([^"]*)"|'([^']*)')/.ignoresCase()
        let contentAttribute = /\bcontent\s*=\s*(?:"([^"]*)"|'([^']*)')/.ignoresCase()

        for match in html.matches(of: metaTag) {
            let tag = html[match.range]

            guard let property = tag.firstMatch(of: propertyAttribute),
                  let content = tag.firstMatch(of: contentAttribute) else { continue }

            let name = String(property.output.1 ?? property.output.2 ?? "").lowercased()
            let value = decodeEntities(String(content.output.1 ?? content.output.2 ?? ""))

            // Prefer the first occurrence of each tag.
            switch name {
            case "og:title" where metadata.title == nil:
                metadata.title = value
            case "og:image", "og:image:url", "og:image:secure_url":
                if metadata.image == nil { metadata.image = value }
            default:
                break
            }
        }

        return metadata
    }

    /// Decodes the handful of HTML entities that commonly appear in meta content.
    private static func decodeEntities(_ text: String) -> String {
        text
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&#39;", with: "'")
            .replacingOccurrences(of: "&apos;", with: "'")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&amp;", with: "&")
    }
}
