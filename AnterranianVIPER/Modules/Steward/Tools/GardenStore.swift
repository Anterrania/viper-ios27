import Foundation

@MainActor
final class GardenStore {
    static let shared = GardenStore()
    private(set) var covenants: [Covenant]

    private init(covenants: [Covenant] = Covenant.seed) {
        self.covenants = covenants
    }

    func listTitles() -> [String] {
        covenants.map { "\($0.title) [\($0.isBound ? "bound" : "unbound")]" }
    }

    func covenant(matching query: String) -> Covenant? {
        let needle = query.lowercased()
        return covenants.first { item in
            item.title.lowercased().contains(needle)
            || item.subtitle.lowercased().contains(needle)
            || item.id.uuidString.lowercased() == needle
        }
    }

    func describe(query: String) -> String {
        guard let item = covenant(matching: query) else {
            return "No covenant matches \(query)."
        }
        return """
        Title: \(item.title)
        Subtitle: \(item.subtitle)
        Bound: \(item.isBound)
        Body: \(item.body)
        """
    }

    @discardableResult
    func setBound(query: String, bound: Bool) -> String {
        guard let index = covenants.firstIndex(where: {
            $0.title.lowercased().contains(query.lowercased())
        }) else {
            return "No covenant matches \(query)."
        }
        let current = covenants[index]
        covenants[index] = Covenant(
            id: current.id,
            title: current.title,
            subtitle: current.subtitle,
            body: current.body,
            symbol: current.symbol,
            isBound: bound
        )
        return "\(current.title) is now \(bound ? "bound" : "unbound")."
    }
}
