import Foundation
import Ignite

struct ProfileView: HTML {
    var body: some HTML {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                Script(file: "/js/ryommcat-jiggle.js")
                Image(decorative: "/images/ryommcat.png")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .style(.cursor, "pointer")
                    .style(.transformOrigin, "50% 100%")
                    .style(.userSelect, "none")
                    .onClick {
                        CustomAction("ryommcatJiggle(this)")
                    }

                Text("Ryomm")
                    .font(.title1)
                Text("iOS app developurr (pun intended)")
                    .font(.body)
            }

            VStack(alignment: .leading, spacing: 4) {
                ForEach(SocialLink.allCases) { link in
                    Link(link.title, target: link.url)
                        .target(.blank)
                        .relationship(.noOpener, .noReferrer)
                        .role(.none)
                        .foregroundStyle(.info)
                }
            }
        }
    }
}
