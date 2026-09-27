import Foundation

@MainActor
final class GardenInteractor: GardenInteractorInput {
    weak var output: GardenInteractorOutput?

    init() {}

    func fetchCovenants() async {
        try? await Task.sleep(for: .milliseconds(180))
        output?.didLoadCovenants(GardenStore.shared.covenants)
    }

    func toggleBound(id: UUID) async {
        guard let item = GardenStore.shared.covenants.first(where: { $0.id == id }) else {
            output?.didFail("That covenant is gone, eh.")
            return
        }
        GardenStore.shared.setBound(query: item.title, bound: !item.isBound)
        output?.didLoadCovenants(GardenStore.shared.covenants)
    }
}
