# Contributing

Open a focused issue with a reproducible synthetic input, expected result, actual result, macOS version and app version. Do not upload personal, confidential, copyrighted reference captures or credentials. Keep changes in small PRs with regression tests for document/data-safety invariants and actual build results. Preserve source licences and notices.

Run `swift test --jobs 2`, build both editions with `scripts/build.sh`, inspect the packaged app using synthetic content and verify saved outputs with an independent reader. Never call a compile or screenshot end-to-end acceptance. Document unsupported files and unrun platform/accessibility cases. Do not add telemetry, provider charges or remote downloads silently.
