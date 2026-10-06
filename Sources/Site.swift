import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        // Works need network access (OGP lookups), so resolve them before
        // publishing and hand the result to the site as plain data.
        let works = await WorkResolver.resolve(Work.all)
        var site = PortfolioSite(works: works)

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct PortfolioSite: Site {
    var name = "Ryomm"
    var titleSuffix = " – Portfolio"
    var url = URL(static: "https://ryomm.com")
    var builtInIconsEnabled = true

    var author = "Ryomm / Ryoko Matsusaka"

    let works: [WorkItem]
    var homePage: Home { Home(works: works) }
    var layout = MainLayout()
}
