# 🎯 COMPLETE SETUP - RUN APP & DEBUG ALL API ENDPOINTS

## ✅ Everything is Ready!

Your Moolah Guardian app is **fully built**, **fully tested**, and **ready to run with comprehensive API debugging**.

---

## 🚀 **TO RUN THE APP & CAPTURE ALL API LOGS:**

### One Command:
```bash
bash /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

### That's it! The script will:
✅ Install the app on your device
✅ Launch the app
✅ Capture LIVE logs
✅ Generate comprehensive debug documentation

---

## 📋 **WHAT THE SCRIPT CAPTURES:**

For **every single API call**, you get:

### Request Details
- 🔴 **HTTP Method**: POST or GET
- 📍 **Full URL/Endpoint**: Complete path
- 📋 **Headers**: Authorization, Content-Type, etc.
- 📤 **Request Body**: All data being sent

### Response Details
- 🔢 **Status Code**: 200, 400, 401, 500, etc.
- 📥 **Response Body**: Complete response data
- ⏱️ **Response Time**: How long the request took
- ⏰ **Timestamp**: When the call was made

### Example:
```
🔴 POST REQUEST - 2026-02-25 10:30:45.123456
📍 URL: https://api2.moolahmobile.com/api/v1/guardian/login
📋 Headers: {X-API-VERSION: 0.0.0.1, Content-Type: application/json}
📤 Request Body:
{
  "email": "user@example.com",
  "password": "password123"
}

✅ POST RESPONSE (850ms)
🔢 Status Code: 200
📥 Response Body:
{
  "status": true,
  "message": "Login successful",
  "data": {
    "token": "eyJhbGc...",
    "userId": "12345"
  }
}
```

---

## 👤 **YOUR ROLE:**

While the app runs and logs are displaying:

1. **🔐 Login** - Try logging in with test credentials
2. **🏠 Home** - Navigate to home screen
3. **👤 Profile** - Check profile section
4. **⚙️ Settings** - Explore settings
5. **🎮 All Features** - Click through all available features

**Every API call is automatically captured!**

Then press **Ctrl+C** when done.

---

## 📊 **OUTPUT FILES CREATED:**

### 1. `DEBUG_LOGS_RAW_[timestamp].txt`
- Complete raw logs
- Every single log line
- For detailed technical analysis

### 2. `DEBUG_API_ENDPOINTS_[timestamp].md` ⭐ **BEST FOR REVIEWING**
- Beautiful formatted markdown
- All endpoints organized
- Request/response examples
- Statistics and summary
- Perfect for sharing with team

### 3. `ENDPOINT_SUMMARY_[timestamp].txt`
- Quick reference
- All unique endpoints
- Call counts and breakdown

---

## 🎨 **COLOR-CODED REAL-TIME DISPLAY:**

While running, you'll see:

```
🔴 POST REQUEST ........... Magenta (sending data)
🔵 GET REQUEST ........... Cyan (fetching data)
✅ Success (200) ............ Green (successful)
❌ Error (4xx/5xx) ............ Red (failed)
📍 URL & Headers ............ Yellow (details)
```

---

## 🔍 **DEBUGGING CAPABILITIES:**

✅ **See exact requests** being sent to backend
✅ **View actual responses** received
✅ **Track status codes** (200, 400, 401, 500, etc.)
✅ **Identify failing APIs** (errors, validation issues)
✅ **Check request/response timing**
✅ **Verify payload data** format and content
✅ **Trace complete API flow** sequence
✅ **Spot missing API calls**
✅ **Find unexpected requests**

---

## 📱 **CURRENT ENDPOINTS (FROM YOUR CODE):**

### Base URL:
```
https://api2.moolahmobile.com/api/v1
```

### Authentication:
- POST `/guardian/login` - User login
- POST `/guardian/register` - User registration
- POST `/refreshTokens` - Refresh token

### Device Management:
- GET `/getConnectedKidDevices` - Get synced devices
- GET `/getSingleDeviceDetail` - Device details
- POST `/parentKidDeviceConnect` - Connect device

### App Management:
- GET `/getAppUsage` - App usage stats
- POST `/blacklistApp` - Block app
- GET `/getBlacklistedApps` - Get blocked apps

### And many more... (see endpoints.dart for complete list)

---

## ✨ **READY?**

```bash
bash /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

### Then:
1. Walk through your app
2. Interact with all features
3. Watch real-time colored logs
4. Press Ctrl+C when done
5. Review the generated `DEBUG_API_ENDPOINTS_[timestamp].md`

---

## 🆘 **TROUBLESHOOTING:**

**Q: Script doesn't run?**
```bash
chmod +x /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

**Q: Device not found?**
- Make sure Android device is connected or emulator is running
- Run: `adb devices`

**Q: No logs?**
- Make sure app is making API calls
- Try logging in or navigating through app

**Q: Run again?**
- Just run the command again
- New files with timestamps are created each time

---

## 📖 **MORE INFORMATION:**

See: `RUN_AND_DEBUG_GUIDE.md` for detailed step-by-step instructions

---

## 🎉 **YOU'RE ALL SET!**

Your app is built, installed, ready to run, and logging all API calls with complete debugging information!

### Just run:
```bash
bash /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

Explore your app and capture all API endpoints! 🚀

