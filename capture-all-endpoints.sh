#!/bin/bash

#########################################################################
# MOOLAH GUARDIAN - CAPTURE ALL API ENDPOINTS
# Builds app, installs, runs, and captures all API request/response logs
#########################################################################

PROJECT_ROOT="/Users/umer/Documents/Moolah-Guardian"
ANDROID_SDK="/Users/umer/Library/Android/sdk"
ADB="$ANDROID_SDK/platform-tools/adb"
PACKAGE="com.moolahmobile.moolahmobileguardian"

# Output files with timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RAW_LOGS="$PROJECT_ROOT/API_LOGS_RAW_${TIMESTAMP}.txt"
API_DEBUG_DOC="$PROJECT_ROOT/API_ENDPOINTS_DOCUMENTED_${TIMESTAMP}.md"
ENDPOINT_SUMMARY="$PROJECT_ROOT/ENDPOINT_SUMMARY_${TIMESTAMP}.txt"

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  MOOLAH GUARDIAN - CAPTURE ALL API ENDPOINTS                  ║"
echo "║  Build → Install → Run → Capture All API Logs                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# ─── Step 1: Check connected devices ───────────────────────────────────
echo "📱 Step 1: Checking connected devices..."
if ! command -v "$ADB" &>/dev/null; then
    # Try system adb
    ADB=$(which adb 2>/dev/null || true)
    if [ -z "$ADB" ]; then
        echo "❌ adb not found! Make sure Android SDK is installed."
        exit 1
    fi
fi

DEVICES=$($ADB devices 2>/dev/null | grep -v "^List" | grep -v "^$" | grep "device$" | awk '{print $1}')

if [ -z "$DEVICES" ]; then
    echo "❌ No devices connected!"
    echo "   Please connect an Android device or start an emulator."
    echo ""
    echo "   To start emulator:"
    echo "   $ANDROID_SDK/emulator/emulator -list-avds"
    echo "   $ANDROID_SDK/emulator/emulator -avd <avd_name> &"
    exit 1
fi

DEVICE=$(echo "$DEVICES" | head -1)
DEVICE_COUNT=$(echo "$DEVICES" | wc -l | tr -d ' ')
echo "✅ Found $DEVICE_COUNT device(s):"
echo "$DEVICES" | while read d; do
    [ -n "$d" ] && echo "   • $d"
done
echo "   Using: $DEVICE"
echo ""

# ─── Step 2: Build debug APK ───────────────────────────────────────────
echo "🔨 Step 2: Building debug APK..."
echo "   This may take a few minutes..."
cd "$PROJECT_ROOT"

flutter build apk --debug 2>&1 | tail -5

# Find the APK
APK_PATH=""
for possible_path in \
    "$PROJECT_ROOT/build/app/outputs/flutter-apk/app-debug.apk" \
    "$PROJECT_ROOT/build/app/outputs/apk/debug/app-debug.apk" \
    "$PROJECT_ROOT/android/app/build/outputs/apk/debug/app-debug.apk" \
    "$PROJECT_ROOT/android/app/build/outputs/apk/debug/app-debug-v1.apk"
do
    if [ -f "$possible_path" ]; then
        APK_PATH="$possible_path"
        break
    fi
done

# Last resort: find any APK
if [ -z "$APK_PATH" ] || [ ! -f "$APK_PATH" ]; then
    APK_PATH=$(find "$PROJECT_ROOT/build" "$PROJECT_ROOT/android/app/build" -name "*.apk" -type f 2>/dev/null | head -1)
fi

if [ -z "$APK_PATH" ] || [ ! -f "$APK_PATH" ]; then
    echo "❌ Build failed - no APK found!"
    echo "   Try running: flutter build apk --debug"
    echo "   to see detailed errors."
    exit 1
fi
echo "✅ APK built: $APK_PATH"
echo ""

# ─── Step 3: Uninstall old version ─────────────────────────────────────
echo "🗑️  Step 3: Removing old installation..."
$ADB -s "$DEVICE" uninstall "$PACKAGE" > /dev/null 2>&1 || true
echo "✅ Done"
echo ""

# ─── Step 4: Install APK ───────────────────────────────────────────────
echo "📥 Step 4: Installing APK on device..."
INSTALL_OUTPUT=$($ADB -s "$DEVICE" install -r "$APK_PATH" 2>&1)
if [ $? -eq 0 ]; then
    echo "✅ APK installed successfully"
else
    echo "❌ Installation failed!"
    echo "   $INSTALL_OUTPUT"
    exit 1
fi
echo ""

# ─── Step 5: Clear logcat ──────────────────────────────────────────────
echo "🧹 Step 5: Clearing logcat..."
$ADB -s "$DEVICE" logcat -c > /dev/null 2>&1
echo "✅ Logs cleared"
echo ""

# ─── Step 6: Launch app ────────────────────────────────────────────────
echo "🚀 Step 6: Launching app..."
$ADB -s "$DEVICE" shell am start -n "$PACKAGE/.MainActivity" > /dev/null 2>&1
sleep 3
echo "✅ App launched on: $DEVICE"
echo ""

# ─── Step 7: Live capture ──────────────────────────────────────────────
echo "═════════════════════════════════════════════════════════════════"
echo "🔍 LIVE API CAPTURE - ALL ENDPOINTS"
echo "═════════════════════════════════════════════════════════════════"
echo ""
echo "📝 INSTRUCTIONS:"
echo "   1. Walk through the app - trigger every API call"
echo "   2. Try: LOGIN → HOME → CONNECT DEVICE → PROFILE → SETTINGS"
echo "   3. Explore ALL features and screens"
echo "   4. Press Ctrl+C when you're done"
echo ""
echo "📁 Logs saving to: $RAW_LOGS"
echo "═════════════════════════════════════════════════════════════════"
echo ""

# Trap Ctrl+C to run post-processing
trap 'echo ""; echo "⏹️  Stopping capture..."; CAPTURE_DONE=1' INT

# Capture flutter logs with color-coded display
$ADB -s "$DEVICE" logcat *:S flutter:V 2>/dev/null | tee "$RAW_LOGS" | while IFS= read -r line; do
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
    elif [[ $line == *"❌"* ]]; then
        echo -e "\033[1;31m$line\033[0m"
    elif [[ $line == *"📍 URL:"* ]] || [[ $line == *"📤"* ]] || [[ $line == *"📥"* ]] || [[ $line == *"📋"* ]]; then
        echo -e "\033[1;33m$line\033[0m"
    elif [[ $line == *"═══"* ]]; then
        echo -e "\033[0;37m$line\033[0m"
    elif [[ $line == *"flutter"* ]]; then
        echo "$line"
    fi
done

echo ""
echo "═════════════════════════════════════════════════════════════════"
echo "✅ Capture complete! Processing logs..."
echo "═════════════════════════════════════════════════════════════════"
echo ""

# ─── Step 8: Generate documentation ────────────────────────────────────
echo "📊 Generating API documentation..."

POST_COUNT=$(grep -c "🔴 POST REQUEST" "$RAW_LOGS" 2>/dev/null || echo 0)
GET_COUNT=$(grep -c "🔵 GET REQUEST" "$RAW_LOGS" 2>/dev/null || echo 0)
SUCCESS_COUNT=$(grep -c "Status Code: 200" "$RAW_LOGS" 2>/dev/null || echo 0)
ERROR_400=$(grep -c "Status Code: 400" "$RAW_LOGS" 2>/dev/null || echo 0)
ERROR_401=$(grep -c "Status Code: 401" "$RAW_LOGS" 2>/dev/null || echo 0)
ERROR_404=$(grep -c "Status Code: 404" "$RAW_LOGS" 2>/dev/null || echo 0)
ERROR_500=$(grep -c "Status Code: 500" "$RAW_LOGS" 2>/dev/null || echo 0)

{
    echo "# 📊 API ENDPOINTS DOCUMENTED"
    echo ""
    echo "## Capture Report"
    echo "- **Date**: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "- **Device**: $DEVICE"
    echo ""
    echo "---"
    echo ""
    echo "## Summary Statistics"
    echo ""
    echo "| Metric | Count |"
    echo "|--------|-------|"
    echo "| Total API Calls | $((POST_COUNT + GET_COUNT)) |"
    echo "| POST Requests | $POST_COUNT |"
    echo "| GET Requests | $GET_COUNT |"
    echo "| ✅ Successful (200) | $SUCCESS_COUNT |"
    echo "| ❌ Bad Request (400) | $ERROR_400 |"
    echo "| ❌ Unauthorized (401) | $ERROR_401 |"
    echo "| ❌ Not Found (404) | $ERROR_404 |"
    echo "| ❌ Server Error (500) | $ERROR_500 |"
    echo ""
    echo "---"
    echo ""
    echo "## All Unique Endpoints Called"
    echo ""
    echo "### POST Endpoints"
    grep "POST REQUEST" "$RAW_LOGS" 2>/dev/null | grep -oE "https?://[^ ]*" | sort -u | while read url; do
        echo "- \`POST\` $url"
    done
    # Also try extracting from URL lines near POST
    grep -A2 "🔴 POST REQUEST" "$RAW_LOGS" 2>/dev/null | grep "📍 URL:" | sed 's/.*📍 URL: //' | sort -u | while read url; do
        echo "- \`POST\` $url"
    done
    echo ""
    echo "### GET Endpoints"
    grep -A2 "🔵 GET REQUEST" "$RAW_LOGS" 2>/dev/null | grep "📍 URL:" | sed 's/.*📍 URL: //' | sort -u | while read url; do
        echo "- \`GET\` $url"
    done
    echo ""
    echo "---"
    echo ""
    echo "## Base URL"
    echo ""
    echo "- **Production**: \`https://api2.moolahmobile.com\`"
    echo "- **Staging**: \`https://staging.api2.moolahmobile.com\`"
    echo ""
    echo "---"
    echo ""
    echo "## All Known Endpoints (from source code)"
    echo ""
    echo "| Method | Endpoint | Full URL |"
    echo "|--------|----------|----------|"
    echo "| POST | /guardian/login | https://api2.moolahmobile.com/guardian/login |"
    echo "| POST | /guardian/register | https://api2.moolahmobile.com/guardian/register |"
    echo "| POST | /refreshTokens | https://api2.moolahmobile.com/refreshTokens |"
    echo "| POST | /send-mobile-otp | https://api2.moolahmobile.com/send-mobile-otp |"
    echo "| POST | /verifyMobileOtp | https://api2.moolahmobile.com/verifyMobileOtp |"
    echo "| GET  | /getConnectedKidDevices | https://api2.moolahmobile.com/getConnectedKidDevices |"
    echo "| GET  | /getMSMSMonitoringStatus | https://api2.moolahmobile.com/getMSMSMonitoringStatus |"
    echo "| POST | /enableMSMSMonitoring | https://api2.moolahmobile.com/enableMSMSMonitoring |"
    echo "| GET  | /getWalletEnabled | https://api2.moolahmobile.com/getWalletEnabled |"
    echo "| POST | /enableWallet | https://api2.moolahmobile.com/enableWallet |"
    echo "| GET  | /getAppUsage | https://api2.moolahmobile.com/getAppUsage |"
    echo "| POST | /blacklistApp | https://api2.moolahmobile.com/blacklistApp |"
    echo "| POST | /deleteApp | https://api2.moolahmobile.com/deleteApp |"
    echo "| GET  | /getBlacklistedApps | https://api2.moolahmobile.com/getBlacklistedApps |"
    echo "| GET  | /getNetworkHistory | https://api2.moolahmobile.com/getNetworkHistory |"
    echo "| GET  | /getBlockedUrlsEncryption | https://api2.moolahmobile.com/getBlockedUrlsEncryption |"
    echo "| POST | /blacklistUrl | https://api2.moolahmobile.com/blacklistUrl |"
    echo "| POST | /addBlockedUrl | https://api2.moolahmobile.com/addBlockedUrl |"
    echo "| GET  | /getSingleDeviceDetail | https://api2.moolahmobile.com/getSingleDeviceDetail |"
    echo "| GET  | /getDeviceThreadsEncryption | https://api2.moolahmobile.com/getDeviceThreadsEncryption |"
    echo "| GET  | /getThreadMessagesEncryption | https://api2.moolahmobile.com/getThreadMessagesEncryption |"
    echo "| POST | /parentAppSecurityCheck | https://api2.moolahmobile.com/parentAppSecurityCheck |"
    echo "| POST | /parentKidDeviceConnect | https://api2.moolahmobile.com/parentKidDeviceConnect |"
    echo "| POST | /linkKidByConnectCode | https://api2.moolahmobile.com/linkKidByConnectCode |"
    echo "| GET  | /getBannerAds | https://api2.moolahmobile.com/getBannerAds |"
    echo "| POST | /submitReview | https://api2.moolahmobile.com/submitReview |"
    echo "| POST | /feedback | https://api2.moolahmobile.com/feedback |"
    echo "| POST | /sendActionToDevice | https://api2.moolahmobile.com/sendActionToDevice |"
    echo "| GET  | /getDeviceLocation | https://api2.moolahmobile.com/getDeviceLocation |"
    echo "| POST | /createPaymentIntent | https://api2.moolahmobile.com/createPaymentIntent |"
    echo ""
    echo "---"
    echo ""
    echo "## Complete Captured Logs"
    echo ""
    echo "\`\`\`"
    cat "$RAW_LOGS" 2>/dev/null
    echo "\`\`\`"

} > "$API_DEBUG_DOC"

# Create quick endpoint summary
{
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║  ENDPOINT SUMMARY                                             ║"
    echo "║  Date: $(date '+%Y-%m-%d %H:%M:%S')                                      ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Total Calls: $((POST_COUNT + GET_COUNT))"
    echo "POST: $POST_COUNT | GET: $GET_COUNT"
    echo "Success: $SUCCESS_COUNT | Errors: $((ERROR_400 + ERROR_401 + ERROR_404 + ERROR_500))"
    echo ""
    echo "──── Unique POST Endpoints ────"
    grep -A2 "🔴 POST REQUEST" "$RAW_LOGS" 2>/dev/null | grep "📍 URL:" | sed 's/.*📍 URL: //' | sort -u
    echo ""
    echo "──── Unique GET Endpoints ────"
    grep -A2 "🔵 GET REQUEST" "$RAW_LOGS" 2>/dev/null | grep "📍 URL:" | sed 's/.*📍 URL: //' | sort -u

} > "$ENDPOINT_SUMMARY"

echo ""
echo "═════════════════════════════════════════════════════════════════"
echo "📁 FILES CREATED:"
echo "═════════════════════════════════════════════════════════════════"
echo ""
echo "1. 📋 $RAW_LOGS"
echo "   → Complete raw logs from your session"
echo ""
echo "2. 📊 $API_DEBUG_DOC"
echo "   → Formatted API documentation with all endpoints"
echo ""
echo "3. 📝 $ENDPOINT_SUMMARY"
echo "   → Quick reference summary"
echo ""
echo "═════════════════════════════════════════════════════════════════"
echo "✨ Done! Open the .md file to review all captured API calls! ✨"
echo ""

