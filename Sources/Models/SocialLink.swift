import Foundation

enum SocialLink: CaseIterable {
    case x
    case github
    case speakerDeck
    case speakerDeckKTC
    case note
    case zenn

    var title: String {
        switch self {
        case .x: "X"
        case .github: "GitHub"
        case .speakerDeck: "SpeakerDeck1"
        case .speakerDeckKTC: "SpeakerDeck2"
        case .note: "note"
        case .zenn: "Zenn"
        }
    }

    var url: String {
        switch self {
        case .x: "https://x.com/__ryomm"
        case .github: "https://github.com/Ryomm"
        case .speakerDeck: "https://speakerdeck.com/ryomm"
        case .speakerDeckKTC: "https://speakerdeck.com/ktcryomm"
        case .note: "https://note.com/ryommm"
        case .zenn: "https://zenn.dev/ryomm"
        }
    }
}
