import Foundation
import Ignite

struct WorksView: HTML {
    let items: [WorkItem]

    var body: some HTML {
        Text("Works")
            .font(.title2)

        VStack(alignment: .leading, spacing: .medium) {
            Script(file: "/js/works-filter.js")
            HStack(spacing: .small) {
                filterChip(title: "All", key: "all", isSelected: true)
                filterChip(for: .talk)
                filterChip(for: .article)
                filterChip(for: .project)
            }
            .aria(.label, "Filter works by kind")

            ForEach(items) { item in
                WorkCard(item: item)
            }
        }
    }

    private func filterChip(for kind: WorkKind) -> some InlineElement {
        filterChip(title: kind.title, key: kind.rawValue)
    }

    private func filterChip(title: String, key: String, isSelected: Bool = false) -> some InlineElement {
        Button(title) {
            CustomAction("filterWorks(this)")
        }
        .buttonSize(.small)
        .class("rounded-pill", isSelected ? "active" : nil)
        .data("work-filter", key)
        .aria(.pressed, isSelected ? "true" : "false")
        .attribute("style", Self.chipStyle)
    }

    private static let chipStyle = [
        "--bs-btn-color: var(--bs-body-color)",
        "--bs-btn-bg: var(--bs-secondary-bg)",
        "--bs-btn-border-color: transparent",
        "--bs-btn-hover-color: var(--bs-body-color)",
        "--bs-btn-hover-bg: var(--bs-border-color)",
        "--bs-btn-hover-border-color: transparent",
        "--bs-btn-active-color: var(--bs-body-bg)",
        "--bs-btn-active-bg: var(--bs-emphasis-color)",
        "--bs-btn-active-border-color: transparent",
        "--bs-btn-font-weight: 500"
    ].joined(separator: "; ")
}

struct WorkCard: HTML {
    let item: WorkItem

    var body: some HTML {
        if item.url != nil {
            card
                .style(.transition, "background-color 0.2s ease")
                .hoverEffect { effect in
                    effect.style(.backgroundColor, "var(--bs-tertiary-bg)")
                }
                .data("work-kind", item.kind.rawValue)
        } else {
            card
                .data("work-kind", item.kind.rawValue)
        }
    }

    private var card: some HTML {
        Card {
            if let thumbnail = item.thumbnail {
                Grid(spacing: 16) {
                    Image(decorative: thumbnail)
                        .resizable()
                        .frame(maxHeight: 200)
                        .cornerRadius(8)
                        .width(4)

                    details
                        .width(8)
                }
            } else {
                details
            }
        }
    }

    private var details: some HTML {
        VStack(alignment: .leading, spacing: .xSmall) {
            Badge(item.kind.title)
                .role(badgeRole)
                .badgeStyle(.subtle)

            if let url = item.url {
                Text {
                    Link(item.title, target: url)
                        .target(.blank)
                        .role(.none)
                        .relationship(.noOpener, .noReferrer)
                        .class("stretched-link")
                }
                .font(.title5)
            } else {
                Text(item.title)
                    .font(.title5)
            }

            if let description = item.description {
                Text(description)
                    .font(.body)
            }

            Text(item.dateText)
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private var badgeRole: Role {
        switch item.kind {
        case .talk: .primary
        case .article: .success
        case .project: .warning
        }
    }
}
