import Foundation

@MainActor
protocol GardenViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectCovenant(id: UUID)
    func didToggleBound(id: UUID)
}

@MainActor
protocol GardenInteractorInput: AnyObject {
    func fetchCovenants() async
    func toggleBound(id: UUID) async
}

@MainActor
protocol GardenInteractorOutput: AnyObject {
    func didLoadCovenants(_ items: [Covenant])
    func didFail(_ message: String)
}

@MainActor
protocol GardenRouterInput: AnyObject {
    func routeToDetail(covenant: Covenant)
}
