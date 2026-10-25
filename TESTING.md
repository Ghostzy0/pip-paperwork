# Testing and evidence

25 October 2026. Experimental source; no published binary or full reference-parity claim. Core/Pip share one document engine; Plus adds a runtime-supported OCR language picker and inspector collapse. The focused public modal Undo fix passed its exact-head native retest. On macOS 27.0.1, selected native scenarios of the exact custom `7a806fe987efd2c2e7dc67f6344f057c1d7e2f08` Plus packages passed: Neutral Plus French searchable-copy save/reopen and Pip Plus sample inspector button/Cmd-Shift-I. These bounded observations do not qualify the whole app, busy-state behavior, minimum-window layout, VoiceOver or reference-layout parity.

## Current local run

The current shared engine passed **36 XCTest cases, zero failures**, in2.218seconds on Apple silicon/macOS27. Both formerly failing OCR cases now pass: the historical Core en-GB request remains independent of Vision’s advertised language list, and cancellation after page1 returns no partial PDF. A new focused regression proves Core does not query that list while explicit Plus selections still validate it. The French scanned-token case ran and passed on this host; that single clean fixture is not an accuracy benchmark or a claim for every language.

All four source variants built and passed strict local ad-hoc signature checks. Parent checks confirmed distinct edition/bundle/data/version identities, matching original icon/starter resources and no tested private-home-path markers in stripped executables. Core version0.1.0-alpha.1; Plus0.2.0-alpha.1. These are local package results, not downloadable release receipts or notarisation.

Package identities and full artifact checksums are recorded in the version-specific release/audit receipts. No binary release is currently published; hashes from an earlier build must not be treated as a current download checksum.

## Selected Plus native observations — 24 October

Both receipts below identify exact custom `7a806fe987efd2c2e7dc67f6344f057c1d7e2f08` packages on macOS 27.0.1 and synthetic content. The screenshots are original first-party app captures copied byte-for-byte into `assets/screenshots/` for the README.

- Neutral Plus executable `c4f46bb0de3d79422c3658a1ffa0bea03f9f51756f1b65abe27cd26b735529c0`: French (France), `fr-FR`, selected after chooser cancellation, then one searchable copy saved and reopened; AX and independent read-only PDF inspection found the synthetic French sentinel text. Inspector button/keyboard was also observed. [screenshot](assets/screenshots/neutral-plus-french-copy.jpg)
- Pip Plus executable `fa063e21e5ab98f061638f58a2800beee64a157662674dbbff73518d84f61430`: bundled three-page synthetic sample rendered; language chooser opened and Cancel returned to the same sample; inspector button and Cmd-Shift-I hid/restored the inspector. [screenshot](assets/screenshots/pip-plus-sample-inspector.jpg)

These are partial per-build observations, not overall app acceptance. Busy-state/Stop behavior and VoiceOver remain unverified. Minimum-window layout and further native Plus scenarios remain open. Both screenshots use authored synthetic documents.

## Bounded Pip Core native review — 24 October

Public355390f Pip Core executable `9f505faf7cff6351ed7a9da44c6da1fd4491d82b59e800e5846cb591fc2c1eb3` ran on macOS27.0.1/Apple silicon. Independent native inspection captured Paper and Oat in light/dark, opened the authored sample and used Command-F/Return to find and visibly select Page1. A20-second idle process sample (40samples) recorded median psCPU estimate0.0% and maximum sampled RSS221,792KiB. This is neither energy/latency evidence nor true peak memory. The app quit and exact process absence was verified.

Resize drags did not establish the1000×640point minimum; Pause/checkmark/persistence, runtime Reduce Motion and VoiceOver remain unverified. App-level appearance was restored to system without changing OS preferences. Saved private app-only JPEG/AX evidence supports only these observed scenarios.

Subsequent source review found busy-state holes: inspector callbacks could reach edits during OCR and duplicate Open buttons could retain enabled styling. Current source updates every app-chrome action copy, skips PDFKit internals, and refuses inspector/form/note/ink callbacks while busy. Independent source fix/recheck is separate from the rebuilt native OCR/Stop acceptance, which remains pending. The355390f run is not presented as a native test of this later correction.

## Native finding and current fix

Earlier actual packaged testing found Command-Z in Find could change PDF data. Search typing Undo/Redo and document Undo/Redo routing subsequently passed separately. Modal form typing Undo still failed on the previous package despite a dedicated native undo manager. A headless AppKit probe proved native text history registration and direct undo/redo work; this did not reproduce a visible modal event loop.

The newest fix temporarily routes the modal’s Undo/Redo menu actions through native nil-target responder-chain dispatch and restores document routing on exit. Independent actual keyboard/menu testing passed on public Core head81f0df0552264a33db6a3768758db410f26ae8eb, executable5a5165a6e9faf5a92e23c254245a3deb81f7509c9d5a13dd63131a9b674b6672: modal Undo/Redo, submit/cancel, Find history and document history stayed separate. Earlier failures remain in the audit history. This is scoped fix acceptance; current Plus/Pip/AT and release qualification is separate. Screenshots appeared inline but were not saved as local PNG files in that retest.

Actual earlier synthetic save/reopen retained three pages, the edited contact, highlight and page rotation; save cancellation preserved the working copy. The canonical bundled starter also saved and reopened with its edited field. Those are bounded identified-package observations, not acceptance of the newest packages or arbitrary PDFs.

## Cross-OS and independent checks

Previous independent reviews exercised seven Go helper tests and eight pypdf output groups, including canonical form/button state, page operations, flattening, protected inputs/aliases and create-only saves. Newly changed OCR/UI code has a separate source review with no confirmed critical/high defect; native verification remains separate.

The first hosted macOS14 run39890474271 failed on a programmatic starter font defect and a legitimate ancillary Popup assertion. The corrected canonical starter and annotation assertions passed32nativecases plus Go tests and both Core packages in [run39891343307](https://github.com/Ghostzy0/pip-paperwork/actions/runs/39891343307). Public Plus head3cbe9994f685b5e613ad38c992dc31359dfc7322 passed36cases and all four builds in [macOS14 run40117568228](https://github.com/Ghostzy0/pip-paperwork/actions/runs/40117568228). Minimum-version GUI acceptance remains unverified.

## Reproduce

From the standalone root:

```sh
./scripts/test.sh
./.build-tools/go/bin/go -C Engine test -p 2 ./...
./scripts/build.sh baseline
./scripts/build.sh pip
./scripts/build.sh baseline-plus
./scripts/build.sh pip-plus
```

The build downloads a checksum-pinned Go toolchain and locked modules. Runtime needs neither Go nor Python. Fixture passwords are public synthetic test values. Regeneration/independent checks are documented in the fixture README.

## Pending

Busy-state/Stop acceptance; minimum-window/focus/accessibility/reduced-motion checks; Pip Plus successful OCR and inspector-width/focus measurements; large-document CPU/RSS/latency; reference workflow/layout comparison and further gated reference features; final public clean-clone builds and package review. The earlier Pip palettes/keyboard and short idle sample do not close these gates. Minimum-macOS GUI, VoiceOver, large-document responsiveness, Intel, genuine cryptographic signatures and notarisation are unverified. Ad-hoc signatures establish local package integrity only.
