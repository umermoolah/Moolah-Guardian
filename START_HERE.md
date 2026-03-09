# 🎉 MOOLAH GUARDIAN - RUN & DEBUG COMPLETE SETUP

## ✅ Your App is Ready to Run with Full API Debugging!

Everything is configured, built, and tested. You're ready to capture all API endpoints with complete request/response data.

---

## 🚀 **QUICK START - ONE COMMAND:**

```bash
bash /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

That's literally all you need to run!

---

## 📋 **WHAT HAPPENS WHEN YOU RUN IT:**

### Automatic (Script does this):
1. ✅ Finds your Android device
2. ✅ Installs the app
3. ✅ Launches the app
4. ✅ Clears old logs
5. ✅ Starts capturing LIVE API calls

### Your Part (While app runs):
1. 🔐 **Login** to the app
2. 🏠 **Go to Home** screen
3. 👤 **Visit Profile** page
4. ⚙️ **Open Settings**
5. 🎮 **Explore ALL features**

**Every single API call is captured automatically with full details!**

### When Done:
- Press **Ctrl+C**
- Script automatically generates documentation

---

## 📊 **WHAT GETS CAPTURED FOR EACH API CALL:**

### Request Side:
- 🔴 HTTP Method (POST/GET/PUT/DELETE)
- 📍 Full Endpoint URL
- 📋 All Headers (Authorization, Content-Type, X-API-VERSION, etc.)
- 📤 Complete Request Body/Payload

### Response Side:
- 🔢 Status Code (200, 400, 401, 500, etc.)
- 📥 Complete Response Body
- ⏱️ Response Time (in milliseconds)
- ⏰ Timestamp of the call

### Example Output:
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
    "userId": "12345",
    "user": {
      "email": "user@example.com",
      "name": "User Name"
    }
  }
}
```

---

## 🎨 **REAL-TIME COLOR-CODED LOGS:**

While the script runs, you'll see:

```
🔴 POST REQUEST ........... Magenta (API calls sending data)
🔵 GET REQUEST ........... Cyan (API calls fetching data)
✅ Success (200) ............ Green (Successful responses)
❌ Error (4xx/5xx) ............ Red (Failed responses)
📍 URLs & Headers ............ Yellow (Request details)
```

---

## 📁 **OUTPUT FILES GENERATED:**

### 1. `DEBUG_LOGS_RAW_[timestamp].txt`
- Complete raw logs from your session
- Every single log line captured
- For detailed technical analysis

### 2. `DEBUG_API_ENDPOINTS_[timestamp].md` ⭐ **USE THIS ONE**
- Beautiful formatted documentation
- All endpoints organized
- Request/response examples
- Statistics and summary
- Perfect for sharing with team
- Easy to read and review

### 3. `ENDPOINT_SUMMARY_[timestamp].txt`
- Quick reference summary
- All unique endpoints listed
- Call counts and breakdown

---

## 🔍 **WHAT YOU CAN DEBUG:**

✅ **API Requests**
- See exact data being sent
- Verify headers are correct
- Check payloads match requirements

✅ **API Responses**
- View actual data received
- Check response structure
- Verify token/auth data

✅ **Errors**
- Identify failing endpoints
- See exact error messages
- Check error codes (400, 401, 500, etc.)

✅ **Performance**
- Track request/response times
- Identify slow endpoints
- Optimize API calls

✅ **Flow**
- Trace complete API sequence
- See which endpoints called when
- Spot missing API calls

---

## 📱 **BASE URL & ENDPOINTS:**

Your app is configured with:

**Base URL:** `https://api2.moolahmobile.com/api/v1`

**Authentication Endpoints:**
- `POST /guardian/login` - User login
- `POST /guardian/register` - User registration
- `POST /refreshTokens` - Refresh authentication token

**Device Management:**
- `GET /getConnectedKidDevices` - Get synced devices
- `GET /getSingleDeviceDetail` - Device details
- `POST /parentKidDeviceConnect` - Connect device
- `GET /getDeviceLocation` - Device location

**App Management:**
- `GET /getAppUsage` - App usage statistics
- `POST /blacklistApp` - Block an app
- `GET /getBlacklistedApps` - Get blocked apps
- `POST /deleteApp` - Delete app remotely

**And many more...** (see `lib/helper/endpoints.dart` for complete list)

---

## 🆘 **TROUBLESHOOTING:**

### Q: Script won't execute?
```bash
chmod +x /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
bash /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

### Q: Device not found?
- Connect Android device via USB, OR
- Start an Android emulator
- Check: `adb devices`

### Q: No logs appearing?
- Make sure app is making API calls
- Try logging in to trigger requests
- Check app has internet connection

### Q: Want to run again?
- Just run the command again
- New files with timestamps are created each time
- No conflicts with previous runs

---

## 📖 **ADDITIONAL GUIDES:**

- **FINAL_SETUP_COMPLETE.md** - Complete setup documentation
- **RUN_AND_DEBUG_GUIDE.md** - Detailed step-by-step guide
- **SYSTEM_CHECKLIST_COMPLETE.txt** - Full checklist
- **SYSTEM_READY.txt** - Status overview

---

## ✨ **YOU'RE READY!**

Everything is set up. Your app is built. All logging is configured. The capture script is ready.

### Just run:
```bash
bash /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

Then explore your app naturally. The script will capture every API call with complete debugging information!

---

## 🎯 **NEXT STEPS:**

1. **Run the command** shown above
2. **Walk through your app** (login, home, profile, settings)
3. **Click all features** to trigger different APIs
4. **Press Ctrl+C** when done exploring
5. **Check generated files** for documentation

You'll have complete API debugging documentation ready to review! 🚀

---

**Have fun debugging your APIs!** 🎉

