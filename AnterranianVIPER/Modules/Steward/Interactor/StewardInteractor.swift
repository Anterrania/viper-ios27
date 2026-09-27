import Foundation
import FoundationModels

@MainActor
protocol StewardInteractorInput: AnyObject {
    func send(prompt: String) async
    func setMode(_ mode: StewardMode)
}

@MainActor
protocol StewardInteractorOutput: AnyObject {
    func didReceive(turn: StewardTurn)
    func didFail(_ message: String)
    func didChangeAvailability(_ available: Bool, reason: String)
}

@MainActor
final class StewardInteractor: StewardInteractorInput {
    weak var output: StewardInteractorOutput?
    let appState: StewardState
    private var session: LanguageModelSession?
    private var history: Transcript?

    init(appState: StewardState = StewardState()) {
        self.appState = appState
    }

    func prepare() {
        let model = SystemLanguageModel.default
        switch model.availability {
        case .available:
            rebuildSession()
            output?.didChangeAvailability(true, reason: "Dynamic profile ready · \(appState.mode.rawValue)")
        case .unavailable(let reason):
            output?.didChangeAvailability(false, reason: "Model unavailable: \(reason)")
        @unknown default:
            output?.didChangeAvailability(false, reason: "Model availability unknown.")
        }
    }

    func setMode(_ mode: StewardMode) {
        appState.mode = mode
        rebuildSession()
        output?.didChangeAvailability(true, reason: "Profile \(mode.rawValue) · \(appState.lastLifecycleEvent)")
    }

    func send(prompt: String) async {
        if session == nil { rebuildSession() }
        guard let session else {
            output?.didFail("Apple Intelligence / Foundation Models is not available on this device.")
            return
        }
        output?.didReceive(StewardTurn(role: .user, text: prompt))
        do {
            let response = try await session.respond(to: prompt)
            history = session.transcript
            output?.didReceive(StewardTurn(role: .model, text: response.content))
        } catch LanguageModelSession.GenerationError.exceededContextWindowSize {
            output?.didFail("Context window full. Condensing history.")
            condenseAndRebuild()
        } catch {
            output?.didFail(error.localizedDescription)
        }
    }

    private func rebuildSession() {
        let profile = StewardProfile(mode: appState.mode, state: appState)
        if let history {
            session = LanguageModelSession(profile: profile, history: history)
        } else {
            session = LanguageModelSession(profile: profile)
        }
        session?.prewarm()
    }

    private func condenseAndRebuild() {
        if let transcript = session?.transcript {
            let entries = Array(transcript)
            let kept = [entries.first, entries.last].compactMap { $0 }
            history = Transcript(entries: kept)
        }
        rebuildSession()
    }
}
