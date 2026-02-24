# API Endpoints with Base URL

## Base URL
- **Production:** `https://api2.moolahmobile.com`
- **Staging:** `https://staging.api2.moolahmobile.com`

## Authentication Endpoints
- **POST** `/login` - User login
- **POST** `/register` - User registration
- **POST** `/refreshTokens` - Refresh access token
- **POST** `/send-mobile-otp` - Send OTP to phone
- **POST** `/verifyMobileOtp` - Verify OTP

## Device Monitoring Endpoints
- **GET** `/getConnectedKidDevices` - Get synced kid devices
- **GET** `/getSingleDeviceDetail` - Get device details
- **GET** `/getDeviceLocation` - Get device location
- **POST** `/parentKidDeviceConnect` - Connect kid device

## App Management Endpoints
- **GET** `/getAppUsage` - Get app usage statistics
- **POST** `/blacklistApp` - Block an app
- **POST** `/deleteApp` - Delete app remotely
- **GET** `/getBlacklistedApps` - Get blocked apps list

## Network & URL Filtering Endpoints
- **GET** `/getNetworkHistory` - Get network history
- **GET** `/getBlockedUrlsEncryption` - Get blocked URLs
- **POST** `/blacklistUrl` - Block URL (deprecated)
- **POST** `/addBlockedUrl` - Add URL to blacklist

## Communication Monitoring Endpoints
- **GET** `/getDeviceThreadsEncryption` - Get chat threads
- **GET** `/getThreadMessagesEncryption` - Get thread messages

## Feature Management Endpoints
- **GET** `/getMSMSMonitoringStatus` - Check SMS monitoring
- **POST** `/enableMSMSMonitoring` - Enable SMS monitoring

## Wallet Endpoints
- **GET** `/getWalletEnabled` - Check wallet status
- **POST** `/enableWallet` - Enable wallet
- **POST** `/sendActionToDevice` - Send remote action
- **POST** `/parentAppSecurityCheck` - Security verification

## Monetization Endpoints
- **GET** `/getBannerAds` - Get banner advertisements
- **POST** `/createPaymentIntent` - Create Stripe payment

## User Engagement Endpoints
- **POST** `/submitReview` - Submit app review
- **POST** `/feedback` - Submit feedback

## HTTP Headers
- **Default Headers:**
  ```
  X-API-VERSION: 0.0.0.1
  Content-type: application/json; charset=utf-8
  Authorization: Bearer {access_token} (if logged in)
  ```
