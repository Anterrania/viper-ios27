import Foundation

@MainActor
final class DetailInteractor: DetailInteractorInput {
    weak var output: DetailInteractorOutput?
    private let covenant: Covenant

    init(covenant: Covenant) {
        self.covenant = covenant
    }

    func load() {
        output?.didLoad(covenant)
    }
}
