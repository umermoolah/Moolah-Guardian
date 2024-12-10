class EndPoints {
  // static String baseUrl = "https://staging.api2.moolahmobile.com";
  static String baseUrl = "https://api2.moolahmobile.com";


  static String login = "$baseUrl/login";
  static String signUp = "$baseUrl/register";
  static String refreshToken = "$baseUrl/refreshTokens";

  static String getSyncedKidDevicesUrl = "$baseUrl/getConnectedKidDevices";//getConnectedKidDevicesEncryption,getConnectedKidDevices, getSyncedKidDevices";
  static String getMSMSMonitoringStatus = "$baseUrl/getMSMSMonitoringStatus";
  static String enableMSMSMonitoring = "$baseUrl/enableMSMSMonitoring";
  static String getWalletStatus = "$baseUrl/getWalletEnabled";
  static String enableWalletUrl = "$baseUrl/enableWallet";
  static String getAppUsageUrl = "$baseUrl/getAppUsage";
  static String blacklistAppUrl = "$baseUrl/blacklistApp";
  static String deleteAppUrl = "$baseUrl/deleteApp";
  static String getBlacklistedAppsUrl = "$baseUrl/getBlacklistedApps";
  static String getNetworkHistoryUrl = "$baseUrl/getNetworkHistory";
  static String getBlacklistUrlsUrl = "$baseUrl/getBlockedUrlsEncryption";
  static String blacklistUrl = "$baseUrl/blacklistUrl";
  static String addBlacklistUrl = "$baseUrl/addBlockedUrl";
  static String getDeviceDetails = "$baseUrl/getSingleDeviceDetail";//getDeviceDetailsEncryption, getDeviceDetails
  static String getDeviceThreads = "$baseUrl/getDeviceThreadsEncryption";
  static String getThreadsMessages = "$baseUrl/getThreadMessagesEncryption";
  static String parentAppSecurityCheck = "$baseUrl/parentAppSecurityCheck";
  static String parentKidDeviceConnect = "$baseUrl/parentKidDeviceConnect";
  static String getBannerAds = "$baseUrl/getBannerAds";
  static String submitReview = "$baseUrl/submitReview";
  static String feedback = "$baseUrl/feedback";
  static String sendActionToDevice = "$baseUrl/sendActionToDevice";
  static String getDeviceLocation = "$baseUrl/getDeviceLocation";
}