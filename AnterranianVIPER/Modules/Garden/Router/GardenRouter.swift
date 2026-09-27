import SwiftUI

@MainActor
final class GardenRouter: GardenRouterInput, ObservableObject {
    @Published var path = NavigationPath()
    @Published var detail: Covenant?

    func routeToDetail(covenant: Covenant) {
        detail = covenant
        path.append(covenant)
    }
}
