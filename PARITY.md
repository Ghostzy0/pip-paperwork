# Workflow parity

25 October 2026. This repository contains original neutral and Pip PDF tools, with matched Plus enhancements. It is not a faithful PDF Expert layout. The separate [Paperwork Replica](https://github.com/Ghostzy0/pip-paperwork-replica) tracks observed reader/layout workflows and its remaining gaps. Neither project is affiliated with its references.

## Reference evidence

PDF Expert for Mac3.13.4/build1177 is the primary workflow reference; Adobe Acrobat is a secondary documented reference. A bounded walkthrough on an authored three-page PDF observed reading, thumbnails/bookmarks, page2 navigation, page overview, search results and contextual annotation controls. Bookmark creation/rename was observed, but persistence was not established. The available reference annotation path remained trial-gated; no trial was activated. Reference annotation creation, save/export/OCR and text-selection behavior therefore remain unverified. Static menu/resource inspection is documentation evidence, not proof that a runtime feature was accessible. Private reference captures are excluded from these repositories.

## Implementation and measured scope

| Workflow | Original implementation | Evidence and remaining limits |
| --- | --- | --- |
| Read/search/thumbnails | Native PDFKit reader, local search and page navigation. | Identified earlier native search and current Core sample workflows passed. Minimum-window/VoiceOver remain open. |
| Markup | Undoable highlight, underline, strikeout, note and freehand annotations. | Earlier engine/persisted-output checks and native highlight/undo/reopen passed. Full graphical coverage on every current configuration is not claimed. |
| Forms and editable save | Controlled supported fields, canonical PDF writer, working-copy edits and create-only save. | Current Neutral/Pip Core sample field/save/reopen passed, with independent output parsing. XFA, calculation/actions and ambiguous rich/hierarchical forms fail closed. |
| Organise pages | Rotate, reorder, delete, insert/merge with bounded undo snapshots. | Engine/page-identity checks and earlier native rotation/save passed. Full graphical merge/reorder flow remains open. |
| Split/extract | Ordered ranges and per-page output in a new folder. | Structural extraction/field preservation checks passed; native split-picker path remains open. |
| Export/optimise | Separate text/PNG, editable/flattened and image-optimised copies. | Engine output/restriction and hidden-field flattening checks passed. Further final GUI export checks remain open. Size reduction is not guaranteed; advanced conversion is absent. |
| OCR | On-device Vision recognition with bounded flattened searchable output. | Both Plus packages passed a synthetic French save/reopen. Both separately passed visible busy/Stop preservation. General accuracy, dense completion and hidden-action activation remain open. |
| Protected inputs | Conservative encrypted/restricted/signed rewrite refusal; password for reading only. | Synthetic policy checks passed. This is not encryption/signing parity or cryptographic signature validation. |
| Undo/recovery | Bounded snapshots, isolated typing/document history, optional local recovery. | Engine checks and the identified modal Undo fix passed. Further recovery-discard GUI checks remain open. |
| Accessibility/resources | Native semantic controls, bounded input/OCR/undo budgets. | AX labels and one earlier Pip idle sample exist. VoiceOver, minimum-size, large-document responsiveness, true peak memory and minimum-OS GUI remain open. |
| Redaction, certificate signing, arbitrary content editing | Excluded. | No drawn-signature or black-rectangle substitute is offered. |

[TESTING.md](TESTING.md) identifies exact source commits, executable hashes, hosts and scenarios. Tests, build/signature verification, actual UI observations and reference comparison establish different things. No full PDF compatibility or 1:1 parity claim follows.

## Edition partition

Neutral Core and Pip Core share baseline behavior and the historical English OCR request. Neutral Plus and Pip Plus add the same two features: select one OCR language from Vision's runtime-supported list, and hide/restore the inspector. Each configuration has a separate bundle/recovery identity; Core and Plus have separate release versions. The generic neutral foundation remains a historical working edition, rather than being relabelled a faithful recreation.

All four source builds share the pinned engine and pass the shared36-case suite and hosted macOS14 builds. Current bounded native checks cover Core sample field/save/reopen, matched Plus French copy/inspector scenarios and matched visible busy Stop preservation. A post-Stop field mutation remains an explicit follow-up in [Issue7](https://github.com/Ghostzy0/pip-paperwork/issues/7). Local packages are ad-hoc signed, not Developer ID signed or notarised.
