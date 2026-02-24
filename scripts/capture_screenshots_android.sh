#!/usr/bin/env bash
echo "Done. Screenshots should be in screenshots/android/"

# Optional: pull screenshots from device (integration_test writes to host by default)

flutter test integration_test/screenshot_test.dart --platform=android
echo "Running integration tests and capturing screenshots..."
# Run integration test on the emulator

mkdir -p screenshots/android
# Ensure screenshots dir exists

flutter devices
echo "Waiting for device..."
# Wait for device to be ready

flutter emulators --launch "$EMULATOR_NAME"
echo "Starting emulator $EMULATOR_NAME..."
# Start emulator

fi
  exit 1
  echo "List emulators with: flutter emulators"
  echo "Usage: $0 <emulatorName>"
if [ -z "$EMULATOR_NAME" ]; then
EMULATOR_NAME="$1"
set -euo pipefail
# Usage: ./scripts/capture_screenshots_android.sh <emulatorName>
# Starts an Android emulator (name provided as $1) and runs the Flutter integration test to capture screenshots

