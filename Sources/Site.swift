import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
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
    var url = URL(static: "https://ryomm.com")
    var language: Language = .japanese
    var builtInIconsEnabled = true
    var favicon: URL? { URL(static: "/images/ryommcat.png") }

    var author = "Ryomm / Ryoko Matsusaka"

    let works: [WorkItem]
    var homePage: Home { Home(works: works) }
    var layout = MainLayout()
}
