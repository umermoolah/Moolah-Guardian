#!/bin/bash

# Quick script to install and run updated APK with new endpoints

PROJECT_ROOT="/Users/umer/Documents/Moolah-Guardian"
ADB="/Users/umer/Library/Android/sdk/platform-tools/adb"
PACKAGE="com.moolahmobile.moolahmobileguardian"

echo "📦 Installing updated APK with new endpoints..."
echo ""

# Find APK
APK_PATH=$(find "$PROJECT_ROOT/android/app/build/outputs/apk/debug" -name "*.apk" -type f | head -1)

if [ -z "$APK_PATH" ]; then
    echo "❌ APK not found!"
    exit 1
fi

echo "✅ Found APK: $(basename $APK_PATH)"
echo ""

# Get device
DEVICE=$($ADB devices | grep "device$" | head -1 | awk '{print $1}')

if [ -z "$DEVICE" ]; then
    echo "❌ No device connected!"
    exit 1
fi

echo "📱 Device: $DEVICE"
echo ""

# Uninstall old
echo "🗑️  Uninstalling old version..."
$ADB -s "$DEVICE" uninstall "$PACKAGE" > /dev/null 2>&1 || true

# Install new
echo "📥 Installing updated APK..."
$ADB -s "$DEVICE" install -r "$APK_PATH" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "✅ APK installed successfully!"
else
    echo "❌ Installation failed!"
    exit 1
fi

echo ""

# Clear logs
echo "🧹 Clearing old logs..."
$ADB -s "$DEVICE" logcat -c > /dev/null 2>&1

# Launch app
echo "🎮 Launching app..."
$ADB -s "$DEVICE" shell am start -n "$PACKAGE/.MainActivity" > /dev/null 2>&1
sleep 3

echo ""
echo "═════════════════════════════════════════════════════════════════"
echo "✅ APP LAUNCHED WITH UPDATED ENDPOINTS!"
echo "═════════════════════════════════════════════════════════════════"
echo ""
echo "📝 New Base URL: https://api2.moolahmobile.com/api/v1"
echo ""
echo "Updated endpoints:"
echo "  • /guardian/login"
echo "  • /guardian/register"
echo "  • /guardian/refreshTokens"
echo "  • /guardian/send-mobile-otp"
echo "  • /guardian/verifyMobileOtp"
echo ""
echo "Viewing LIVE logs with updated endpoints:"
echo "═════════════════════════════════════════════════════════════════"
echo ""

# Show logs
$ADB -s "$DEVICE" logcat *:S flutter:V 2>/dev/null | while IFS= read -r line; do
    if [[ $line == *"🔴 POST REQUEST"* ]]; then
        echo -e "\033[1;35m$line\033[0m"
    elif [[ $line == *"🔵 GET REQUEST"* ]]; then
        echo -e "\033[1;36m$line\033[0m"
    elif [[ $line == *"✅"* ]] && [[ $line == *"RESPONSE"* ]]; then
        echo -e "\033[1;32m$line\033[0m"
    elif [[ $line == *"Status Code: 200"* ]]; then
        echo -e "\033[1;32m$line\033[0m"
    elif [[ $line == *"Status Code: 4"* ]] || [[ $line == *"Status Code: 5"* ]]; then
        echo -e "\033[1;31m$line\033[0m"
    elif [[ $line == *"📍 URL:"* ]] || [[ $line == *"api/v1"* ]]; then
        echo -e "\033[1;33m$line\033[0m"
    else
        echo "$line"
    fi
done

