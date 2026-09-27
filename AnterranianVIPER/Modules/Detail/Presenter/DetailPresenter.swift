import Foundation
import Observation

@MainActor
@Observable
final class DetailPresenter: DetailViewOutput, DetailInteractorOutput {
    var covenant: Covenant?

    private let interactor: DetailInteractorInput

    init(interactor: DetailInteractorInput) {
        self.interactor = interactor
    }

    func viewDidLoad() {
        interactor.load()
    }

    func didLoad(_ covenant: Covenant) {
        self.covenant = covenant
    }
}
