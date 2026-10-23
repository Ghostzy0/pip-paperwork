# AI setup

Paste this into your coding assistant after opening a clone of this repository:

> Build Pip Paperwork locally on this Mac using the README and scripts/build.sh. Run the tests, build both baseline and Pip editions, and launch only the Pip edition with its synthetic sample; report the exact results and gaps. Keep personal PDFs untouched and do not install paid services or weaken macOS security.

Commands from the repository root:

```sh
xcode-select -p
swift --version
./scripts/test.sh
./scripts/build.sh baseline
./scripts/build.sh pip
codesign --verify --deep --strict 'build/Pip Paperwork.app'
open 'build/Pip Paperwork.app'
```

Requires Apple silicon macOS 14+ and the Apple developer command-line tools. If tools are missing, the owner completes `xcode-select --install` and any native tool-licence consent. The helper build downloads a checksum-pinned official Go toolchain and locked open-source modules, then caches them locally. No remote shell script, credentials, API/provider subscription or recognition model download is needed. Do not create accounts to build this app.

Verify the real app: Open sample → select a sentence → Highlight → rotate page → edit sample text field → Save a copy under a new name → reopen that output. Compare page count, annotation and field value. Use Undo before saving to check reversibility. Cancel a file picker and verify the working copy remains. OCR output is flattened; test it only on synthetic input and inspect recognition.
