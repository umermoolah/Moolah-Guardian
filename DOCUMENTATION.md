# Moolah Guardian - Complete App Documentation

## Table of Contents
1. [Project Overview](#project-overview)
2. [Architecture & Technology Stack](#architecture--technology-stack)
3. [Project Structure](#project-structure)
4. [Key Features](#key-features)
5. [Dependencies & SDKs](#dependencies--sdks)
6. [Application Flow](#application-flow)
7. [Core Controllers](#core-controllers)
8. [API Integration](#api-integration)
9. [Data Management](#data-management)
10. [UI/UX Structure](#uiux-structure)
11. [Security & Encryption](#security--encryption)
12. [Build Configuration](#build-configuration)
13. [Getting Started](#getting-started)
14. [Testing](#testing)

---

## Project Overview

**Project Name:** Moolah Guardian (moolah)  
**Description:** A comprehensive mobile application for parental control and financial monitoring of kids' devices  
**Current Version:** 0.0.1+0  
**Platform:** Cross-platform (iOS, Android, Web, Linux, Windows, macOS)  
**SDK Requirements:** Dart/Flutter >=3.0.2 <4.0.0  
**Status:** Active Development (Private Package)

### Purpose
Moolah Guardian is a parental control application that allows parents to:
- Monitor their children's device activities
- Track app usage and screen time
- Block inappropriate content and URLs
- Control wallet and payment functionality
- Monitor device location
- Manage subscriptions and payments
- Secure parent devices with security checks
- Enable/disable monitoring features

---

## Architecture & Technology Stack

### Framework
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language

### Architecture Pattern
- **GetX Pattern** - State management and routing using GetX package
- **Repository Pattern** - API calls abstraction through repository layer
- **MVC-like Structure** - Controllers handle business logic, Views handle UI

### Key Technologies

#### State Management
- **GetX** (v4.6.5) - Reactive state management and dependency injection

#### Networking & APIs
- **HTTP** (v1.1.0) - HTTP client for API communication
- **Firebase** - Backend services and crashlytics

#### Authentication & Security
- **Google Sign-In** (v6.1.6) - OAuth authentication
- **Fast RSA** (v3.8.6) - RSA encryption
- **Encrypt** (v5.0.3) - Encryption/decryption utilities
- **RSA Encrypt** (v2.0.0) - RSA encryption operations
- **RSA PKCS** (v2.1.0) - PKCS standards implementation
- **PointyCastle** (v3.7.3) - Cryptography library
- **Crypto** (v3.0.3) - Cryptographic operations
- **Crypton** (v2.2.1) - Additional crypto utilities
- **Basic Utils** (v5.7.0) - Utility functions including RSA

#### Analytics & Monitoring
- **Mixpanel** (v2.4.4) - Event tracking and analytics
- **Firebase Crashlytics** (v5.0.5) - Crash reporting
- **OneSignal** (v5.3.4) - Push notifications

#### Payment Processing
- **Flutter Stripe** (v12.1.1) - Stripe payment integration

#### Advertisement
- **IronSource Mediation** (v3.2.0) - Ad network mediation

#### Device & Hardware
- **Device Info Plus** (v12.3.0) - Device information
- **Mobile Scanner** (v7.1.3) - Barcode/QR code scanning
- **Google Maps Flutter** (v2.5.0) - Map integration
- **Video Player** (v2.7.1) - Video playback

#### UI/UX Components
- **Flutter SVG** (v2.0.7) - SVG image rendering
- **Cupertino Icons** (v1.0.2) - iOS-style icons
- **Flutter Rating Bar** (v4.0.1) - Rating component
- **Flutter Toast** (v9.0.0) - Toast notifications
- **WebView Flutter** (v4.4.2) - Web content display
- **Chewie** (v1.7.4) - Video player controls
- **Pinput** (v6.0.1) - PIN input widget
- **Intl Phone Field** (v3.2.0) - International phone number input

#### Utilities
- **Image Size Getter** (v2.1.2) - Get image dimensions
- **Shared Preferences** (v2.2.1) - Local data storage
- **Flutter JS** (v0.8.5) - JavaScript execution in Dart

---

## Project Structure

### Directory Overview

```
moolah-guardian/
├── android/                          # Android native configuration
│   ├── app/                          # Android app module
│   ├── gradle/                       # Gradle build tools
│   └── settings.gradle               # Android build settings
├── ios/                              # iOS native configuration
│   ├── Runner.xcodeproj/             # Xcode project
│   ├── Runner.xcworkspace/           # Xcode workspace
│   └── Podfile                       # CocoaPods configuration
├── lib/                              # Main Dart source code
│   ├── main.dart                     # App entry point
│   ├── controllers/                  # Business logic controllers
│   ├── screens/                      # UI screens
│   ├── helper/                       # Helper utilities and services
│   └── util/                         # Utility functions and constants
├── assets/                           # Static resources
│   ├── images/                       # App images
│   ├── fonts/                        # Custom fonts
│   └── tutorial_video/               # Tutorial videos
├── web/                              # Web platform files
├── linux/                            # Linux platform files
├── windows/                          # Windows platform files
├── macos/                            # macOS platform files
├── test/                             # Unit and widget tests
├── pubspec.yaml                      # Project dependencies
└── analysis_options.yaml             # Linter configuration
```

### Lib Directory Structure

#### Controllers (`lib/controllers/`)
Business logic and state management:
- `advertisementController.dart` - Advertisement handling
- `authController.dart` - Authentication logic
- `baseController.dart` - Base controller with common functionality
- `connectDeviceController.dart` - Device connection logic
- `feedbackController.dart` - Feedback submission
- `homeController.dart` - Home screen logic (main data controller)
- `single_kid_controller.dart` - Individual kid's data management
- `subscription_controller.dart` - Subscription management

#### Screens (`lib/screens/`)
UI pages organized by feature:
- `splash/` - Splash screen on app launch
- `login/` - User login screen
- `signup/` - User registration
- `otp_verification/` - OTP verification
- `forgot_password/` - Password recovery
- `home/` - Main dashboard
- `main_menu_profile/` - User profile
- `onboard/` - Onboarding flow
- `subscription_screen/` - Subscription management
- `sync_device_detail_screen/` - Device syncing details
- `parent_security_check/` - Parent security verification
- `scan_barcode/` - QR/Barcode scanning
- `chat/` - Messaging interface
- `blacklist/` - Blocked apps/URLs management

#### Helper (`lib/helper/`)
Services and utilities:
- `endpoints.dart` - API endpoints configuration
- `network.dart` - HTTP network requests
- `decrypter.dart` - Decryption utilities
- `route_helper.dart` - Navigation routing
- `sharedHelper.dart` - SharedPreferences wrapper
- `models/` - Data models
  - `user_model.dart` - User data model
  - `user_model1.dart` - Alternative user model
  - `kids_model.dart` - Child profile model
  - `device_detail_model.dart` - Device information model
  - `app_usage_model.dart` - App usage statistics
  - `blocked_url_model.dart` - Blocked URL model
  - `thread_model.dart` - Chat thread model
  - `message_model.dart` - Message model
  - `response_model.dart` - API response wrapper
  - `ad_model.dart` - Advertisement model
- `repo/` - Repository layer for API calls
  - `authRepo.dart` - Authentication API
  - `homeRepo.dart` - Home/Dashboard API
  - `singleKidRepo.dart` - Kid-specific API
- `get_di/` - GetX dependency injection setup

#### Util (`lib/util/`)
Constants and reusable components:
- `apptext.dart` - App text constants
- `colors.dart` - Color palette
- `images.dart` - Image asset paths
- `mixpanel_events.dart` - Analytics event tracking
- `customtoast.dart` - Custom toast notifications
- `common_widgets/` - Reusable UI components

---

## Key Features

### 1. Authentication & Authorization
- Email/Password login
- User registration (signup)
- Google OAuth integration
- OTP verification for phone numbers
- Password recovery
- Token-based authentication (Bearer tokens)
- Session management with access & refresh tokens

### 2. Device Monitoring
- Connect kid devices
- Sync device information
- Real-time device detail tracking
- Device location monitoring
- Automated monitoring status checks

### 3. App Management
- View app usage statistics
- Blacklist/block specific applications
- Delete applications remotely
- Get list of blocked apps
- Network history tracking

### 4. Content Filtering
- Block inappropriate URLs
- View blocked URLs list
- Add new URLs to blacklist
- Network monitoring

### 5. Communication Monitoring
- View device threads (chat conversations)
- Read individual thread messages
- Encrypted message retrieval

### 6. Wallet & Payment Control
- Check wallet status
- Enable/disable wallet functionality
- Stripe payment integration
- Subscription management
- Create payment intents

### 7. Security Features
- Parent app security check
- SMS monitoring status management
- Enable/disable SMS monitoring
- Encryption for sensitive data

### 8. Analytics & Engagement
- Mixpanel event tracking
- Crash reporting via Firebase Crashlytics
- Push notifications via OneSignal
- In-app advertisements
- User feedback submission
- App reviews

### 9. User Profile Management
- User profile viewing
- Profile updates
- Multiple kid profiles

---

## Dependencies & SDKs

### Primary Dependencies

```yaml
# UI and Material Design
flutter: sdk
cupertino_icons: ^1.0.2

# State Management & Routing
get: ^4.6.5

# SVG and Graphics
flutter_svg: ^2.0.7

# Scanning
mobile_scanner: ^7.1.3

# Networking
http: ^1.1.0

# Local Storage
shared_preferences: ^2.2.1

# Notifications & UI Feedback
fluttertoast: ^9.0.0

# Forms & Input
intl_phone_field: ^3.2.0

# Device Information
device_info_plus: ^12.3.0

# Analytics
mixpanel_flutter: ^2.4.4

# Firebase
firebase_core: ^4.2.1
firebase_crashlytics: ^5.0.5

# Push Notifications
onesignal_flutter: ^5.3.4

# Authentication
google_sign_in: ^6.1.6

# Advertisements
ironsource_mediation: ^3.2.0

# Encryption & Security
fast_rsa: ^3.8.6
encrypt: ^5.0.3
rsa_encrypt: ^2.0.0
rsa_pkcs: ^2.1.0
basic_utils: ^5.7.0
pointycastle: ^3.7.3
crypto: ^3.0.3
crypton: ^2.2.1

# Maps
google_maps_flutter: ^2.5.0

# Video
video_player: ^2.7.1
chewie: ^1.7.4

# Web
webview_flutter: ^4.4.2

# Forms & Input
flutter_rating_bar: ^4.0.1
pinput: ^6.0.1

# Payments
flutter_stripe: ^12.1.1

# Utilities
flutter_js: ^0.8.5
image_size_getter: ^2.1.2
characters: ^1.4.0
flat_buffers: ^23.5.26

# Testing
test_api: ^0.7.7
```

### Development Dependencies

```yaml
flutter_test: sdk
flutter_lints: ^6.0.0
change_app_package_name: ^1.1.0
```

### Android Configuration

**Build System:** Gradle 8.6.0  
**SDK:**
- Compile SDK: 36
- Min SDK: Flutter default (typically 21)
- Target SDK: 36
- NDK Version: Flutter default

**Kotlin:** 2.1.0  
**Java Version:** 1.8

### iOS Configuration

**CocoaPods Podfile** with Flutter integration  
**Supports deployment on iOS devices**

---

## Application Flow

### 1. App Startup (`main.dart`)

```
main()
  ↓
WidgetsFlutterBinding.ensureInitialized()
  ↓
GetX DI Initialization (get_di.init())
  ↓
SharedPreferences Initialization (Prefs.init())
  ↓
SDK Initialization:
  ├─ Firebase
  ├─ Mixpanel
  ├─ OneSignal
  ├─ IronSource (Ads)
  └─ Stripe
  ↓
Orientation Lock (Portrait only)
  ↓
runApp(MyApp)
```

### 2. SDK Initialization Sequence

**Firebase:**
- Initializes Firebase Core
- Sets up Crashlytics with error handling

**Mixpanel:**
- Project ID: b2c2ea88edf4da993cb3572c6f126f6c
- Tracks automatic events

**OneSignal:**
- App ID: 476bba3d-a3d6-4b7c-b5c2-4eaefdb30bc3
- Requests notification permissions
- Sets up permission observers

**Stripe:**
- Publishable key retrieved and configured
- Ready for payment processing

### 3. Navigation Flow

```
Splash Screen
  ↓
[Is User Logged In?]
  ├─ NO → Login/Signup Flow
  │   ├─ Login
  │   ├─ Signup
  │   ├─ OTP Verification
  │   └─ Subscribe
  │
  └─ YES → Home/Dashboard
       ├─ View Kids
       ├─ Device Management
       ├─ App Blocking
       ├─ URL Filtering
       ├─ Wallet Control
       ├─ Security Check
       └─ Profile
```

### 4. Authentication Flow

```
User Login
  ↓
POST /login (credentials)
  ↓
Response with:
  ├─ Access Token (stored locally)
  ├─ Refresh Token (stored locally)
  ├─ User ID (stored locally)
  └─ User Details
  ↓
Token stored in Prefs
  ↓
Navigate to Home/Subscribe
```


## Flow → API Mapping

This section maps the main user flows (what the user does in the app) to the exact backend API endpoints, and notes the primary controllers and repository functions that call them. Use this as a quick reference when tracing behavior from UI → controller → repo → network.

Base API host: `https://api2.moolahmobile.com` (see `lib/helper/endpoints.dart`)

1) Startup / SDKs
- Flow: App launch and SDK initialization (no backend API call required).
- Files: `lib/main.dart` → `initSDKS()`
- Notes: Mixpanel, OneSignal, Firebase and IronSource are initialized locally. No app-specific backend endpoints called here.

2) Authentication (Login / Signup / OTP / Token refresh)
- Flow: User signs up, logs in, verifies OTP, or refreshes tokens.
- Endpoints used:
  - POST `/login` → `EndPoints.login` (AuthRepo.login) — called by `AuthController.login`
  - POST `/register` → `EndPoints.signUp` (AuthRepo.signup) — called by `AuthController.signup`
  - POST `/send-mobile-otp` → `EndPoints.sendMobileOtp` (AuthRepo.sendOtp) — called by `AuthController.sendOTP`
  - POST `/verifyMobileOtp` → `EndPoints.verifyMobileOtp` (AuthRepo.verifyOtp) — called by `AuthController.verifyOTP`
  - POST `/refreshTokens` → `EndPoints.refreshToken` (AuthRepo.refreshToken) — called by token refresh logic (network retry middleware or `AuthController.refreshToken`)
- Primary files: `lib/controllers/authController.dart`, `lib/helper/repo/authRepo.dart`, `lib/helper/network.dart`

3) Pairing / Connect Device (Parent verification and connect)
- Flow: Parent verifies credentials for a kid device and finalizes connection.
- Endpoints used:
  - POST `/parentAppSecurityCheck` → `EndPoints.parentAppSecurityCheck` (ConnectDeviceRepo.parentSecurityCheck) — called by `ConnectDeviceController.parentSecurityCheck`
  - POST `/parentKidDeviceConnect` → `EndPoints.parentKidDeviceConnect` (ConnectDeviceRepo.parentKidDeviceConnect) — called by `ConnectDeviceController.parentKidDeviceConnect`
- Primary files: `lib/controllers/connectDeviceController.dart`, `lib/helper/repo/connectDeviceRepo.dart`

4) Dashboard / Get Connected Devices
- Flow: Parent views the list of connected kid devices.
- Endpoint used:
  - GET `/getConnectedKidDevices` → `EndPoints.getSyncedKidDevicesUrl` (HomeRepo.getSyncedKidDevices) — called by `HomeController.getSyncedKidDevices`
- Primary files: `lib/controllers/homeController.dart`, `lib/helper/repo/homeRepo.dart`

5) Device Details & Real‑time Info
- Flow: Parent opens a kid's detail page to load device info, threads, messages and location.
- Endpoints used:
  - GET `/getSingleDeviceDetail` → `EndPoints.getDeviceDetails` (HomeRepo.getDeviceDetails) — `HomeController.getDeviceDetails`
  - GET `/getDeviceThreadsEncryption` → `EndPoints.getDeviceThreads` (HomeRepo.getDeviceThreads) — `HomeController.getDeviceThreads`
  - GET `/getThreadMessagesEncryption` → `EndPoints.getThreadsMessages` (HomeRepo.getThreadMessages) — `HomeController.getThreadMessages`
  - GET `/getDeviceLocation` → `EndPoints.getDeviceLocation` (HomeRepo.getDeviceLocation) — `HomeController.getDeviceLocation`
- Notes: Some endpoints return encrypted payloads; decryption happens via `lib/helper/decrypter.dart` or logic in `HomeController`.

6) App Usage & App Management (Blacklist / Delete)
- Flow: Parent checks app usage and can block or delete apps.
- Endpoints used:
  - GET `/getAppUsage` → `EndPoints.getAppUsageUrl` (HomeRepo.getAppUsage) — `HomeController.getAppUsage`
  - POST `/blacklistApp` → `EndPoints.blacklistAppUrl` (HomeRepo.blacklistApp) — `HomeController.blacklistApp`
  - POST `/deleteApp` → `EndPoints.deleteAppUrl` (HomeRepo.deleteApp) — called by UI actions in blacklist screens
  - GET `/getBlacklistedApps` → `EndPoints.getBlacklistedAppsUrl` (HomeRepo.getBlacklistedApps) — `HomeController.getBlacklistedApps`
- Primary files: `lib/screens/blacklist/blacklist_screen.dart`, `lib/controllers/homeController.dart`, `lib/helper/repo/homeRepo.dart`

7) URL / Content Filtering (Blocked URLs)
- Flow: Parent views and adds blocked URLs.
- Endpoints used:
  - GET `/getBlockedUrlsEncryption` → `EndPoints.getBlacklistUrlsUrl` (HomeRepo.getBlockedUrls) — `HomeController.getBlockedUrls`
  - POST `/addBlockedUrl` → `EndPoints.addBlacklistUrl` (HomeRepo.addBlockedUrl) — `HomeController.blockUrl`
  - (Deprecated) POST `/blacklistUrl` → `EndPoints.blacklistUrl` — may still be referenced in older flows
- Notes: `getBlockedUrls` may return encrypted data. Validate and sanitize URLs client-side before sending.

8) Communication Monitoring (Threads & Messages)
- Flow: Parent reads chat threads/messages synced from the child device.
- Endpoints used:
  - GET `/getDeviceThreadsEncryption` → `EndPoints.getDeviceThreads` (HomeRepo.getDeviceThreads) — `HomeController.getDeviceThreads`
  - GET `/getThreadMessagesEncryption` → `EndPoints.getThreadsMessages` (HomeRepo.getThreadMessages) — `HomeController.getThreadMessages`
- Files: `lib/screens/chat/*`, `lib/controllers/homeController.dart`, `lib/helper/repo/homeRepo.dart`
- Notes: Messages are often returned encrypted and are decrypted before display.

9) SMS Monitoring (MSMS)
- Flow: Parent checks SMS monitoring status or enables SMS monitoring.
- Endpoints used:
  - GET `/getMSMSMonitoringStatus` → `EndPoints.getMSMSMonitoringStatus` (HomeRepo.getMSMSMonitoringStatus) — `HomeController` or related controller
  - POST `/enableMSMSMonitoring` → `EndPoints.enableMSMSMonitoring` (HomeRepo.enableMSMSMonitoring) — `HomeController` or relevant controller
- Notes: SMS monitoring requires permissions and is privacy-sensitive; ensure legal compliance.

10) Remote Actions / Send Commands
- Flow: Parent sends commands to the child device (e.g., lock, request update).
- Endpoint used:
  - POST `/sendActionToDevice` → `EndPoints.sendActionToDevice` (HomeRepo.sendActionToDevice) — `HomeController.sendActionToDevice`
- Notes: Commands are queued on backend and delivered when child device is online.

11) Location / Find Device
- Flow: Parent requests a device location update or views last known location.
- Endpoint used:
  - GET `/getDeviceLocation` → `EndPoints.getDeviceLocation` (HomeRepo.getDeviceLocation) — `HomeController.getDeviceLocation`
- Files: `lib/screens/sync_device_detail_screen/*`, `lib/controllers/homeController.dart`

12) Wallet / Enable Wallet
- Flow: Parent queries wallet availability and enables wallet if supported.
- Endpoints used:
  - GET `/getWalletEnabled` → `EndPoints.getWalletStatus` (HomeRepo.getWalletStatus) — `HomeController.getWalletStatus`
  - POST `/enableWallet` → `EndPoints.enableWalletUrl` (HomeRepo.enableWallet) — `HomeController.enableWallet`

13) Subscriptions & Payments (Stripe)
- Flow: Parent purchases subscription or checks subscription status.
- Endpoints used:
  - POST `/createPaymentIntent` → `EndPoints.createSubscription` (SubscriptionController.purchaseSubscription → Network.post) — returns `clientSecret` used by Stripe SDK
- Files: `lib/controllers/subscription_controller.dart`, server side should create payment intents securely and return clientSecret

14) Ads / Banners
- Flow: App fetches banner or ad configuration for display.
- Endpoint used:
  - GET `/getBannerAds` → `EndPoints.getBannerAds` (AdRepo.getBannerAds) — used by `AdvertisementController`
- Files: `lib/controllers/advertisementController.dart`, `lib/helper/repo/adRepo.dart`

15) Feedback & Reviews
- Flow: Parent submits feedback or an app review.
- Endpoints used:
  - POST `/feedback` → `EndPoints.feedback` (FeedbackRepo.submitFeedback) — `FeedbackController.submitFeedback`
  - POST `/submitReview` → `EndPoints.submitReview` (FeedbackRepo.submitReview) — `FeedbackController.submitReview`

16) Misc / Feature checks
- GET `/getMSMSMonitoringStatus` → check SMS monitoring
- GET `/getNetworkHistory` → `EndPoints.getNetworkHistoryUrl` (HomeRepo.getNetworkHistory) — network history view

---

## Core Controllers

### 1. AuthController

**Purpose:** Manages user authentication and registration  
**Key Properties:**
- `user: UserModel` - Current user data
- `user1: UserModel1` - Alternative user model
- `emailGlob, passwordGlob` - Login credentials
- `fullNameGlob, phoneGlob, phoneWithoutCC, countryCode` - Registration data
- `dobGlob, dobGlobDateTime` - Date of birth

**Key Methods:**
- `login(email, password)` - User login
- `signup(...)` - User registration
- `sendOTP(phone)` - Send OTP for verification
- `verifyOTP(otp)` - Verify OTP
- `googleSignIn()` - Google OAuth login
- `logout()` - User logout
- `refreshToken()` - Refresh authentication tokens

**Extends:** `BaseController`

### 2. HomeController

**Purpose:** Manages main dashboard and device monitoring  
**Key Data:**
- Kids list
- Device details
- App usage statistics
- Blocked URLs
- Chat threads and messages
- Device location

**Key Methods:**
- `getSyncedKidDevices()` - Fetch connected kid devices
- `getDeviceDetails(deviceId)` - Get device information
- `getAppUsage(deviceId)` - Get app usage statistics
- `getBlacklistedApps(deviceId)` - Fetch blocked apps
- `getBlockedUrls(deviceId)` - Fetch blocked URLs
- `blacklistApp(deviceId, appId)` - Block an app
- `blockUrl(deviceId, url)` - Block a URL
- `getDeviceThreads(deviceId)` - Get chat threads
- `getThreadMessages(threadId)` - Get messages in thread
- `getDeviceLocation(deviceId)` - Get device GPS location
- `sendActionToDevice(action)` - Send remote command

**Encryption/Decryption:** Uses RSA and AES encryption for sensitive data

**Extends:** `BaseController`

### 3. AdvertisementController

**Purpose:** Manages in-app advertisements  
**Key Methods:**
- `init()` - Initialize IronSource ads
- `loadBannerAd()` - Load banner advertisement
- `optionalAdWidget()` - Display ad widget

**Extends:** `BaseController`

### 4. SubscriptionController

**Purpose:** Manages user subscriptions and payments  
**Key Methods:**
- `getSubscriptionStatus()` - Check subscription status
- `createPaymentIntent(amount)` - Initiate Stripe payment
- `updateSubscription(plan)` - Update subscription plan

**Extends:** `BaseController`

### 5. ConnectDeviceController

**Purpose:** Manages device pairing and connection  
**Key Methods:**
- `scanQRCode()` - Scan device QR code
- `connectDevice(deviceCode)` - Establish device connection
- `syncDeviceDetails(deviceId)` - Sync device information

**Extends:** `BaseController`

### 6. FeedbackController

**Purpose:** Manages user feedback submission  
**Key Methods:**
- `submitFeedback(feedbackText)` - Submit user feedback
- `submitReview(rating, review)` - Submit app review

**Extends:** `BaseController`

### 7. SingleKidController

**Purpose:** Manages individual kid's data and monitoring  
**Key Methods:**
- `getKidDevices(kidId)` - Get kid's devices
- `monitorKid(kidId)` - Monitor specific kid

**Extends:** `BaseController`

### 8. BaseController

**Purpose:** Base class for all controllers  
**Common Properties:**
- `isLoading: bool` - Loading state
- `message: String` - Status messages
- `error: String` - Error messages

**Common Methods:**
- `update()` - Update GetX state

---

## API Integration

### Base URL

**Production:** `https://api2.moolahmobile.com`  
**Staging:** `https://staging.api2.moolahmobile.com` (commented out)

### Authentication Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| POST | `/login` | User login |
| POST | `/register` | User registration |
| POST | `/refreshTokens` | Refresh access token |
| POST | `/send-mobile-otp` | Send OTP to phone |
| POST | `/verifyMobileOtp` | Verify OTP |

### Device Monitoring Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/getConnectedKidDevices` | Get synced kid devices |
| GET | `/getSingleDeviceDetail` | Get device details |
| GET | `/getDeviceLocation` | Get device location |
| POST | `/parentKidDeviceConnect` | Connect kid device |

### App Management Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/getAppUsage` | Get app usage statistics |
| POST | `/blacklistApp` | Block an app |
| POST | `/deleteApp` | Delete app remotely |
| GET | `/getBlacklistedApps` | Get blocked apps list |

### Network & URL Filtering Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/getNetworkHistory` | Get network history |
| GET | `/getBlockedUrlsEncryption` | Get blocked URLs |
| POST | `/blacklistUrl` | Block URL (deprecated) |
| POST | `/addBlockedUrl` | Add URL to blacklist |

### Communication Monitoring Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/getDeviceThreadsEncryption` | Get chat threads |
| GET | `/getThreadMessagesEncryption` | Get thread messages |

### Feature Management Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/getMSMSMonitoringStatus` | Check SMS monitoring |
| POST | `/enableMSMSMonitoring` | Enable SMS monitoring |
| GET | `/getWalletEnabled` | Check wallet status |
| POST | `/enableWallet` | Enable wallet |
| POST | `/sendActionToDevice` | Send remote action |
| POST | `/parentAppSecurityCheck` | Security verification |

### Monetization Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/getBannerAds` | Get banner advertisements |
| POST | `/createPaymentIntent` | Create Stripe payment |

### User Engagement Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| POST | `/submitReview` | Submit app review |
| POST | `/feedback` | Submit feedback |

### HTTP Headers

**Default Headers:**
```
X-API-VERSION: 0.0.0.1
Content-type: application/json; charset=utf-8
Authorization: Bearer {access_token} (if logged in)
```

### Network Class (`network.dart`)

**Methods:**
- `get(url)` - Send GET request
- `post(url, body)` - Send POST request
- `getHeaders()` - Construct request headers
- `responseHandler(res)` - Parse API response

**Response Format:**
```json
{
  "status": "success" | "error",
  "data": { ... },
  "message": "string"
}
```

---

## Data Management

### Local Storage (Shared Preferences)

Managed through `sharedHelper.dart` using custom `SharedPrefValue<T>` wrapper:

**User Authentication:**
- `userId: String` - User ID from backend
- `accessToken: String` - JWT access token
- `refreshToken: String` - JWT refresh token

**User Information:**
- `email: String` - User email
- `firstName: String` - First name
- `lastName: String` - Last name
- `phone: String` - Phone number
- `id: int` - Local ID

**Session State:**
- `isLoggedIn: bool` - Authentication status
- `verificationPending: bool` - Pending email verification
- `verificationPhone: bool` - Pending phone verification

**SharedPrefValue Features:**
- Generic type support `<T>`
- Default values per type
- Safe getters
- Custom getters with defaults

### Data Models

#### User Models
- `UserModel` - Primary user data structure
- `UserModel1` - Alternative user model (newer version)

#### Device & Monitoring
- `DeviceDetailModel` - Device information
- `KidsModel` - Child profile data
- `AppUsageModel` - App usage statistics

#### Content Filtering
- `BlockedUrlModel` - Blocked URL information

#### Communication
- `ThreadModel` - Chat conversation data
- `MessageModel` - Individual message data

#### API Responses
- `ResponseModel` - Generic API response wrapper

#### Ads
- `AdModel` - Advertisement data

### Repository Pattern

Repositories abstract API calls from controllers:

**AuthRepo:**
- `login(email, password)`
- `signup(userData)`
- `verifyOTP(otp)`
- `refreshToken()`

**HomeRepo:**
- `getConnectedDevices()`
- `getDeviceDetails(deviceId)`
- `getAppUsage(deviceId)`
- `getBlacklistedApps(deviceId)`
- `blockApp(deviceId, appId)`
- `getBlockedUrls(deviceId)`
- `addBlockedUrl(deviceId, url)`
- `getDeviceThreads(deviceId)`
- `getThreadMessages(threadId)`

**SingleKidRepo:**
- `getKidData(kidId)`
- `getSyncedDevices(kidId)`

---

## Security & Encryption

### Encryption Libraries

**RSA Encryption:**
- `fast_rsa: ^3.8.6` - Fast RSA operations
- `basic_utils: ^5.7.0` - RSA key generation and handling
- `rsa_encrypt: ^2.0.0` - RSA encryption wrapper
- `rsa_pkcs: ^2.1.0` - PKCS standards
- `pointycastle: ^3.7.3` - Cryptography algorithms

**Symmetric Encryption:**
- `encrypt: ^5.0.3` - AES encryption
- `crypto: ^3.0.3` - Cryptographic hashes
- `crypton: ^2.2.1` - Additional crypto utilities

### Encryption Methods

#### Device Communication
- Message encryption before storage
- Encrypted transmission to backend
- RSA for key exchange
- AES for message encryption

#### Decryption (`decrypter.dart`)
- Handles RSA decryption
- Manages encryption keys
- Decrypts device communications
- Processes encrypted API responses

### Security Features

1. **Token Security:**
   - Tokens stored in Shared Preferences (encrypted on iOS)
   - Authorization header with Bearer token
   - Token refresh mechanism

2. **Device Data:**
   - Sensitive device data encrypted
   - Endpoint encryption support
   - PKCS7 padding

3. **User Privacy:**
   - Phone number separation (with/without country code)
   - DOB stored locally
   - Personal data not logged

4. **SSL/TLS:**
   - HTTPS only communication
   - Certificate pinning (potential future implementation)

---

## UI/UX Structure

### Screen Architecture

**Splash Screen (`splash/`):**
- Initial app loading
- Authentication check
- Navigation routing

**Authentication Flow:**
- Login screen (`login/`)
- Sign up screen (`signup/`)
- OTP verification (`otp_verification/`)
- Password recovery (`forgot_password/`)

**Main Application:**
- Dashboard/Home (`home/`)
- Device details (`sync_device_detail_screen/`)
- Device scanning (`scan_barcode/`)
- Messaging (`chat/`)

**User Management:**
- Profile (`main_menu_profile/`)
- Subscriptions (`subscription_screen/`)

**Content Control:**
- App blocking (`blacklist/`)

**Security:**
- Parent verification (`parent_security_check/`)

**Onboarding:**
- App introduction (`onboard/`)

### UI Components

**Common Widgets (`util/common_widgets/`):**
- Custom buttons
- Input fields
- Cards
- Dialogs
- Loading indicators
- Bottom sheets

**Custom Toast (`customtoast.dart`):**
- Success messages
- Error messages
- Info notifications
- Custom styling

### Styling System

**Colors (`util/colors.dart`):**
- Primary colors
- Secondary colors
- Neutral palette
- Status colors (success, error, warning)

**Typography (`util/apptext.dart`):**
- Font constants
- Text styles
- Heading styles
- Body text styles

**Images (`util/images.dart`):**
- Asset path constants
- Image references

### Custom Fonts

**DM Sans:**
- Regular, Italic, Bold, Medium weights
- Asset: `assets/fonts/dm-sans/`

**Praise:**
- Display font
- Asset: `assets/fonts/praise/`

### Assets

**Images:**
- Common images: `assets/images/common/`
- Home screen images: `assets/images/home/`
- Profile images: `assets/images/profile/`

**Media:**
- Tutorial video: `assets/tutorial_video/tutorial_video.mp4`

---

## Build Configuration

### Gradle Configuration

**Android Settings (`android/settings.gradle`):**
```gradle
pluginManagement {
    // Flutter SDK path from local.properties
    includeBuild flutter/packages/flutter_tools/gradle
    repositories: google(), mavenCentral(), gradlePluginPortal()
}

plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.6.0"
    id "org.jetbrains.kotlin.android" version "2.1.0"
    id "com.google.gms.google-services" version "4.4.0"
    id "com.android.library" version "8.6.0"
}

include ":app"
```

**App Build Configuration (`android/app/build.gradle`):**
```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "com.google.gms.google-services"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace: "com.moolahmobile.moolahmobileguardian"
    compileSdkVersion: 36
    targetSdkVersion: 36
    minSdkVersion: flutter.minSdkVersion
    
    kotlinOptions {
        jvmTarget = '1.8'
    }
    
    buildTypes {
        release {
            ndk {
                abiFilters 'armeabi-v7a', 'arm64-v8a', 'x86_64'
            }
        }
    }
}

dependencies {
    // Firebase, Google Play Services, Kotlin
}
```

### Version Information

**Project Version:** 0.0.1+0  
**Version Code:** Managed by Flutter  
**Version Name:** 0.0.1

**Android Package Name:** `com.moolahmobile.moolahmobileguardian`

**Min SDK:** Flutter default (typically 21)  
**Target SDK:** 36  
**Compile SDK:** 36  
**NDK Version:** Flutter default

### Signing Configuration

**Debug Signing:** Enabled for development  
**Release Signing:** Currently using debug keystore (should be updated for production)

### Firebase Integration

**Google Services:** `android/app/google-services.json`  
**Firebase BOM:** v32.6.0

### Kotlin Support

**Kotlin Version:** 2.1.0  
**Source Sets:** `src/main/kotlin`  
**Java Compatibility:** 1.8

---

## Getting Started

### Prerequisites

1. **Flutter SDK**
   ```bash
   flutter --version  # Should be 3.0.2 or higher
   ```

2. **Dart SDK**
   ```bash
   dart --version  # Included with Flutter
   ```

3. **Android Studio** (for Android development)
   - Android SDK 36+
   - Android Emulator or physical device

4. **Xcode** (for iOS development)
   - iOS SDK
   - CocoaPods

5. **Git** (for version control)

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd moolah-guardian
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Local Properties (Android)**
   ```bash
   # Edit android/local.properties
   flutter.sdk=/path/to/flutter/sdk
   ```

4. **Set Environment Variables**
   ```bash
   # macOS/Linux
   export FLUTTER_HOME=/path/to/flutter
   export PATH=$FLUTTER_HOME/bin:$PATH
   ```

5. **Install iOS Pods** (iOS only)
   ```bash
   cd ios
   pod install
   cd ..
   ```

6. **Configure Google Services**
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/` (iOS)

7. **Run the App**
   ```bash
   # Android
   flutter run -d <device-id>
   
   # iOS
   flutter run -d <device-id>
   
   # Web
   flutter run -d chrome
   ```

### Build for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS IPA:**
```bash
flutter build ios --release
```

**Web Build:**
```bash
flutter build web --release
```

---

## Testing

### Test Files Location
`test/` directory contains unit and widget tests:

**Available Tests:**
- `blacklist_test.dart` - App blocking functionality
- `login_test.dart` - Authentication tests
- `parent_security_check_test.dart` - Security features
- `subscription_test.dart` - Payment functionality
- `sync_device_detail_test.dart` - Device syncing
- `widget_test.dart` - Widget tests
- `chat/` - Chat functionality tests

### Running Tests

**Run All Tests:**
```bash
flutter test
```

**Run Specific Test:**
```bash
flutter test test/login_test.dart
```

**Run Tests with Coverage:**
```bash
flutter test --coverage
```

**Generate Coverage Report:**
```bash
# Requires lcov
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Test Assets
`build/unit_test_assets/` contains test resources:
- Asset manifests
- Font configurations
- Mock data
- Test fixtures

---

## Additional Configuration

### Analysis Options (`analysis_options.yaml`)

Dart analysis configuration for linting and code quality.

### Dependency Versions

All dependencies are pinned to specific versions in `pubspec.lock` for reproducible builds.

### Platform-Specific Configuration

**Android:**
- Gradle wrapper version: defined in `gradle/wrapper/`
- NDK filters for release: armeabi-v7a, arm64-v8a, x86_64

**iOS:**
- CocoaPods dependencies: `ios/Podfile`
- Xcode configuration: `ios/Runner.xcodeproj`

**Web:**
- Flutter web support in `web/` directory
- Manifest and icons in `web/`

**Linux/Windows/macOS:**
- Native platform files included for completeness

---

## Project Statistics

**Total Dependencies:** 40+  
**Dev Dependencies:** 3  
**Supported Platforms:** 6 (iOS, Android, Web, Linux, Windows, macOS)  
**Test Files:** 7  
**Main Dart Files:** 40+  
**Asset Categories:** Images, Fonts, Videos

---

## Key Metrics

- **Min Dart Version:** 3.0.2
- **Max Dart Version:** 4.0.0
- **App Size (estimated):** Varies by platform
- **Min Android API:** Flutter default
- **Target Android API:** 36
- **Compile Android API:** 36
- **Min iOS Version:** Configurable in Podfile

---

## Next Steps & Development

### TODO Features
- Production signing configuration
- Enhanced error handling
- Comprehensive logging
- Performance optimization
- Additional unit tests
- Integration tests
- Beta testing framework

### Known Limitations
- Staging environment commented out
- Debug signing for release builds
- Potential token expiration handling improvements

### Future Enhancements
- Biometric authentication
- Offline mode support
- Enhanced encryption standards
- Real-time syncing
- ML-based content filtering

---

## Support & Resources

### Documentation
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [GetX Documentation](https://pub.dev/packages/get)

### API Documentation
- Backend API: `https://api2.moolahmobile.com`
- Stripe Documentation: [stripe.com/docs](https://stripe.com/docs)
- Firebase: [firebase.google.com](https://firebase.google.com)
- OneSignal: [onesignal.com/docs](https://onesignal.com/docs)

### Helpful Commands

```bash
# Clean build
flutter clean

# Get new packages
flutter pub get

# Upgrade packages
flutter pub upgrade

# Format code
dart format .

# Analyze code
flutter analyze

# Build runner for models
flutter pub run build_runner build

# Check Flutter version
flutter --version

# Device list
flutter devices

# Verbose output
flutter run -v
```

---

## Document Version

**Version:** 1.0  
**Last Updated:** December 2024  
**Project Version:** 0.0.1+0

---

## Conclusion

Moolah Guardian is a comprehensive parental control application built with Flutter, leveraging modern mobile development practices. It provides robust features for device monitoring, app management, and payment control with strong emphasis on security through encryption and secure authentication.

The application follows the GetX architecture pattern, implementing clean separation of concerns through controllers, repositories, and models. The multi-platform support ensures availability across iOS, Android, and web platforms.

For continued development and maintenance, refer to the specific sections in this documentation for implementation details and architecture guidelines.
