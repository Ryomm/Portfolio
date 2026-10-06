import Foundation
import Ignite

struct FooterView: HTML {
    public var body: some HTML {
        VStack(spacing: .small) {
            Script(file: "/js/ryommcat-jiggle.js")
            Image(decorative: "/images/ryommcat.png")
                .resizable()
                .frame(width: 50, height: 50)
                .style(.cursor, "pointer")
                .style(.transformOrigin, "50% 100%")
                .style(.userSelect, "none")
                .onClick {
                    CustomAction("ryommcatJiggle(this)")
                }

            HStack {
                Text("© 2026 Ryomm")
                Text {
                    "Created in Swift with "
                    Link("Ignite", target: URL(static: "https://github.com/twostraws/Ignite"))
                }
            }
            .horizontalAlignment(.center)
        }
        .padding()
        .margin(.top, .xLarge)
    }
}
