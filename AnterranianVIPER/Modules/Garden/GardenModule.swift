import SwiftUI

enum GardenModule {
    @MainActor
    static func build() -> some View {
        let interactor = GardenInteractor()
        let router = GardenRouter()
        let presenter = GardenPresenter(interactor: interactor, router: router)
        interactor.output = presenter
        return GardenView(presenter: presenter, router: router)
    }
}
