import 'dart:math';

import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/helper/endpoints.dart';
import 'package:moolah/helper/models/kids_model.dart';
import 'package:moolah/helper/models/response_model.dart';
import 'package:moolah/helper/network.dart';
import 'package:moolah/helper/repo/homeRepo.dart';
import 'package:moolah/util/images.dart';

import '../helper/models/app_usage_model.dart';
import '../helper/repo/singleKidRepo.dart';

class HomeController extends BaseController {
  List<Kid> connectedKids = [];

  AppUsage? appUsageOfSelectedKid;

  Future<void> getSyncedKidDevices() async {
    ResponseModel responseModel = await HomeRepo.getSyncedKidDevices();

    List<Kid> temp = [];
    //   Kid(
    //       kidId: 1,
    //       name: "Ronald Richards",
    //       batteryStatus: "56",
    //       connectId: "1",
    //       dataUsageStatus: "9.2",
    //       deviceType: "phone",
    //       kidPic: AppImages.child1,
    //       lastActive: "32 m ago",
    //       walletEnabled: false),
    //   Kid(
    //       kidId: 2,
    //       name: "Floyd Miles",
    //       batteryStatus: "10",
    //       connectId: "2",
    //       dataUsageStatus: "3.2",
    //       deviceType: "phone",
    //       kidPic: AppImages.child2,
    //       lastActive: "Now",
    //       walletEnabled: false),
    //   Kid(
    //       kidId: 3,
    //       name: "Jane Cooper",
    //       batteryStatus: "100",
    //       connectId: "3",
    //       dataUsageStatus: "5.2",
    //       deviceType: "tab",
    //       kidPic: AppImages.child3,
    //       lastActive: "14 m ago",
    //       walletEnabled: false),
    //   Kid(
    //       kidId: 4,
    //       name: "Floyd Miles",
    //       batteryStatus: "90",
    //       connectId: "4",
    //       dataUsageStatus: "1.0",
    //       deviceType: "phone",
    //       kidPic: AppImages.child4,
    //       lastActive: "2 m ago",
    //       walletEnabled: false),
    // ];



    // List temp = responseModel.data["kid"];
    if(responseModel.isSuccessful){
      for (int i = 0; i < responseModel.data["devices"].length; i++) {
        // Kid(responseModel.data["devices"]);
        print("Hweewkelkn");
        var tem = responseModel.data["devices"][i];
          temp.add(Kid(
              kidId: tem["kidDeviceAccountUserID"],
              name: tem["kidFullName"],
              batteryStatus: "0",
              connectId: tem["kidDeviceAccountConnectID"],
              dataUsageStatus: "0",
              deviceType: tem["kidDeviceType"],
              kidPic: null,
              lastActive: "0m",
              walletEnabled: false));
      }
      if(temp.isNotEmpty){
        connectedKids.clear();
        for (int i = 0; i < temp.length; i++) {
          // connectedKids.add(Kid.fromJson(temp[i]));
          connectedKids.add(temp[i]);
        }
      }
    }

    update();
    //{"kidID": "String", "name": "String", "deviceType": "String", "batteryStatus": "String", "connectID": "String", "dataUsageStatus": "String", "lastActive": "String", "kidPic": "String", "walletEnabled": false}
  }

  Future<void> enableWallet({required String kidId, required bool value}) async {
    if (isLoading) return;
    isLoading = true;
    int index = getSelectedKidIndex(kidId);
    connectedKids[index] = connectedKids[index].copyWith(walletEnabled: value);
    ResponseModel responseModel = await SingleKidRepo.enableWallet(kidId: kidId);
    isLoading = false;
  }

  Future<void> getAppUsage({required String kidId}) async {
    // if (isLoading) return;
    // isLoading = true;

    if(connectedKids[getSelectedKidIndex(kidId)].appUsage == null) {
      connectedKids[getSelectedKidIndex(kidId)].appUsage = AppUsage(
          deviceDailyAvgUsage: "7h 32 m",
          deviceDailyAvgUsageChange: "+35% from last Week",
          installedAppsCount: 4,
          listOfInstalledApps: [
            ListOfInstalledApp(
                appId: 1,
                appIcon: AppImages.twitter,
                appName: "Twitter",
                durationOfUsage: "2h 29 mins",
                percentUsage: Random().nextInt(100)),
            ListOfInstalledApp(
                appId: 2,
                appIcon: AppImages.instagram,
                appName: "Instagram",
                durationOfUsage: "1h 29 mins",
                percentUsage: Random().nextInt(100)),
            ListOfInstalledApp(
                appId: 3,
                appIcon: AppImages.snapchat,
                appName: "Snapchat",
                durationOfUsage: "30 mins",
                percentUsage: Random().nextInt(100)),
            ListOfInstalledApp(
                appId: 4,
                appIcon: AppImages.tiktok,
                appName: "Tiktok",
                durationOfUsage: "15 mins",
                percentUsage: Random().nextInt(100)),
            ListOfInstalledApp(
                appId: 5,
                appIcon: AppImages.facebook,
                appName: "Facebook",
                durationOfUsage: "5 mins",
                percentUsage: Random().nextInt(100)),
          ],
          msg: "",
          success: true);
    }

    // List temp = responseModel.data["kid"];
    // for(int i=0;i<temp.length;i++){
    //   // connectedKids.add(Kid.fromJson(temp[i]));
    //   appUsageOfSelectedKid.add(temp[i]);
    // }
    //{ "installedAppsCount": 4, "deviceDailyAvgUsage": "7h 32 m", "deviceDailyAvgUsageChange": "+35% from last Week", "listOfInstalledApps": [{"app_name": "Twitter","app_icon":"","percent_usage": 70, "duration_of_usage": "2h 29 mins"}], "msg": "String", "success": true}
    // ResponseModel responseModel = await SingleKidRepo.getAppUsage(kidId: kidId);
    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
  }

  Future<void> getDeviceDetail({required String kidId}) async {
    // if (isLoading) return;
    isLoading = true;
    ResponseModel responseModel = await SingleKidRepo.getDeviceDetails(kidId: kidId);
    print("responseModel::: ${responseModel.data}");
    Duration time = (DateTime.fromMillisecondsSinceEpoch(responseModel.data["data"]["lastReportedTime"]).difference(DateTime.now()));
    String timee = "${time.inHours!=0?"${time.inHours % 24}h":""} ${time.inMinutes != 0 ? "${time.inMinutes % 60}m" : ""}";
    connectedKids[getSelectedKidIndex(kidId)].lastActive = timee;
    print('responseModel.data["data"]["realtimeStats"]["batteryLevel"]:::${responseModel.data["data"]["realTimeStats"]["batteryLevel"]}');
    connectedKids[getSelectedKidIndex(kidId)].dataUsageStatus = responseModel.data["data"]["networkInfo"]["sim1"]["mDataRoaming"]?.toString() ?? "0";
    connectedKids[getSelectedKidIndex(kidId)].batteryStatus = responseModel.data["data"]["realTimeStats"]["batteryLevel"]?.toString() ?? "0";
    isLoading = false;
  }

  Future<void> blacklistApp({int? kidId}) async {
    if (isLoading) return;
    isLoading = true;
    // ResponseModel responseModel = await SingleKidRepo.blacklistApp(kidId: kidId);
    isLoading = false;
  }

  Future<void> deleteApp({required String kidId, required int appId}) async {
    if (isLoading) return;
    isLoading = true;
    List<ListOfInstalledApp> apps = connectedKids[getSelectedKidIndex(kidId)].appUsage!.listOfInstalledApps??[];
    int index = -1;
    for(int i=0;i<apps.length;i++){
      print("appId: ${appId}");
      print("apps[i].appId: ${apps[i].appName}");
      print("apps[i].appId: ${apps[i].appId}");
      if(apps[i].appId == appId){
        index = i;
        break;
      }
    }
    print("index: $index");
    if(index != -1){
      connectedKids[getSelectedKidIndex(kidId)].appUsage!.listOfInstalledApps?.removeAt(index);
    }
    // ResponseModel responseModel = await SingleKidRepo.deleteApp(kidId: kidId);
    isLoading = false;
  }

  Future<void> getBlacklistedApps({int? kidId}) async {
    if (isLoading) return;
    isLoading = true;
    // ResponseModel responseModel = await SingleKidRepo.getBlacklistedApps(kidId: kidId);
    isLoading = false;
  }

  Future<void> getNetworkHistory({int? kidId}) async {
    if (isLoading) return;
    isLoading = true;
    // ResponseModel responseModel = await SingleKidRepo.getNetworkHistory(kidId: kidId);
    isLoading = false;
  }

  Future<void> getBlacklistUrls({int? kidId}) async {
    if (isLoading) return;
    isLoading = true;
    // ResponseModel responseModel = await SingleKidRepo.getBlacklistUrls(kidId: kidId);
    isLoading = false;
  }

  Future<void> blacklistUrl({int? kidId}) async {
    if (isLoading) return;
    isLoading = true;
    // ResponseModel responseModel = await SingleKidRepo.blacklistUrl(kidId: kidId);
    isLoading = false;
  }

  int getSelectedKidIndex(String kidId) {
    int index = 0;
    for (int i = 0; i < connectedKids.length; i++) {
      if(kidId == connectedKids[i].kidId){
        index = i;
        break;
      }
    }
    return index;
  }

  Kid getSelectedKid(String kidId){
    return connectedKids[getSelectedKidIndex(kidId)];
  }

  void logout(){
    connectedKids.clear();
    appUsageOfSelectedKid = null;
  }
}
