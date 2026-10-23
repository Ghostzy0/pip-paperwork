# Pip Paperwork — local PDF reader and markup for macOS

A local PDF workspace for macOS. Read, mark up and organise documents, then save a separate copy while keeping your original.

**Experimental alpha in qualification.** This is an original app, inspired by common PDF workflows. It is not a PDF Expert or Acrobat fork and is not affiliated with either product. The tested plain native foundation precedes final GUI acceptance and the Pip edition. A separate recreation repository is planned for observed PDF Expert workflow/layout parity; the present neutral layout has not passed that comparison. This custom repository is intended for Pip Core and later matched Neutral Plus/Pip Plus releases. Current source build commands support baseline and Pip only. Native acceptance and release status are recorded in [TESTING](TESTING.md).

## On your Mac

- Read PDFs with page thumbnails, text selection, zoom and search.
- Highlight, underline, strike through, add sticky notes and draw freehand.
- Fill supported form fields; organise pages with rotate, move, delete, insert and merge.
- Extract page ranges or split pages into files. Export text, page PNGs, editable PDF copies, flattened copies and image-optimised copies.
- Recognise English scanned text on-device and export a separate flattened searchable PDF.
- Undo document changes and optionally keep a local recovery copy.

No account, network service, provider key or model download is needed. There is no telemetry or updater. PDF links and embedded remote actions are inert. The app does not provide redaction, certificate signing, arbitrary PDF text editing, Office conversion or full vendor parity.

## Build and try it

Requires an Apple silicon Mac with macOS 14 or newer and Apple's command-line developer tools (`xcode-select --install`, completed by you if missing). Development is tested on Apple silicon/macOS 27; older macOS runtime compatibility remains unverified; this build supports Apple silicon only.

```sh
./scripts/test.sh
./scripts/build.sh baseline
./scripts/build.sh pip
open 'build/Pip Paperwork.app'
```

Use **Open sample** for a synthetic three-page document with a text field. Select text and choose Highlight, add a note, rotate a page, fill the sample field, then Save a copy. Open that output to inspect the changes. The baseline is `build/Paperwork Baseline.app`. Baseline and Pip use distinct bundle identities and recovery locations. Neutral Plus and Pip Plus are planned as separate releases; they are not yet qualified or downloadable.

A local build is ad-hoc signed, not Developer ID signed or notarised. For a downloaded release, macOS may ask you to confirm its source using the normal per-app opening flow. Do not disable Gatekeeper globally. No installer, system extension or background service is required. Delete the app to remove the executable; document and recovery data are separate.

[How to read, annotate and save](docs/HOW-TO.md) · [FAQ](docs/FAQ.md) · [AI setup prompt and verification](docs/AI-SETUP.md) · [Privacy and storage](docs/PRIVACY.md) · [Provenance](UPSTREAM.md) · [Known gaps](PARITY.md) · [Change notes](CHANGELOG.md)

## File safety and limits

The opened PDF is treated as the protected original. Save requires a new `.pdf` filename; existing files, aliases and hardlinks are refused. To revise an earlier export, reopen it and save under another name. Normal saves retain editable annotations/forms where PDFKit supports them. Flattening and OCR are separate exports and lose editable annotations/form controls. Optimisation may change image detail and may not reduce size.

Input is limited to 180 MB and 2,000 pages. OCR is limited to 100 pages and media dimensions of 2,400 PDF points per side; recognition can make mistakes. Encrypted PDFs can be unlocked for reading but cannot be rewritten here. Signature markers/widgets are conservatively treated as read-only; this is not signature verification. Restricted files are not bypassed. Keep backups for important documents and verify saved copies with another reader.

## About

Maintained by [Ghostzy0](https://github.com/Ghostzy0). Original MIT app code, using macOS PDFKit/Vision and the system font. PDFKit/Vision plus the pinned Apache-licensed pdfcpu canonical writer; no model weights. Workflow references: [PDF Expert](https://pdfexpert.com/), [Adobe Acrobat](https://www.adobe.com/acrobat.html), and [Apple PDFKit](https://developer.apple.com/documentation/pdfkit). Trademarks belong to their respective owners. Synthetic screenshots will be added from the actual packaged app after verification.
