import Foundation
import Observation

@MainActor
@Observable
final class StewardState {
    var mode: StewardMode = .browse
    var lastToolName: String = ""
    var lastLifecycleEvent: String = ""
}
