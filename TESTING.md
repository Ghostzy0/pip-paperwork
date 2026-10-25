# Verification and open gates

25 October 2026. Experimental source with selected packaged workflows verified; no stable release, full PDF compatibility or reference-parity claim. All four configurations share the document engine and source pin.

## Source and package identities

Runtime source [`7a806fe987efd2c2e7dc67f6344f057c1d7e2f08`](https://github.com/Ghostzy0/pip-paperwork/commit/7a806fe987efd2c2e7dc67f6344f057c1d7e2f08) passed a fresh source checkout, 36 tests, four production builds and strict local ad-hoc signature/resource checks. [Hosted macOS 14 CI](https://github.com/Ghostzy0/pip-paperwork/actions/runs/40122871029) also passed. Later documentation/screenshot head [`872acd4`](https://github.com/Ghostzy0/pip-paperwork/commit/872acd44bfec7c51e0ce55c02ff6e6a7e879d819) passed [CI](https://github.com/Ghostzy0/pip-paperwork/actions/runs/40166683806); its runtime inputs are unchanged.

| Package | Release version | Executable SHA-256 |
| --- | --- | --- |
| Paperwork Baseline | 0.1.0-alpha.1 | `d47eaec178acc689bd6a261ed8de3223ce5c1fd11ffa5a9812f49f97c11a9225` |
| Pip Paperwork | 0.1.0-alpha.1 | `18300d08df1f6bb17e0a615cc6e7d5f582d4689ce72d95ac5c926ad6e31030eb` |
| Paperwork Plus | 0.2.0-alpha.1 | `c4f46bb0de3d79422c3658a1ffa0bea03f9f51756f1b65abe27cd26b735529c0` |
| Pip Paperwork Plus | 0.2.0-alpha.1 | `fa063e21e5ab98f061638f58a2800beee64a157662674dbbff73518d84f61430` |

The bundles have distinct identities/recovery locations, original edition icons, the canonical sample PDF and third-party notices. Runtime needs neither Go nor Python. Executable hashes identify tested local packages; downloadable ZIP checksums belong to their release assets. Ad-hoc signing is not Developer ID signing or notarisation.

## Selected native observations — 24–25 October

These scenarios used authored synthetic documents on Apple silicon/macOS 27.0.1. Saved JPEG/AX evidence was independently reviewed. Apps quit normally and exact executable process absence was verified after each slice.

| Edition | Observed result | Limits |
| --- | --- | --- |
| Neutral Core and Pip Core | Each opened the three-page sample, edited its contact, saved a separate copy and reopened the edited value. Independent PDF parsing verified both three-page outputs; all nine captures were reviewed. | No arbitrary-PDF or minimum-window acceptance. |
| Neutral Plus | Language chooser Cancel, `fr-FR` searchable-copy save/reopen, inspector button and Cmd-Shift-I passed. Output parsing found the authored French sentinel. | One language/fixture is not an accuracy benchmark. |
| Pip Plus | Sample render, language chooser Cancel, inspector button/Cmd-Shift-I, and a separate `fr-FR` searchable-copy save/reopen passed. Output parsing found the French sentinel. | No general OCR or language-coverage claim. |
| Both Plus editions, separately — earlier dense Stop slice | On an authored 73-page PDF, edited contact and unsaved state were present before OCR. At observed page32/73, visible Open PDF/Edit field were disabled and Stop was available. Stop reported that it kept the working copy; edited contact and unsaved state remained, output was empty and input hash unchanged. Eight captures from that earlier slice were reviewed. | OCR was deliberately stopped. No post-Stop mutation was driven in this slice. Hidden/menu action copies were source-reviewed, not separately activated. |
| Both Plus editions, separately — post-Stop edit follow-up | On separate working copies of the same authored 73-page input, visible Open PDF/Edit field were disabled and Stop was available at Pip page24/73 and Neutral page23/73. After Stop, the visible contact field could be changed to `POSTSTOP25 Pip` and `POSTSTOP25 Neutral`; AX showed Unsaved changes. No output was produced, both working-copy input hashes stayed unchanged, and normal quit discarded only the synthetic copies. All eight captures from this follow-up were reviewed. | This verifies a visible field mutation after Stop only; it does not show a save, OCR output or OCR completion. Hidden/menu action copies remain source-reviewed rather than separately activated. |

The dense input was 62,141,842 bytes, SHA-256 `6a723b1d13a8a72536579e414d8bfa64a4d1865c5a36a1939d7764c13dd5c904`. It is separate from an earlier 33-page attempt that finished before busy state was observed. That earlier attempt is not a Stop pass. See [Issue7](https://github.com/Ghostzy0/pip-paperwork/issues/7#issuecomment-6395981306).

## Selected Plus native observations — 24 October

README screenshots are byte-for-byte first-party captures from the packages above, using synthetic documents: [Neutral Plus French copy](assets/screenshots/neutral-plus-french-copy.jpg), [Pip Plus inspector](assets/screenshots/pip-plus-sample-inspector.jpg). The later checks above extend those bounded examples.

## Fixes and earlier evidence

The canonical sample repaired a measured macOS14 font defect. Earlier tests failed before that correction; the repaired sample passed subsequent CI. The [modal Undo correction](https://github.com/Ghostzy0/pip-paperwork/pull/2) passed independent actual per-key typing Undo/Redo, Return/Escape, Find and document-history isolation on executable `5a5165a6e9faf5a92e23c254245a3deb81f7509c9d5a13dd63131a9b674b6672` at source `81f0df0`. This is identified earlier-build evidence, rather than a new full-app test of every package above.

Earlier independent engine checks exercised seven Go tests, eight PDF-output groups and targeted adversarial helper/exporter cases, covering canonical forms/appearance, page operations, flattening, protected inputs/aliases and create-only saves. These checks do not prove compatibility with every PDF.

Earlier Pip Core source `355390f`/executable `9f505faf7cff6351ed7a9da44c6da1fd4491d82b59e800e5846cb591fc2c1eb3` passed actual Paper/Oat light/dark and keyboard-search inspection. A 20-second/40-sample idle process recording measured median estimated CPU0.0% and maximum sampled RSS221,792KiB. This is not energy/latency, true peak memory or a measurement of the later packages. Resize attempts did not establish the native minimum size; motion and VoiceOver remain unverified.

## Reproduce

```sh
./scripts/test.sh
./.build-tools/go/bin/go -C Engine test -p 2 ./...
./scripts/build.sh baseline
./scripts/build.sh pip
./scripts/build.sh baseline-plus
./scripts/build.sh pip-plus
```

The first helper build downloads a checksum-pinned Go toolchain and locked modules. Fixture passwords are public synthetic values. See the fixture README for regeneration and independent output checks.

## Open limits

Activation of hidden/menu action copies while busy; minimum-window, keyboard-only, VoiceOver and runtime reduced-motion behavior; general OCR accuracy/large-document completion, latency and peak resources; further graphical export/merge/recovery workflows; Intel and macOS14 GUI acceptance remain unverified. French output, deliberate dense Stop preservation and a separate visible post-Stop field mutation are distinct completed scenarios. The post-Stop edit did not save or produce OCR output. No cryptographic-signature, secure-redaction or notarisation claim is made.

This custom UI is separate from the original [reader recreation](https://github.com/Ghostzy0/pip-paperwork-replica), whose source/native evidence and reference gaps are documented in its own repository.
