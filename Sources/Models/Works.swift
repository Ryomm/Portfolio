import Foundation

enum WorkKind: String, CaseIterable, Sendable {
    case talk
    case article
    case project

    var title: String {
        switch self {
        case .talk: "Talk"
        case .article: "Article"
        case .project: "Project"
        }
    }
}

enum Work: Sendable {
    case article(url: String, date: String)
    case talk(
        title: String,
        date: String,
        url: String? = nil,
        description: String? = nil,
        thumbnail: String? = nil)
    case project(
        title: String,
        date: String,
        url: String? = nil,
        description: String? = nil,
        thumbnail: String? = nil)

    static let all: [Work] = [
        .article(
            url: "https://engineering.nifty.co.jp/blog/7008",
            date: "2022-06-01"),
        .article(
            url: "https://engineering.nifty.co.jp/blog/13698",
            date: "2022-12-24"),
        .article(
            url: "https://engineering.nifty.co.jp/blog/15769",
            date: "2023-03-01"),
        .article(
            url: "https://engineering.nifty.co.jp/blog/21007",
            date: "2023-09-08"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2024-04-17-SnapshotTest/",
            date: "2024-04-22"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2024-04-26_CreateSnapshotTestRefarenceOnAnySubdirectory/",
            date: "2024-04-26"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2024-08-07-UITextViewRepresentableTaihen/",
            date: "2024-08-07"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2024-08-09-SlackTiger/",
            date: "2024-08-09"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2024-12-04_manabyi/",
            date: "2024-12-04"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2024-12-04_slackcli_blockid/",
            date: "2024-12-05"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2024-12-11-SwiftUI-CustomStyle/",
            date: "2024-12-11"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2024-12-24-myroute-ios-spm/",
            date: "2025-01-20"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2025-04-21-SavingCICreditTips/",
            date: "2025-04-21"),
        .article(
            url: "https://blog.kinto-technologies.com/posts/2025-12-21_tipkit/",
            date: "2025-12-21"),
        .article(
            url: "https://zenn.dev/ryomm/articles/332bf27f8561da",
            date: "2021-06-28"),
        .article(
            url: "https://zenn.dev/ryomm/articles/c6e514efe986d8",
            date: "2023-12-14"),
        .article(
            url: "https://zenn.dev/ryomm/articles/bdd5b0d3b54579",
            date: "2024-12-13"),
        .article(
            url: "https://zenn.dev/ryomm/articles/9c18e83e813317",
            date: "2024-12-18"),
        .article(
            url: "https://zenn.dev/ryomm/articles/11e43ee453c343",
            date: "2025-12-08"),
        .article(
            url: "https://zenn.dev/ryomm/articles/829f21a6e24e05",
            date: "2026-04-22"),
        .talk(
            title: "Bring your app’s core features to users with App Intents とか App Intents 関連の要約",
            date: "2024-06-26",
            url: "https://speakerdeck.com/ryomm/bring-your-apps-core-features-to-users-with-app-intents-tokaapp-intentsguan-lian-noyao-yue",
            description: "Swift愛好会スピンオフ WWDC24セッション要約会",
            thumbnail: nil),
        .talk(
            title: "Slackを使いこなせ！Slack効率3000倍",
            date: "2024-07-05",
            url: "https://speakerdeck.com/ktcryomm/slackwoshi-ikonase-slackxiao-lu-3000bei",
            description: "KTC室町情報共有会 LT大会 七夕スペシャル",
            thumbnail: nil),
        .talk(
            title: "リョムキャットのパーフェクトSwiftネーミング教室",
            date: "2024-08-23",
            url: "https://speakerdeck.com/ktcryomm/riyomukiyatutono-pahuekutoswiftnemingujiao-shi",
            description: "iOSDC Japan 2024 ルーキーズLT",
            thumbnail: nil),
        .talk(
            title: "iOS18でQRコードが表示されなくなった🤷",
            date: "2024-12-06",
            url: "https://speakerdeck.com/ktcryomm/ios18deqrkodogabiao-shi-sarenakunatuta",
            description: "KTC×WED×フェンリル 3社合同イベント",
            thumbnail: nil),
        .talk(
            title: "iOSでQRコード生成奮闘記",
            date: "2025-03-04",
            url: "https://speakerdeck.com/ktcryomm/iosdeqrkodosheng-cheng-fen-dou-ji",
            description: "集まれSwift好き！Swift愛好会 vol.92 @DeNA",
            thumbnail: nil),
        .talk(
            title: "なあ兄弟、 余白の意味を考えてから UI実装してくれ！",
            date: "2025-11-26",
            url: "https://speakerdeck.com/ktcryomm/naaxiong-di-yu-bai-noyi-wei-wokao-etekara-uishi-zhuang-sitekure",
            description: "Mobile Fusion Study @KTC",
            thumbnail: nil),
        .talk(
            title: "TipKitTips",
            date: "2026-02-22",
            url: "https://speakerdeck.com/ktcryomm/tipkittips",
            description: "Hakodate.swift #1",
            thumbnail: nil),
        .talk(
            title: "QRコードの仕様ってn種類あんねん",
            date: "2025-09-20",
            url: "https://speakerdeck.com/ryomm/qrkodonoshi-yang-tutenzhong-lei-annen",
            description: "iOSDC Japan 2025 20分トーク",
            thumbnail: nil),
        .talk(
            title: "巨大モノリシックアプリ モダン化大作戦",
            date: "2026-09-12",
            url: "https://speakerdeck.com/ktcryomm/kyodai-modanka-daisakusen",
            description: "iOSDC Japan 2026",
            thumbnail: nil),
        .project(
            title: "シリアルコードおたすけマン",
            date: "2021-03-20",
            url: nil,
            description: "Yahoo Hack Day 2021 Online",
            thumbnail: "/images/serialcodeHelper.png")
    ]
}

struct WorkItem: Sendable {
    let kind: WorkKind
    let title: String
    let date: Date
    let dateText: String
    let description: String?
    let url: String?
    let thumbnail: String?
}

extension Work {
    static func parseDate(_ text: String) -> (date: Date, display: String) {
        let parts = text.split(separator: "-").compactMap { Int($0) }
        var components = DateComponents()
        components.year = parts.count > 0 ? parts[0] : nil
        components.month = parts.count > 1 ? parts[1] : 1
        components.day = parts.count > 2 ? parts[2] : 1

        guard parts.count >= 1, let date = Calendar(identifier: .gregorian).date(from: components) else {
            print("⚠️ Works: could not parse date \"\(text)\"")
            return (.distantPast, text)
        }

        let display = parts.map { String(format: $0 > 31 ? "%d" : "%02d", $0) }.joined(separator: ".")
        return (date, display)
    }
}
