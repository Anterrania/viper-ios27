# Foundation Models — tools + dynamic profiles

Session is no longer static. `StewardProfile` is a `LanguageModelSession.DynamicProfile`.
Exactly one `Profile` is active. Instructions and tools re-evaluate before each `respond`.

| Mode | Instructions | Tools |
|---|---|---|
| browse | list only | `listCovenants` |
| inspect | quote store | `describeCovenant` + `listCovenants` |
| bind | mutate then confirm | `setCovenantBound` + `listCovenants` |

```swift
let session = LanguageModelSession(profile: StewardProfile(mode: state.mode, state: state))
```

Lifecycle: `onActivate` / `onDeactivate` write into `StewardState`.
Context overflow condenses transcript to first+last entries and rebuilds the session.
