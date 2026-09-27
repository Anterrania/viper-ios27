# Foundation Models Tool calling

Applied Apple `Tool` protocol (iOS 26+) inside VIPER.

The on-device `SystemLanguageModel` gets three tools. It decides when to call them. Tools talk to `GardenStore`, never to SwiftUI.

| Tool name | What the model can do |
|---|---|
| `listCovenants` | Live titles + bound state |
| `describeCovenant` | Full text by title keyword |
| `setCovenantBound` | Bind / unbind by title keyword |

Session lives in `StewardInteractor`. View only binds presenter state.

Needs Apple Intelligence hardware (A17 Pro / M-series and later). Simulator CI still compiles; live tool calls need a supported device.

Open Garden → Steward after Xcode 27 finishes installing.
