struct Career {
    let time: String
    let title: String
    let description: String?

    static let workExperience: [Self] = [
        .init(
            time:  "2023.10 - Present",
            title: "KINTOテクノロジーズ株式会社",
            description: "iOS App Developer"),
        .init(
            time: "2021.4 - 2023.9",
            title: "ニフティ株式会社",
            description: nil)
    ]

    static let education: [Self] = [
        .init(
            time: "2021.3",
            title: "東京都市大学メディア情報学部情報システム学科 卒",
            description: nil)
    ]
}
