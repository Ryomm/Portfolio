import Foundation
import Ignite

struct CareerView: HTML {
    var body: some HTML {
        Text("Career")
            .font(.title2)
        Divider()

        VStack(alignment: .leading, spacing: .medium) {
            careerSection(
                title: "Work Experience",
                items: Career.workExperience)
            careerSection(
                title: "Education",
                items: Career.education)
        }
    }

    private func careerSection(
        title: String, items: [Career]
    ) -> some HTML {
        VStack(alignment: .leading, spacing: .small) {
            Text(title)
                .font(.title3)
            List {
                ForEach(items) { item in
                    careerItem(item)
                }
            }
            .listStyle(.plain)
        }
    }

    private static let careerDateColumnWidth = 160
    private func careerItem(_ item: Career) -> some HTML {
        Section {
            Grid(alignment: .topLeading, spacing: .xSmall) {
                Section {
                    Text(item.time)
                        .font(.body)
                        .frame(width: Self.careerDateColumnWidth)
                        .margin(.bottom, .none)
                }
                .class("col-md-auto")

                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.body)
                    if let description = item.description {
                        Text(description)
                            .font(.xxSmall)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}
