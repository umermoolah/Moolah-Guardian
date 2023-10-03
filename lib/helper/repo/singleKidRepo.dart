import '../endpoints.dart';
import '../models/response_model.dart';
import '../network.dart';

class SingleKidRepo {
  static Future<ResponseModel> enableWallet({bool enable = false, String? kidId}) async {
    return await Network.post("${EndPoints.enableWalletUrl}?kidID=$kidId&enabled=$enable");
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

  static Future<ResponseModel> getBlacklistUrls({int? kidId}) async {
    return await Network.post("${EndPoints.getBlacklistUrlsUrl}?kidID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }

  static Future<ResponseModel> blacklistUrl({int? kidId}) async {
    return await Network.post("${EndPoints.blacklistUrl}?kidID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }


  static Future<ResponseModel> getDeviceDetails({String? kidId}) async {
    return await Network.get("${EndPoints.getDeviceDetails}?kidDeviceAccountConnectID=$kidId");
    // { "installedAppsCount": 0, "deviceDailyAvgUsage": "", "deviceDailyAvgUsageChange": "", "listOfInstalledApps": [], "msg": "String", "success": false}
  }
}