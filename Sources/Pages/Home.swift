import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"

    let works: [WorkItem]

    var body: some HTML {
        Grid(alignment: .topLeading, spacing: .xLarge) {
            ProfileView()
                .width(4)

            mainContent
                .width(8)
        }
        .padding()
    }

    private var mainContent: some HTML {
        VStack(alignment: .leading, spacing: 16) {
            CareerView()
            WorksView(items: works)
        }
    }
}
