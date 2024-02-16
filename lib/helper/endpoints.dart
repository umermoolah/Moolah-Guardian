class EndPoints {
  // static String baseUrl = "https://staging.api2.moolahmobile.com";
  static String baseUrl = "https://api2.moolahmobile.com";


  static String login = "$baseUrl/login";
  static String signUp = "$baseUrl/register";
  static String refreshToken = "$baseUrl/refreshTokens";

  static String getSyncedKidDevicesUrl = "$baseUrl/getConnectedKidDevicesEncryption";//getConnectedKidDevices, getSyncedKidDevices";
  static String enableWalletUrl = "$baseUrl/enableWallet";
  static String getAppUsageUrl = "$baseUrl/getAppUsage";
  static String blacklistAppUrl = "$baseUrl/blacklistApp";
  static String deleteAppUrl = "$baseUrl/deleteApp";
  static String getBlacklistedAppsUrl = "$baseUrl/getBlacklistedApps";
  static String getNetworkHistoryUrl = "$baseUrl/getNetworkHistory";
  static String getBlacklistUrlsUrl = "$baseUrl/getBlacklistUrls";
  static String blacklistUrl = "$baseUrl/blacklistUrl";
  static String getDeviceDetails = "$baseUrl/getDeviceDetailsEncryption";//getDeviceDetails
  static String parentAppSecurityCheck = "$baseUrl/parentAppSecurityCheck";
  static String parentKidDeviceConnect = "$baseUrl/parentKidDeviceConnect";
  static String getBannerAds = "$baseUrl/getBannerAds";
  static String submitReview = "$baseUrl/submitReview";
  static String feedback = "$baseUrl/feedback";
}