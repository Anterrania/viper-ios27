# Apple developer stack for Anterranian VIPER

## gitpull protocol

```bash
chmod +x scripts/gitpull
export GITS_ROOT=~/gits
./scripts/gitpull viper-ios27
./scripts/gitpull foundation-models-utilities
./scripts/gitpull coreai-models
./scripts/gitpull all
```

HTTPS remotes. No tokens in the script.

## Remotes

| Name | URL |
|---|---|
| viper-ios27 | https://github.com/Anterrania/viper-ios27 |
| foundation-models-utilities | https://github.com/apple/foundation-models-utilities |
| coreai-models | https://github.com/apple/coreai-models |

## On your Mac after Xcode 27 is installed

1. `xcode-select -s /Applications/Xcode.app`
2. File → Add Package Dependencies → both Apple URLs above (CoreAILM product from coreai-models)
3. `xcodegen generate && open AnterranianVIPER.xcodeproj`
4. Run on an Apple Intelligence device

Signing / TestFlight still need the four App Store Connect secrets. Git cannot mint those.
