# Native design decisions

23 October 2026. Before theming, preserve the functional AppKit baseline. Pip edition will follow the project-local supplied guide; this document records the adaptation, not the full private reference.

- Three regions: page thumbnails, dominant PDF canvas, document annotations/form inspector. Consistent 16-point outer edges, 8/12/16/24 spacing, clear filename and saved/unsaved state. PDF content remains the focus.
- Paper ink/white default with system dark appearance and optional Oat; grey selections, ink primary save/open action. Original small decorative pebble character; no reserved source or exact canonical geometry claim.
- Native AppKit menus, file pickers, text fields, focus rings, system font and PDF accessibility are deliberate macOS adaptations. Svelte components/web breakpoints/Phosphor fonts are not copied. Desktop minimum window will be measured; this app does not claim phone layouts.
- All controls perform real operations or are disabled. Recovery off by default; opt-in storage copy is explained. Read-only/encrypted state states the reason. OCR describes irreversible flattening in its separate output and offers Stop.
- High-frequency selection/zoom/page/keyboard actions are immediate. No idle display loop. Pip may acknowledge an actual completed save once; reduced motion uses a still state. Functional completion never waits for animation.
- Status is a single accessible native announcement. Native dialogs keep fields, confirmation and Escape/focus behaviour. Synthetic sample labelled throughout. No decorative account/provider controls.

## Implemented Pip appearance layer · 23 October 2026

- `PaperworkEdition` resolves `PaperworkEdition` from the app bundle, with `--baseline`, `--pip`, `--baseline-plus` and `--pip-plus` command-line overrides. Unbundled use defaults to the plain baseline. Plus is edition identity only until matched enhancements are implemented and accepted.
- Pip uses original AppKit colors derived from the guide's Paper and Oat light/dark anchors, with system appearance as the default and native View-menu choices for theme and mode. Baseline keeps its native appearance. `PaperworkDataDirectory` selects the recovery subdirectory; edition-specific fallback names keep each variant's recovery separate.
- A small custom pebble drawing uses theme ink and canvas colors. It remains still at rest. A save or recovery-enable success can trigger one short, interruptible 3-point hop; Reduce Motion and the checked Pause Pip menu item suppress it. There are no Pip timers or idle frames.
- AppKit's menus, alerts, fields, PDF selection and native panels remain the interaction layer. Command-Z/Shift-Command-Z in a text field routes to the field editor's undo manager; elsewhere the existing document undo stack remains active.

Pending: actual baseline/Pip renders, normal/dark/Oat and window-size checks, keyboard/VoiceOver evidence, independent Pip UI review/fix/retest, and compilation of the current source. No runtime or accessibility acceptance is claimed from these source changes.
