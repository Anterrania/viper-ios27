# Create product → deploy

## What is already automated

On every push to `main`, GitHub Actions on the `xcode-27` runner:

1. Installs XcodeGen
2. Generates `AnterranianVIPER.xcodeproj`
3. Builds for the **iPhone 18 Pro / iOS 27** simulator
4. Uploads the `.app` as an artifact

Manual deploy to TestFlight is the same workflow with `deploy=true`.

Repo: https://github.com/Anterrania/viper-ios27
Actions: https://github.com/Anterrania/viper-ios27/actions

## Secrets you must add (App Store only)

GitHub → repo → Settings → Secrets and variables → Actions:

| Secret | What it is |
|---|---|
| `APP_STORE_CONNECT_KEY_ID` | App Store Connect API key id |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer UUID |
| `APP_STORE_CONNECT_KEY_P8` | Full contents of the `.p8` key |
| `APPLE_TEAM_ID` | 10-character team id |
| `MATCH_PASSWORD` | Only if you later add Match for certs |

Create the API key in App Store Connect → Users and Access → Integrations → App Store Connect API.

## Create the App Store product (one-time, human)

Apple will not let a bot invent a paid developer account.

1. Enroll at https://developer.apple.com/programs/ ($99/year)
2. App Store Connect → Apps → **+** → New App
   - Name: Anterranian VIPER
   - Bundle ID: `org.anterrania.viper` (register it first in Certificates, Identifiers & Profiles)
   - SKU: `anterrania-viper-001`
   - Platform: iOS
3. Add an app icon (1024²) before review
4. Privacy policy URL (required)

## Fire the automated deploy

1. Put the secrets in GitHub
2. Actions → **iOS 27 — build and optional TestFlight** → Run workflow
3. Set **deploy** to true
4. Wait for TestFlight processing, then add internal testers

Until those secrets exist, only the simulator build job runs. That is still a real Xcode 27 compile on GitHub-hosted macOS — no local Mac required for CI.
