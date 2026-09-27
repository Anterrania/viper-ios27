import Foundation
import FoundationModels

struct StewardProfile: LanguageModelSession.DynamicProfile {
    var mode: StewardMode
    var state: StewardState

    var body: some LanguageModelSession.DynamicProfile {
        switch mode {
        case .browse:
            Profile {
                BrowseInstructions()
            }
            .reasoningLevel(.light)
            .onActivate {
                await MainActor.run { state.lastLifecycleEvent = "browse active" }
            }
            .onDeactivate {
                await MainActor.run { state.lastLifecycleEvent = "browse inactive" }
            }
        case .inspect:
            Profile {
                InspectInstructions()
            }
            .reasoningLevel(.light)
            .onActivate {
                await MainActor.run { state.lastLifecycleEvent = "inspect active" }
            }
            .onDeactivate {
                await MainActor.run { state.lastLifecycleEvent = "inspect inactive" }
            }
        case .bind:
            Profile {
                BindInstructions()
            }
            .reasoningLevel(.light)
            .onActivate {
                await MainActor.run { state.lastLifecycleEvent = "bind active" }
            }
            .onDeactivate {
                await MainActor.run { state.lastLifecycleEvent = "bind inactive" }
            }
        }
    }
}
