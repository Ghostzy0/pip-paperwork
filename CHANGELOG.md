# Changelog

## 0.1.0-alpha.1 — 23 October 2026 — qualification in progress

Initial original macOS PDFKit baseline and Pip edition. Local PDF viewing, selection/search/thumbnails; editable markup and supported form fields; page rotate/move/delete/insert/merge; extraction/split; create-only PDF/image/text exports; optional recovery; English on-device OCR with explicit flattened searchable output. Source-based safety review found and corrected recovery original overwrite, destination replacement races and restored-copy unsaved state.

No stable/parity, notarisation, full PDF compatibility, redaction or signing claims. Actual test/package/publication state is in TESTING and release notes. This entry is not a release receipt.

### Qualification repairs and release scope

Canonical writer now repairs measured PDFKit form values/appearance states, malformed font stream lengths, extracted field trees, explicit flattened hidden forms and the actual starter's orphan text widget. Latest corpus: 31 native tests, seven Go tests and eight independent PDF groups passed; final native GUI remains pending. Public-source export uses an exact reviewed manifest and rejects unexpected files/symlinks/private-context markers. Original Pip appearance source is implemented but not yet compiled/reviewed.

Two repositories are planned: a primary-reference recreation with observed workflow/layout evidence, and custom Pip/Plus variants with shared-core traceability. The current generic native layout is not declared faithful. Plus enhancements and releases remain pending.
