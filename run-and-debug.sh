#!/bin/bash

#########################################################################
# MOOLAH GUARDIAN - BUILD, RUN & CAPTURE ALL API LOGS WITH DEBUGGING
# Complete system to debug endpoints with request/response data
#########################################################################

PROJECT_ROOT="/Users/umer/Documents/Moolah-Guardian"
ANDROID_SDK="/Users/umer/Library/Android/sdk"
ADB="$ANDROID_SDK/platform-tools/adb"
PACKAGE="com.moolahmobile.moolahmobileguardian"

# Try multiple possible APK locations
APK_PATH=""
for possible_path in \
    "$PROJECT_ROOT/android/app/build/outputs/apk/debug/app-debug-v1.apk" \
    "$PROJECT_ROOT/android/app/build/outputs/apk/debug/app-debug.apk" \
    "$(find $PROJECT_ROOT/android/app/build/outputs -name '*.apk' -type f 2>/dev/null | head -1)"
do
    if [ -f "$possible_path" ]; then
        APK_PATH="$possible_path"
        break
    fi
done

# Output files with timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RAW_LOGS="$PROJECT_ROOT/DEBUG_LOGS_RAW_${TIMESTAMP}.txt"
API_DEBUG_DOC="$PROJECT_ROOT/DEBUG_API_ENDPOINTS_${TIMESTAMP}.md"
ENDPOINT_SUMMARY="$PROJECT_ROOT/ENDPOINT_SUMMARY_${TIMESTAMP}.txt"

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  MOOLAH GUARDIAN - RUN & DEBUG ALL API ENDPOINTS              ║"
echo "║  Capture requests, responses, and detailed logging            ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Check APK exists
echo "📦 Step 1: Checking APK..."
if [ ! -f "$APK_PATH" ]; then
    echo "❌ APK not found at: $APK_PATH"
    echo "   Build might have failed or APK has different name"
    # Try to find it
    FOUND_APK=$(find "$PROJECT_ROOT/android/app/build/outputs/apk/debug" -name "*.apk" -type f | head -1)
    if [ -z "$FOUND_APK" ]; then
        echo "❌ No APK found in build output!"
        exit 1
    fi
    APK_PATH="$FOUND_APK"
    echo "✅ Found APK: $APK_PATH"
else
    echo "✅ APK found: $APK_PATH"
fi
echo ""

# Step 2: Check devices
echo "📱 Step 2: Checking connected devices..."
DEVICES=$($ADB devices 2>/dev/null | grep -v "^List" | grep "device$" | awk '{print $1}')
DEVICE_COUNT=$(echo "$DEVICES" | wc -l)

if [ -z "$DEVICES" ]; then
    echo "❌ No devices connected!"
    echo "   Please connect an Android device or emulator"
    exit 1
fi

echo "✅ Found $DEVICE_COUNT device(s):"
echo "$DEVICES" | while read device; do
    [ -n "$device" ] && echo "   • $device"
done
echo ""

# Step 3: Uninstall old app
echo "🗑️  Step 3: Cleaning up old installation..."
DEVICE=$(echo "$DEVICES" | head -1)
$ADB -s "$DEVICE" uninstall "$PACKAGE" > /dev/null 2>&1 || true
echo "✅ Done"
echo ""

# Step 4: Install APK
echo "📥 Step 4: Installing APK on device..."
$ADB -s "$DEVICE" install -r "$APK_PATH" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ APK installed successfully"
else
    echo "❌ Installation failed!"
    exit 1
fi
echo ""

# Step 5: Clear logs
echo "🧹 Step 5: Clearing logcat..."
$ADB -s "$DEVICE" logcat -c > /dev/null 2>&1
echo "✅ Logs cleared"
echo ""

# Step 6: Launch app
echo "🎮 Step 6: Launching app..."
$ADB -s "$DEVICE" shell am start -n "$PACKAGE/.MainActivity" > /dev/null 2>&1
sleep 3
echo "✅ App launched on: $DEVICE"
echo ""

# Step 7: Capture logs
echo "═════════════════════════════════════════════════════════════════"
echo "🔍 DEBUGGING - LIVE API ENDPOINT LOGS"
echo "═════════════════════════════════════════════════════════════════"
echo ""
echo "📝 INSTRUCTIONS:"
echo "   1. Walk through the app and trigger API calls"
echo "   2. Try LOGIN, HOME, PROFILE, SETTINGS, ALL FEATURES"
echo "   3. Each request/response will be logged with details"
echo "   4. Press Ctrl+C when done to generate documentation"
echo ""
echo "Logs are being captured to: $RAW_LOGS"
echo "═════════════════════════════════════════════════════════════════"
echo ""

# Capture logs with real-time filtering and saving
$ADB -s "$DEVICE" logcat *:S flutter:V 2>/dev/null | tee "$RAW_LOGS" | while IFS= read -r line; do
    # Color-coded display
    if [[ $line == *"🔴 POST REQUEST"* ]]; then
        echo -e "\033[1;35m$line\033[0m"  # Magenta
    elif [[ $line == *"🔵 GET REQUEST"* ]]; then
        echo -e "\033[1;36m$line\033[0m"  # Cyan
    elif [[ $line == *"✅"* ]] && [[ $line == *"RESPONSE"* ]]; then
        echo -e "\033[1;32m$line\033[0m"  # Green
    elif [[ $line == *"Status Code: 200"* ]]; then
        echo -e "\033[1;32m$line\033[0m"  # Green
    elif [[ $line == *"Status Code: 4"* ]] || [[ $line == *"Status Code: 5"* ]]; then
        echo -e "\033[1;31m$line\033[0m"  # Red
    elif [[ $line == *"📍 URL:"* ]] || [[ $line == *"📤"* ]] || [[ $line == *"📥"* ]]; then
        echo -e "\033[1;33m$line\033[0m"  # Yellow
    elif [[ $line == *"flutter"* ]]; then
        echo "$line"
    fi
done

echo ""
echo "═════════════════════════════════════════════════════════════════"
echo "✅ Capture complete!"
echo "═════════════════════════════════════════════════════════════════"
echo ""

# Step 8: Process logs and create documentation
echo "📊 Processing logs and creating documentation..."
echo ""

{
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║  DEBUG REPORT - API ENDPOINTS WITH REQUESTS & RESPONSES        ║"
    echo "║  Generated: $(date '+%Y-%m-%d %H:%M:%S')                                   ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "## 📊 CAPTURED DATA"
    echo ""
    echo "### Summary"
    POST_COUNT=$(grep -c "🔴 POST REQUEST" "$RAW_LOGS" 2>/dev/null || echo 0)
    GET_COUNT=$(grep -c "🔵 GET REQUEST" "$RAW_LOGS" 2>/dev/null || echo 0)
    SUCCESS_COUNT=$(grep -c "Status Code: 200" "$RAW_LOGS" 2>/dev/null || echo 0)
    ERROR_400=$(grep -c "Status Code: 400" "$RAW_LOGS" 2>/dev/null || echo 0)
    ERROR_401=$(grep -c "Status Code: 401" "$RAW_LOGS" 2>/dev/null || echo 0)
    ERROR_OTHER=$(grep -c "Status Code: [45]" "$RAW_LOGS" 2>/dev/null || echo 0)

    echo "- **Total API Calls**: $((POST_COUNT + GET_COUNT))"
    echo "- **POST Requests**: $POST_COUNT"
    echo "- **GET Requests**: $GET_COUNT"
    echo "- **Successful (200)**: $SUCCESS_COUNT"
    echo "- **Bad Request (400)**: $ERROR_400"
    echo "- **Unauthorized (401)**: $ERROR_401"
    echo "- **Other Errors**: $ERROR_OTHER"
    echo ""

    echo "---"
    echo ""
    echo "### All Endpoints Called"
    echo ""

    # Extract unique endpoints
    echo "#### POST Endpoints"
    grep "🔴 POST REQUEST" "$RAW_LOGS" 2>/dev/null | grep "📍 URL:" | sed 's/.*📍 URL: //' | sort -u | while read url; do
        echo "- $url"
    done

    echo ""
    echo "#### GET Endpoints"
    grep "🔵 GET REQUEST" "$RAW_LOGS" 2>/dev/null | grep "📍 URL:" | sed 's/.*📍 URL: //' | sort -u | while read url; do
        echo "- $url"
    done

    echo ""
    echo "---"
    echo ""
    echo "## 🔍 COMPLETE LOG DATA"
    echo ""
    echo "### Raw Captured Logs"
    echo ""
    echo "\`\`\`"
    cat "$RAW_LOGS"
    echo "\`\`\`"

} > "$API_DEBUG_DOC"

# Create endpoint summary
{
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║  ENDPOINT SUMMARY FOR DEBUGGING                               ║"
    echo "║  Date: $(date '+%Y-%m-%d %H:%M:%S')                                      ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    POST_COUNT=$(grep -c "🔴 POST REQUEST" "$RAW_LOGS" 2>/dev/null || echo 0)
    GET_COUNT=$(grep -c "🔵 GET REQUEST" "$RAW_LOGS" 2>/dev/null || echo 0)
    SUCCESS_COUNT=$(grep -c "Status Code: 200" "$RAW_LOGS" 2>/dev/null || echo 0)
    echo "Total Calls: $((POST_COUNT + GET_COUNT))"
    echo "POST: $POST_COUNT | GET: $GET_COUNT"
    echo "Success: $SUCCESS_COUNT"
    echo ""
    echo "Unique POST Endpoints:"
    grep "🔴 POST REQUEST" "$RAW_LOGS" 2>/dev/null | grep "📍 URL:" | sed 's/.*📍 URL: //' | sort -u
    echo ""
    echo "Unique GET Endpoints:"
    grep "🔵 GET REQUEST" "$RAW_LOGS" 2>/dev/null | grep "📍 URL:" | sed 's/.*📍 URL: //' | sort -u

} > "$ENDPOINT_SUMMARY"

echo "✅ Documentation generated!"
echo ""
echo "═════════════════════════════════════════════════════════════════"
echo "📁 FILES CREATED:"
echo "═════════════════════════════════════════════════════════════════"
echo ""
echo "1. 📋 $RAW_LOGS"
echo "   → Complete raw logs from your session"
echo "   → Every request/response with details"
echo ""
echo "2. 📊 $API_DEBUG_DOC"
echo "   → Formatted API debugging documentation"
echo "   → All endpoints, requests, responses"
echo "   → Summary statistics"
echo ""
echo "3. 📝 $ENDPOINT_SUMMARY"
echo "   → Quick summary of all endpoints"
echo "   → Count and breakdown"
echo ""
echo "═════════════════════════════════════════════════════════════════"
echo ""
echo "✨ Ready to debug! Open the .md file to see all API calls! ✨"
echo ""

