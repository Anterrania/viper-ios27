import Foundation
import FoundationModels

@MainActor
protocol StewardInteractorInput: AnyObject {
    func send(prompt: String) async
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
    private var session: LanguageModelSession?

    func prepare() {
        let model = SystemLanguageModel.default
        switch model.availability {
        case .available:
            session = LanguageModelSession(
                model: model,
                tools: [
                    ListCovenantsTool(),
                    DescribeCovenantTool(),
                    ToggleBoundTool()
                ],
                instructions: """
                You are the Garden steward for Anterranian VIPER.
                Use listCovenants, describeCovenant, and setCovenantBound
                instead of inventing covenant text.
                Keep answers short.
                """
            )
            session?.prewarm()
            output?.didChangeAvailability(true, reason: "On-device model ready.")
        case .unavailable(let reason):
            output?.didChangeAvailability(false, reason: "Model unavailable: \(reason)")
        @unknown default:
            output?.didChangeAvailability(false, reason: "Model availability unknown.")
        }
    }

    func send(prompt: String) async {
        guard let session else {
            output?.didFail("Apple Intelligence / Foundation Models is not available on this device.")
            return
        }
        output?.didReceive(StewardTurn(role: .user, text: prompt))
        do {
            let response = try await session.respond(to: prompt)
            output?.didReceive(StewardTurn(role: .model, text: response.content))
        } catch LanguageModelSession.GenerationError.exceededContextWindowSize {
            output?.didFail("Context window full. Start a new session.")
            prepare()
        } catch {
            output?.didFail(error.localizedDescription)
        }
    }
}
