import SwiftUI

enum DetailModule {
    @MainActor
    static func build(covenant: Covenant) -> some View {
        let interactor = DetailInteractor(covenant: covenant)
        let presenter = DetailPresenter(interactor: interactor)
        interactor.output = presenter
        return DetailView(presenter: presenter)
    }
}
