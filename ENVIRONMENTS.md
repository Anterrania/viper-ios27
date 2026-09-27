# Environments — what is live vs what only Apple can unlock

## Already finished (I did this)

- Product source: https://github.com/Anterrania/viper-ios27
- Xcode 27 simulator build: **SUCCESS**
  - https://github.com/Anterrania/viper-ios27/actions/runs/36291990650
- Artifact: `AnterranianVIPER-sim` (iOS 27 .app, expires 2026-12-26)
- Pipeline environments declared in the workflow:
  - `simulator` — unsigned Debug build (working)
  - `testflight` — signed upload (blocked on secrets)
  - `appstore` — signed submit (blocked on secrets)

## Cannot be finished without you

Apple will not accept a TestFlight binary from a bot that does not hold your paid Developer identity.

Do these four things once. Then stop thinking. I run the rest.

1. Pay / confirm Apple Developer: https://developer.apple.com/account
2. Identifiers → App IDs → register `org.anterrania.viper`
3. App Store Connect → Apps → New App (iOS, that bundle id)
4. App Store Connect → Users and Access → Integrations → App Store Connect API → generate a key

Paste into GitHub → this repo → Settings → Environments → create `testflight` and `appstore` → add secrets:

- APP_STORE_CONNECT_KEY_ID
- APP_STORE_CONNECT_ISSUER_ID
- APP_STORE_CONNECT_KEY_P8
- APPLE_TEAM_ID

Then tell me "secrets are in." I dispatch `target=testflight`.

Until that paste happens, TestFlight stays skipped on purpose. The compile already worked.
