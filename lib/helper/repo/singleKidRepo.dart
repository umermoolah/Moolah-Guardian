import '../endpoints.dart';
import '../models/response_model.dart';
import '../network.dart';

class SingleKidRepo {



  static Future<ResponseModel> getMSMSMonitoringStatus({String? kidId}) async {
    return await Network.get(EndPoints.getMSMSMonitoringStatus);
  }
  static Future<ResponseModel> getWalletStatus({String? kidId}) async {
    return await Network.get(EndPoints.getWalletStatus);
  }

  static Future<ResponseModel> enableMSMSMonitoring({bool enable = false, String? kidId}) async {
    return await Network.post(EndPoints.enableMSMSMonitoring,body: {
      "msmsMonitoringStatus": enable.toString(),
      "kidDeviceAccountUserID": kidId
    });
  }

  static Future<ResponseModel> enableWallet({bool enable = false, String? kidId}) async {
    return await Network.post(EndPoints.enableWalletUrl,body: {
      "walletEnabled": enable.toString(),
      "kidDeviceAccountUserID": kidId
    });
  }

  static Future<ResponseModel> getAppUsage({int? kidId}) async {
    return await Network.get("${EndPoints.getAppUsageUrl}?kidID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }

  static Future<ResponseModel> blacklistApp({int? kidId, String? appPackageName}) async {
    return await Network.post("${EndPoints.blacklistAppUrl}?kidID=$kidId&appPackageName=$appPackageName");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }

  static Future<ResponseModel> deleteApp({int? kidId, String? appPackageName}) async {
    return await Network.post("${EndPoints.deleteAppUrl}?kidID=$kidId&appPackageName=$appPackageName");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }

  static Future<ResponseModel> getBlacklistedApps({int? kidId}) async {
    return await Network.post("${EndPoints.getBlacklistedAppsUrl}?kidID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }

  static Future<ResponseModel> getNetworkHistory({int? kidId}) async {
    return await Network.post("${EndPoints.getNetworkHistoryUrl}?kidID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }

  static Future<ResponseModel> getBlacklistUrls({String? kidId}) async {
    return await Network.post(EndPoints.getBlacklistUrlsUrl, body: {
      "kidDeviceAccountUserID": kidId
    });
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }

  static Future<ResponseModel> addBlacklistUrl({String? kidId, String? url}) async {
    return await Network.post(EndPoints.addBlacklistUrl, body: {
      "urls": ["$url"],
      "kidDeviceAccountUserID": kidId
    }, encode: true);
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }


  static Future<ResponseModel> getDeviceDetails({String? kidId}) async {
    return await Network.get("${EndPoints.getDeviceDetails}?deviceId=$kidId");
    // return await Network.get("${EndPoints.getDeviceDetails}?kidDeviceAccountConnectID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }

  static Future<ResponseModel> getDeviceDetailsNew({String? kidId}) async {
    return await Network.get("${EndPoints.getDeviceDetails}?deviceId=$kidId");
    // return await Network.get("${EndPoints.getDeviceDetails}?kidDeviceAccountConnectID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }


  static Future<ResponseModel> getDeviceThreads({String? kidId}) async {
    return await Network.get("${EndPoints.getDeviceThreads}?kidDeviceAccountConnectID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }

  static Future<ResponseModel> getThreadsMessages({String? kidId}) async {
    return await Network.get("${EndPoints.getDeviceDetails}?kidDeviceAccountConnectID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }
}