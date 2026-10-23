# Synthetic R1 PDF corpus

Original test inputs generated for this repository. No customer data, credentials, external app media or genuine signatures.

- `three-pages.pdf`: labelled text and distinct order markers.
- `form.pdf`: canonical AcroForm `/Fields` tree, text widget `customer`, starting `/V` = `Before`, populated normal appearance.
- `controls.pdf`: checkbox `consent`, shared-field radios `delivery`, display/export choices `region`, constrained `short`, password `secret`, and read-only `fixed`.
- `encrypted.pdf`: AES-256 encrypted three-page fixture; test-only user password `paperwork-test`, owner password `synthetic-owner`. These strings are public synthetic fixture values.
- `signature-field.pdf`: unsigned signature widget, for conservative read-only detection only.
- `signature-marker.pdf`: synthetic comment containing `/ByteRange`, for conservative byte-marker detection only.

`generate.py` regenerates the corpus with reportlab and pypdf. Encryption uses randomness, so regenerated encrypted bytes are not a golden hash. Tests compare semantic values and preserve exact per-test input bytes. `verify_outputs.py OUTPUT_DIRECTORY` checks the native saved outputs with pypdf, including the canonical field tree rather than only widget rendering.

Swift tests find these source-adjacent fixtures via `#filePath`; run `bash scripts/test.sh` within the app checkout to build the pinned helper before native tests. Set `PAPERWORK_ENGINE` only when intentionally testing another helper executable. Generated native outputs are copied only when `PAPERWORK_AUDIT_OUTPUT` is set, and should remain outside tracked sources.
