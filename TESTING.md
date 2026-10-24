# Testing and evidence

24 October 2026. Experimental source; no published binary or full reference-parity claim. Core/Pip share one document engine; Plus adds a runtime-supported OCR language picker and inspector collapse. Native modal Undo remains a release gate until the current package is tested.

## Current local run

The current shared engine passed **36 XCTest cases, zero failures**, in2.218seconds on Apple silicon/macOS27. Both formerly failing OCR cases now pass: the historical Core en-GB request remains independent of Vision’s advertised language list, and cancellation after page1 returns no partial PDF. A new focused regression proves Core does not query that list while explicit Plus selections still validate it. The French scanned-token case ran and passed on this host; that single clean fixture is not an accuracy benchmark or a claim for every language.

All four source variants built and passed strict local ad-hoc signature checks. Parent checks confirmed distinct edition/bundle/data/version identities, matching original icon/starter resources and no tested private-home-path markers in stripped executables. Core version0.1.0-alpha.1; Plus0.2.0-alpha.1. These are local package results, not downloadable release receipts or notarisation.

| Edition | Executable SHA-256 |
| --- | --- |
| Neutral Core | `4926b9ff5e7f128722d73977fd56e157553ac5ee9d7e14f8929e0c3c02faa33a` |
| Pip Core | `b6fe87005e09ddac1af740da9a30fa5dc78afcd635bc456a8869f1751bb82122` |
| Neutral Plus | `68c23dfa5f1312f5157404b25801987b90b193cc5a4e4486e3fe4cb4353cd78d` |
| Pip Plus | `6d42f0996ae5103097c698b38345264e5ca2ea0f9241f5400d7f3e78512a0ddd` |

## Native finding and current fix

Earlier actual packaged testing found Command-Z in Find could change PDF data. Search typing Undo/Redo and document Undo/Redo routing subsequently passed separately. Modal form typing Undo still failed on the previous package despite a dedicated native undo manager. A headless AppKit probe proved native text history registration and direct undo/redo work; this did not reproduce a visible modal event loop.

The newest fix temporarily routes the modal’s Undo/Redo menu actions through native nil-target responder-chain dispatch and restores document routing on exit. Its actual keyboard/menu, submit/cancel and search/document retest is pending independent review. Earlier failures remain relevant; compilation does not close this finding.

Actual earlier synthetic save/reopen retained three pages, the edited contact, highlight and page rotation; save cancellation preserved the working copy. The canonical bundled starter also saved and reopened with its edited field. Those are bounded identified-package observations, not acceptance of the newest packages or arbitrary PDFs.

## Cross-OS and independent checks

Previous independent reviews exercised seven Go helper tests and eight pypdf output groups, including canonical form/button state, page operations, flattening, protected inputs/aliases and create-only saves. Newly changed OCR/UI code has a separate source review with no confirmed critical/high defect; native verification remains separate.

The first hosted macOS14 run39890474271 failed on a programmatic starter font defect and a legitimate ancillary Popup assertion. The corrected canonical starter and annotation assertions passed32nativecases plus Go tests and both Core packages in [run39891343307](https://github.com/Ghostzy0/pip-paperwork/actions/runs/39891343307). Current36-case/four-variant source has not yet passed a minimum-OS hosted run or GUI test.

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

Current modal/native acceptance; actual Paper/Oat/dark, keyboard/window/accessibility/reduced-motion checks; Plus language-picker/cancel and inspector-width/focus checks; representative CPU/RSS/latency; actual PDF Expert workflow/layout comparison; final public clean-clone builds and package review. Minimum-macOS GUI, VoiceOver, large-document responsiveness, Intel, genuine cryptographic signatures and notarisation are unverified. Ad-hoc signatures establish local package integrity only.
