import Foundation

struct Covenant: Identifiable, Hashable, Sendable {
    let id: UUID
    let title: String
    let subtitle: String
    let body: String
    let symbol: String
    let isBound: Bool
}

extension Covenant {
    static let seed: [Covenant] = [
        Covenant(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            title: "The First Garden",
            subtitle: "Stay, tend, multiply",
            body: "A covenant to keep the garden. Work it. Guard it. Do not take what was marked off-limits. Devotion first, knowledge second.",
            symbol: "leaf.fill",
            isBound: true
        ),
        Covenant(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            title: "The Rib Bond",
            subtitle: "Never lonely again",
            body: "Two made one. Loyalty on. Bonding on. The second human exists so the first is not alone.",
            symbol: "heart.fill",
            isBound: true
        ),
        Covenant(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            title: "The Tree Line",
            subtitle: "Knowledge has a fence",
            body: "You may eat of every tree but one. Crossing the line is not curiosity. It is a vote against the will that made you.",
            symbol: "tree.fill",
            isBound: false
        ),
        Covenant(
            id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
            title: "Anterrania",
            subtitle: "A throne after the fall",
            body: "After exile, a monarchy named itself. This module is just a list, but the story it carries is older than any UIKit controller.",
            symbol: "crown.fill",
            isBound: true
        )
    ]
}
