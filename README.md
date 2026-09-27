# Anterranian VIPER — iOS 27

VIPER (View · Interactor · Presenter · Entity · Router) sample app generated for **iOS 27 / Xcode 27 / Swift 6**.

Repo: https://github.com/Anterrania/viper-ios27

## Why this is not a 2017 VIPER clone

Classic GitHub VIPER samples (Alamofire + Storyboards + Swift 4) will not build cleanly on Xcode 27. This project keeps the five-layer contract and updates the seams:

| Layer | iOS 27 implementation |
|---|---|
| **View** | SwiftUI + `@Observable` presenter binding |
| **Interactor** | async/await use-cases, no UIKit |
| **Presenter** | Presentation state only |
| **Entity** | `Sendable` value types |
| **Router** | NavigationPath / sheet destinations |

Deployment target: **iOS 27.0**.

## Open in Xcode 27

You need a Mac with **Xcode 27** (ships with the iOS 27 SDK).

### Fastest path (recommended)

1. Clone:

```bash
git clone https://github.com/Anterrania/viper-ios27.git
cd viper-ios27
```

2. In Xcode 27: **File → New → Project → iOS → App**
   - Product Name: `AnterranianVIPER`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Minimum Deployments: **iOS 27**

3. Delete the stock `ContentView.swift`.
4. Drag the `AnterranianVIPER/` source folder into the project (copy items if needed).
5. Set the app entry to `AnterranianVIPERApp`.
6. Select an **iPhone 18 / iOS 27** simulator and Run (⌘R).

### XcodeGen path

If you have [XcodeGen](https://github.com/yonaskolb/XcodeGen):

```bash
brew install xcodegen
cd viper-ios27
xcodegen generate
open AnterranianVIPER.xcodeproj
```

## Architecture map

```
GardenView  ──user tap──►  GardenPresenter  ──use case──►  GardenInteractor
     ▲                            │                              │
     │                     view model                    Covenant entities
     │                            │                              │
     └─────── bind state ─────────┘                              │
                                                                 ▼
                                                         GardenRouter
                                                    (push Detail module)
```

One screen = one module. The Detail module is assembled only when the router asks for it.

## Modules

- **Garden** — list of covenants (the home screen)
- **Detail** — single covenant

## Build notes for iOS 27

- Swift 6 concurrency: entities are `Sendable`, interactors are isolated.
- No storyboards.
- No CocoaPods. No Alamofire. Foundation + SwiftUI only.
- Liquid Glass-friendly materials (`ultraThinMaterial`) so the UI sits on iOS 26/27 chrome without fighting it.

This environment cannot compile an `.ipa` — Apple requires Xcode on macOS. The sources are the buildable app.
