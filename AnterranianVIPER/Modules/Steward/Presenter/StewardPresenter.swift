import Foundation
import Observation

@MainActor
@Observable
final class StewardPresenter: StewardInteractorOutput {
    var turns: [StewardTurn] = []
    var draft: String = ""
    var isBusy: Bool = false
    var availabilityText: String = "Checking model…"
    var isAvailable: Bool = false

    private let interactor: StewardInteractorInput

    init(interactor: StewardInteractorInput) {
        self.interactor = interactor
    }

    func onAppear() {
        if let prep = interactor as? StewardInteractor {
            prep.prepare()
        }
    }

    func send() {
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, !isBusy else { return }
        draft = ""
        isBusy = true
        Task {
            await interactor.send(prompt: text)
            isBusy = false
        }
    }

    func didReceive(turn: StewardTurn) {
        turns.append(turn)
    }

    func didFail(_ message: String) {
        turns.append(StewardTurn(role: .system, text: message))
    }

    func didChangeAvailability(_ available: Bool, reason: String) {
        isAvailable = available
        availabilityText = reason
    }
}
