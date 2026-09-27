import Foundation

struct StewardTurn: Identifiable, Sendable {
    enum Role: String, Sendable {
        case user
        case model
        case system
    }

    let id: UUID
    let role: Role
    let text: String

    init(id: UUID = UUID(), role: Role, text: String) {
        self.id = id
        self.role = role
        self.text = text
    }
}
