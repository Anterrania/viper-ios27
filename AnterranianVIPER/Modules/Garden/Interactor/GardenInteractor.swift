import Foundation

@MainActor
final class GardenInteractor: GardenInteractorInput {
    weak var output: GardenInteractorOutput?

    private var store: [Covenant]

    init(store: [Covenant] = Covenant.seed) {
        self.store = store
    }

    func fetchCovenants() async {
        try? await Task.sleep(for: .milliseconds(180))
        output?.didLoadCovenants(store)
    }

    func toggleBound(id: UUID) async {
        guard let index = store.firstIndex(where: { $0.id == id }) else {
            output?.didFail("That covenant is gone, eh.")
            return
        }
        let current = store[index]
        store[index] = Covenant(
            id: current.id,
            title: current.title,
            subtitle: current.subtitle,
            body: current.body,
            symbol: current.symbol,
            isBound: !current.isBound
        )
        output?.didLoadCovenants(store)
    }
}
