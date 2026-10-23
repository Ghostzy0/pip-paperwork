#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
[[ "$(uname -s)" == Darwin && "$(uname -m)" == arm64 ]] || { echo "This build supports Apple silicon macOS only"; exit 2; }
edition="${1:-baseline}"
case "$edition" in
  baseline) name='Paperwork Baseline'; identifier='io.github.ghostzy0.paperwork.baseline'; data_directory='PaperworkBaseline';;
  pip) name='Pip Paperwork'; identifier='io.github.ghostzy0.paperwork'; data_directory='PipPaperwork';;
  *) echo 'Use baseline or pip. Plus packages are not qualified yet.'; exit 2;;
esac
./Engine/build.sh
swift build -c release --jobs 2
app="build/$name.app"
mkdir -p "$app/Contents/MacOS" "$app/Contents/Resources"
bin_path="$(swift build -c release --show-bin-path)"
cp "$bin_path/Paperwork" "$app/Contents/MacOS/Paperwork"
# SwiftPM release products retain debug records, including the builder's home path.
# Strip only the copied release executable, before signing the completed bundle.
xcrun strip -S -x "$app/Contents/MacOS/Paperwork"
if LC_ALL=C grep -aqE '(/Users/|/home/)' "$app/Contents/MacOS/Paperwork"; then
  echo 'Release executable still contains a private home path; refusing package' >&2
  exit 1
fi
cp LICENSE "$app/Contents/Resources/LICENSE"
cp -R Engine/Notices "$app/Contents/Resources/ThirdPartyNotices"
cp Engine/build/canonical-pdf "$app/Contents/Resources/canonical-pdf"
codesign --force --sign - "$app/Contents/Resources/canonical-pdf"
cat > "$app/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict>
<key>CFBundleIdentifier</key><string>$identifier</string><key>CFBundleName</key><string>$name</string><key>CFBundleDisplayName</key><string>$name</string><key>CFBundleExecutable</key><string>Paperwork</string><key>CFBundlePackageType</key><string>APPL</string><key>CFBundleShortVersionString</key><string>0.1.0</string><key>CFBundleVersion</key><string>1</string><key>LSMinimumSystemVersion</key><string>14.0</string><key>NSHighResolutionCapable</key><true/><key>PaperworkEdition</key><string>$edition</string><key>PaperworkReleaseVersion</key><string>0.1.0-alpha.1</string><key>PaperworkDataDirectory</key><string>$data_directory</string><key>CFBundleDocumentTypes</key><array><dict><key>CFBundleTypeName</key><string>PDF document</string><key>CFBundleTypeRole</key><string>Viewer</string><key>LSItemContentTypes</key><array><string>com.adobe.pdf</string></array></dict></array></dict></plist>
PLIST
codesign --force --sign - "$app"
codesign --verify --deep --strict "$app"
printf 'Built %s\n' "$app"
