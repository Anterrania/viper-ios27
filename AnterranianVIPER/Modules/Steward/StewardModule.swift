import SwiftUI

enum StewardModule {
    @MainActor
    static func build() -> some View {
        let interactor = StewardInteractor()
        let presenter = StewardPresenter(interactor: interactor)
        interactor.output = presenter
        return StewardView(presenter: presenter)
    }
}
