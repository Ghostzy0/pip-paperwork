# Paperwork questions

## What is Pip Paperwork?

An experimental local PDF workspace for Apple silicon Macs. It reads PDFs, adds supported annotations and form values, organises pages and writes separate output files. The original source is MIT licensed; the pinned canonical PDF writer and its dependencies retain their own notices.

## Does it need an account or subscription?

No account, provider key or subscription is required. Runtime uses macOS PDFKit/Vision and a bundled Go/pdfcpu helper. Building downloads a checksum-pinned Go toolchain and locked open-source modules. OCR uses system resources rather than a downloaded model.

## Can it replace PDF Expert or Acrobat?

It implements a bounded set of common PDF workflows with original code. It is unaffiliated with those products and does not claim complete equivalence. It does not redact documents, sign or validate certificates, replace arbitrary existing PDF text, convert Office files or offer cloud document help. See [parity and gaps](../PARITY.md).

## Why must I choose a new filename?

Saving is create-only. This protects both the opened original and existing outputs, including aliases and hardlinks. Reopen an earlier output and save under another name to revise it. Keep your original when using flattened or optimised exports.

## Why is a PDF read-only?

Encrypted, signed or restricted inputs are conservatively protected. An encrypted PDF may be unlocked for reading, but this app will not rewrite it. Signature-marker handling is not cryptographic validation. Unsupported form structures can also refuse a save rather than silently lose interactive data.

## Is OCR editable?

OCR creates a separate flattened searchable PDF. It rasterises the page and places recognised text for search and selection; editable annotations/forms are lost in that output. Recognition can be wrong. Core uses English recognition. Both Plus editions let you choose one language from Vision's current supported list and hide/restore the inspector. Selected chooser, French-output and inspector workflows have passed native checks; broader language accuracy and accessibility remain unverified.

## Which macOS versions and processors work?

The build targets macOS 14+ on Apple silicon. Current native testing used Apple silicon/macOS 27. Older macOS runtime and Intel support are unverified; the build script explicitly supports arm64 only. Local bundles are ad-hoc signed, not notarised.

## Where does recovery live?

Recovery is opt-in and stores document content locally without app-level encryption. Each edition uses a separate Application Support directory. See [privacy and deletion](PRIVACY.md). Turning recovery off does not delete an existing snapshot; use Discard recovery when desired.

## Where are verified results?

[TESTING](../TESTING.md) separates executed checks from pending native/release gates. [Build instructions](../README.md#build-and-try-it), [human workflow](HOW-TO.md), [AI setup](AI-SETUP.md), [provenance](../UPSTREAM.md), [release notes](RELEASE-NOTES.md) and [security reporting](../SECURITY.md) are maintained with the source. No rating, download count or compatibility guarantee is implied.
