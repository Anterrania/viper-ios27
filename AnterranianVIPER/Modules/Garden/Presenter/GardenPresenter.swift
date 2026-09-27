import Foundation
import Observation

@MainActor
@Observable
final class GardenPresenter: GardenViewOutput, GardenInteractorOutput {
    var title: String = "The Garden"
    var items: [Covenant] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let interactor: GardenInteractorInput
    private let router: GardenRouterInput

    init(interactor: GardenInteractorInput, router: GardenRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        isLoading = true
        errorMessage = nil
        Task { await interactor.fetchCovenants() }
    }

    func didSelectCovenant(id: UUID) {
        guard let item = items.first(where: { $0.id == id }) else { return }
        router.routeToDetail(covenant: item)
    }

    func didToggleBound(id: UUID) {
        Task { await interactor.toggleBound(id: id) }
    }

    func didLoadCovenants(_ items: [Covenant]) {
        self.items = items
        isLoading = false
    }

    func didFail(_ message: String) {
        errorMessage = message
        isLoading = false
    }
}
