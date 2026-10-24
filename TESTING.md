# Testing and evidence

23 October 2026. Experimental qualification in progress. Custom source is public, with no downloadable binary or full reference parity claim. The corrected canonical starter passes 32 native cases on macOS 14 CI and local macOS 27, and its actual packaged save/reopen passed. Modal input typing Undo remains open until the newest fix is retested; Pip UX, Plus and reference fidelity remain pending.

## Executed baseline checks

Independent functionality review exercised the shared native engine on Apple silicon with macOS 27 / Swift 6.4. The latest repaired baseline passed **31 XCTest cases**, **7 Go helper tests**, and **8 independent pypdf groups**. These include source/alias preservation, create-only output, annotation and canonical form persistence, undo/redo, page operations, extraction, explicit flattening, encrypted/signature-marker policy, recovery and bounded searchable OCR. The production starter now has its own regression: search, highlight, text-field edit, page rotation, save and reopen. The packaged executable tested by the reviewer has SHA-256 `371eefab9453509b3c151160291f2de4b42d5fcc0042fcb654eadae96fbbc670`.

These checks exposed and repaired real PDFKit serialization defects: stale checkbox/radio values and appearance states, missing embedded-font stream lengths, lost field trees after extraction, a hidden form tree after flattening, and the starter's orphan text widget. Independent Poppler renders of the corrected synthetic outputs emitted no PDF warnings. This is bounded corpus evidence, not universal PDF compatibility.

Independent Luna hands-on review of that exact repaired baseline completed: synthetic save/reopen retained the form value, highlight and second-page rotation, and save cancellation preserved the working copy. R2 FAILED overall because Cmd+Z in Find changed document data rather than the focused query; the form editor also lacked typing undo. Source routing/field-editor undo fixes need a newly identified packaged retest. Earlier native interaction found and corrected inspector alignment, page position after undo, and inline widget edits bypassing the controlled editor. A later walkthrough caught the starter failure and reopened acceptance despite the earlier passing fixtures. Pip appearance source subsequently compiled, packaged and passed the same 31 native tests (2.275 seconds); its executable SHA-256 is `b734fbe53aac723b9428f39ae35f9dcb531aa0e7aef6273385c10e5b193a3c54`. This is source/package regression evidence; actual Pip GUI acceptance and all Plus packages remain pending.

## Reproduce

From the app directory internally, or the root of the standalone export:

```sh
./scripts/test.sh
./.build-tools/go/bin/go -C Engine test -p 2 ./...
./scripts/build.sh baseline
./scripts/build.sh pip
```

The build script downloads a checksum-pinned Go toolchain and locked modules at build time. The packaged app requires neither Go nor Python. Public fixture passwords are synthetic constants, not credentials. See the fixture README for regeneration and independent output verification. The helper tests and native tests require the pinned helper to have been built first, as the test script does.

## Remaining evidence

Actual final baseline/Pip GUI save/reopen, Paper/dark/Oat and minimum-window checks, keyboard focus/undo, recovery discard wrapper and export permissions still need their final native review. The reference installer and signed vendor package have been inspected; reference workflow observation remains pending free installation. Native VoiceOver, large-document responsiveness/peak RSS, macOS 14 runtime, Intel, genuine cryptographic signatures and notarisation remain unverified. Signature fixtures check conservative handling only. Ad-hoc code-sign verification is package integrity evidence, not Developer ID signing or notarisation.

## Cross-OS CI correction in progress

The first public macOS14 run39890474271 failed the exact programmatic tutorial starter because its orphan widget font could not be resolved; it also exposed a legitimate Popup companion to a Text annotation. Current source uses an original canonical three-page starter asset with a real field tree and reproducible generator. The packager copies the same asset to Resources, tests inject its source location into the production loader, and missing-resource failure is tested. Optional Popup is validated against its Text parent while all five logical markup/type/content/ink/remove/undo assertions remain. No helper safety policy is relaxed.

On macOS27, the revised32-case native suite passed3.446seconds and both stripped Core packages built/signed. Hosted macOS14 rerun, actual final bundled sample and modal typing undo need retesting; a local repair is not yet a hosted pass or oldest-OS GUI acceptance.

The canonical-starter correction passed hosted macOS 14 [run39891343307](https://github.com/Ghostzy0/pip-paperwork/actions/runs/39891343307):32nativecases,Go tests andbothCorepackages/strictsignatures. The latestactualNeutralCorestarter saved and reopened three pages with the edited contact. This closes the scoped starter/platform defect, not modaltypingUndo or completeGUI/minimumOS coverage.
