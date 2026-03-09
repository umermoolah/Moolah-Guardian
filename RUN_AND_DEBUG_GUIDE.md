# 🚀 RUN APP & DEBUG ALL API ENDPOINTS

## Quick Start - Run This Command:

```bash
bash /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

That's it! The script will:

✅ Build the APK (if needed)
✅ Install on your device  
✅ Launch the app
✅ Capture ALL API calls with full request/response data
✅ Generate comprehensive debug documentation

---

## 📱 What You Do:

While the app is running and showing live logs:

1. **Login** - Try to login to see authentication endpoints
2. **Home Screen** - Navigate and view home data
3. **Profile** - Check profile information
4. **Settings** - Explore settings page
5. **All Features** - Click through everything to trigger APIs

**Every single API call is being captured automatically!**

---

## 🎯 What Gets Logged:

✅ **Request Details**
- HTTP Method (POST/GET)
- Full URL/Endpoint
- Headers (Authorization, Content-Type, etc.)
- Request Body/Payload

✅ **Response Details**
- Status Code (200, 400, 401, 500, etc.)
- Response Body
- Data structure
- Response time

✅ **Complete Flow**
- Timestamp of each call
- Request sequence
- Success/error indicators

---

## 📊 Example Output You'll See:

```
🔴 POST REQUEST - 2026-02-25 10:30:45.123456
📍 URL: https://api2.moolahmobile.com/api/v1/guardian/login
📋 Headers: {
  X-API-VERSION: 0.0.0.1,
  Content-Type: application/json,
  Authorization: Bearer xyz...
}
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

## 📄 Output Files (Auto-Generated):

After you press **Ctrl+C**, you'll get:

### 1. **DEBUG_LOGS_RAW_[timestamp].txt**
- Complete raw logs
- Every single log line captured
- For detailed analysis

### 2. **DEBUG_API_ENDPOINTS_[timestamp].md**
- Formatted markdown document
- All endpoints listed
- Request/response examples
- Statistics
- **Best for sharing & reviewing**

### 3. **ENDPOINT_SUMMARY_[timestamp].txt**
- Quick reference summary
- Endpoint list
- Call counts
- Success/error breakdown

---

## 🎨 Color Legend (Real-Time Display):

```
🔴 POST REQUEST ........... Magenta
🔵 GET REQUEST ........... Cyan
✅ Success (200) ............ Green
❌ Error (4xx/5xx) ............ Red
📍 URL & Headers ............ Yellow
```

---

## 🔍 Debugging Tips:

1. **Check Status Codes**
   - 200 = Success
   - 400 = Bad request (check payload)
   - 401 = Unauthorized (check token)
   - 500 = Server error

2. **Review Request Payloads**
   - Make sure data format is correct
   - Check required fields
   - Verify data types

3. **Check Response Data**
   - Look for tokens in login response
   - Verify data structure
   - Check error messages

4. **Trace API Flow**
   - See which endpoints are called in sequence
   - Identify missing calls
   - Find unexpected requests

---

## 🆘 Troubleshooting:

**Q: Script won't run?**
A: Make sure you have execution permission:
```bash
chmod +x /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

**Q: No devices found?**
A: Connect your Android device or start an emulator

**Q: No logs appearing?**
A: Make sure app is making API calls (try logging in)

**Q: Want to run again?**
A: Just run the script again. New files with timestamps are created each time

---

## ✨ Ready to Debug?

```bash
bash /Users/umer/Documents/Moolah-Guardian/run-and-debug.sh
```

Then explore your app and watch all API calls get captured with full debugging details! 🎯

