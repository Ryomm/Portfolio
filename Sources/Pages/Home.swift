import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Ryomm / Ryoko Matsusaka"

    let works: [WorkItem]

    var body: some HTML {
        Grid(alignment: .topLeading, spacing: .xLarge) {
            ProfileView()
                .width(4)

            mainContent
                .width(8)
        }
        .padding()
        .attribute("role", "main")
    }

    private var mainContent: some HTML {
		VStack(alignment: .leading, spacing: .xLarge) {
            CareerView()
                .frame(width: .percent(100%))
            WorksView(items: works)
        }
    }
}
