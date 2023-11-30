import 'dart:math';

import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/helper/endpoints.dart';
import 'package:moolah/helper/models/blocked_url_model.dart';
import 'package:moolah/helper/models/device_detail_model.dart';
import 'package:moolah/helper/models/kids_model.dart';
import 'package:moolah/helper/models/message_model.dart';
import 'package:moolah/helper/models/response_model.dart';
import 'package:moolah/helper/models/thread_model.dart';
import 'package:moolah/helper/network.dart';
import 'package:moolah/helper/repo/homeRepo.dart';
import 'package:moolah/util/customtoast.dart';
import 'package:moolah/util/images.dart';

import '../helper/models/app_usage_model.dart';
import '../helper/repo/singleKidRepo.dart';

class HomeController extends BaseController {
  List<Kid> connectedKids = [];

  AppUsage? appUsageOfSelectedKid;

  Future<void> getSyncedKidDevices() async {
    // connectedKids = [
    //   Kid(
    //       kidId: "1",
    //       name: "Ronald Richards",
    //       batteryStatus: "56",
    //       connectId: "1",
    //       dataUsageStatus: "9.2",
    //       deviceType: "phone",
    //       kidPic: AppImages.child1,
    //       lastActive: "32 m ago",
    //       walletEnabled: false),
    //   Kid(
    //       kidId: "2",
    //       name: "Floyd Miles",
    //       batteryStatus: "10",
    //       connectId: "2",
    //       dataUsageStatus: "3.2",
    //       deviceType: "phone",
    //       kidPic: AppImages.child2,
    //       lastActive: "Now",
    //       walletEnabled: false),
    //   Kid(
    //       kidId: "3",
    //       name: "Jane Cooper",
    //       batteryStatus: "100",
    //       connectId: "3",
    //       dataUsageStatus: "5.2",
    //       deviceType: "tab",
    //       kidPic: AppImages.child3,
    //       lastActive: "14 m ago",
    //       walletEnabled: false),
    //   Kid(
    //       kidId: "4",
    //       name: "Floyd Miles",
    //       batteryStatus: "90",
    //       connectId: "4",
    //       dataUsageStatus: "1.0",
    //       deviceType: "phone",
    //       kidPic: AppImages.child4,
    //       lastActive: "2 m ago",
    //       walletEnabled: false),
    // ];

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
    if (responseModel.isSuccessful) {
      for (int i = 0; i < responseModel.data["devices"].length; i++) {
        // Kid(responseModel.data["devices"]);
        print("Hweewkelkn");
        var tem = responseModel.data["devices"][i];
        print(
            'tem["kidDeviceAccountUserID"]::::${tem["kidDeviceAccountUserID"]}');
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
      if (temp.isNotEmpty) {
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

  Future<void> enableWallet(
      {required String kidId, required bool value}) async {
    if (isLoading) return;
    isLoading = true;
    int index = getSelectedKidIndex(kidId);
    connectedKids[index] = connectedKids[index].copyWith(walletEnabled: value);
    ResponseModel responseModel =
        await SingleKidRepo.enableWallet(kidId: kidId);
    isLoading = false;
  }

  Future<void> getAppUsage({required String kidId}) async {
    // if (isLoading) return;
    // isLoading = true;

    if (connectedKids[getSelectedKidIndex(kidId)].appUsage == null) {
      connectedKids[getSelectedKidIndex(kidId)].appUsage = AppUsage(
          deviceDailyAvgUsage: "7h 32 m",
          deviceDailyAvgUsageChange: "+35% from last Week",
          installedAppsCount: 4,
          listOfInstalledApps: [
            // ListOfInstalledApp(
            //     appId: 1,
            //     appIcon: AppImages.twitter,
            //     appName: "Twitter",
            //     durationOfUsage: "2h 29 mins",
            //     percentUsage: Random().nextInt(100)),
            // ListOfInstalledApp(
            //     appId: 2,
            //     appIcon: AppImages.instagram,
            //     appName: "Instagram",
            //     durationOfUsage: "1h 29 mins",
            //     percentUsage: Random().nextInt(100)),
            // ListOfInstalledApp(
            //     appId: 3,
            //     appIcon: AppImages.snapchat,
            //     appName: "Snapchat",
            //     durationOfUsage: "30 mins",
            //     percentUsage: Random().nextInt(100)),
            // ListOfInstalledApp(
            //     appId: 4,
            //     appIcon: AppImages.tiktok,
            //     appName: "Tiktok",
            //     durationOfUsage: "15 mins",
            //     percentUsage: Random().nextInt(100)),
            // ListOfInstalledApp(
            //     appId: 5,
            //     appIcon: AppImages.facebook,
            //     appName: "Facebook",
            //     durationOfUsage: "5 mins",
            //     percentUsage: Random().nextInt(100)),
          ],

          ///ONLY FOR STAGING
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
    ResponseModel responseModel =
        await SingleKidRepo.getDeviceDetails(kidId: kidId);
    print("responseModel::: ${responseModel.data}");
    print("DateTime.now()::${DateTime.now()}");
    if (responseModel.data["code"] == 200) {
      Duration time = (DateTime.now().difference(
          DateTime.fromMillisecondsSinceEpoch(
              responseModel.data["data"]["lastReportedTime"])));
      String timee =
          "${time.inHours != 0 ? "${time.inHours % 24}h" : ""} ${time.inMinutes != 0 ? "${time.inMinutes % 60}m" : ""}";
      connectedKids[getSelectedKidIndex(kidId)].lastActive = timee;
      print(
          'responseModel.data["data"]["realtimeStats"]["batteryLevel"]:::${responseModel.data["data"]["realTimeStats"]["batteryLevel"]}');
      connectedKids[getSelectedKidIndex(kidId)].dataUsageStatus = responseModel
              .data["data"]["networkInfo"]["sim1"]["mDataRoaming"]
              ?.toString() ??
          "0";
      connectedKids[getSelectedKidIndex(kidId)].batteryStatus = responseModel
              .data["data"]["realTimeStats"]["batteryLevel"]
              ?.toString() ??
          "0";

      /// ONLY FOR PRODUCTION
      DeviceDetail d = DeviceDetail.fromJson(responseModel.data);
      double totalTime = 0;
      for (int i = 0;
          i < (d.data?.realTimeStats?.appUsageData?.length ?? 0);
          i++) {
        totalTime += d.data!.realTimeStats!.appUsageData![i].mFgUsageTime ?? 0;
      }
      d.data?.realTimeStats?.totalAppUsageData = totalTime;
      connectedKids[getSelectedKidIndex(kidId)].deviceDetail = d;

      /// ONLY FOR PRODUCTION
    } else {
      // errorToast("Something went wrong!");
    }
    update();
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
    List<ListOfInstalledApp> apps = connectedKids[getSelectedKidIndex(kidId)]
            .appUsage!
            .listOfInstalledApps ??
        [];
    int index = -1;
    for (int i = 0; i < apps.length; i++) {
      print("appId: ${appId}");
      print("apps[i].appId: ${apps[i].appName}");
      print("apps[i].appId: ${apps[i].appId}");
      if (apps[i].appId == appId) {
        index = i;
        break;
      }
    }
    print("index: $index");
    if (index != -1) {
      connectedKids[getSelectedKidIndex(kidId)]
          .appUsage!
          .listOfInstalledApps
          ?.removeAt(index);
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

  Future<void> getBlacklistUrls({String? kidId}) async {
    // if (isLoading) return;
    // isLoading = true;
    // ResponseModel responseModel = await SingleKidRepo.getBlacklistUrls(kidId: kidId);
    // Working Here
    print("getBlacklistUrls");
    connectedKids[getSelectedKidIndex(kidId!)].blockedUrls =
        BlockedUrlModel.fromJson({
      "blocked_urls_data": {
        "kid_device_uid": "123456789",
        "parent_device_uid": "987654321",
        "blocked_urls": [
          "https://example.com/inappropriate-site1",
          "https://example.com/inappropriate-site2",
          "https://example.com/inappropriate-site3"
        ]
      }
    });
    print("connectedKids[getSelectedKidIndex(kidId!)].blockedUrls:::${connectedKids[getSelectedKidIndex(kidId!)].blockedUrls}");
    update();
    // isLoading = false;
  }

  Future<void> blacklistUrl({int? kidId}) async {
    if (isLoading) return;
    isLoading = true;
    // ResponseModel responseModel = await SingleKidRepo.blacklistUrl(kidId: kidId);
    isLoading = false;
  }

  Future<void> getMessageThreads({String? kidId}) async {
    var tempDataThreads = [
      {
        "thread_id": "thread_1",
        "last_message": {
          "message_data": {
            "kidDeviceUID": "123456789",
            "sender_contact": null,
            "sender_number": "+1234567890",
            "receiver_contact": "Parent",
            "receiver_number": "+9876543210",
            "message": "Thanks! You too. Catch you later!",
            "message_time_stamp": "2023-11-10T15:55:00Z",
            "media_attachments": null
          }
        }
      },
      {
        "thread_id": "thread_2",
        "last_message": {
          "message_data": {
            "kidDeviceUID": "987654321",
            "sender_contact": "Friend",
            "sender_number": "+1122334455",
            "receiver_contact": null,
            "receiver_number": "+9876543210",
            "message": "Sure! Let's plan something fun for the weekend.",
            "message_time_stamp": "2023-11-10T18:30:00Z",
            "media_attachments": null
          }
        }
      },
      {
        "thread_id": "thread_3",
        "last_message": {
          "message_data": {
            "kidDeviceUID": "987654321",
            "sender_contact": "Friend",
            "sender_number": "+1122334455",
            "receiver_contact": null,
            "receiver_number": "+9876543210",
            "message": "Just chilling and watching a movie. How about you?",
            "message_time_stamp": "2023-11-10T18:30:00Z",
            "media_attachments": null
          }
        }
      },
      {
        "thread_id": "thread_4",
        "last_message": {
          "message_data": {
            "kidDeviceUID": "987654321",
            "sender_contact": "Friend",
            "sender_number": "+1122334455",
            "receiver_contact": null,
            "receiver_number": "+9876543210",
            "message":
                "That's awesome! Anything exciting planned for the evening?",
            "message_time_stamp": "2023-11-10T18:30:00Z",
            "media_attachments": null
          }
        }
      },
      {
        "thread_id": "thread_5",
        "last_message": {
          "message_data": {
            "kidDeviceUID": "987654321",
            "sender_contact": "Friend",
            "sender_number": "+1122334455",
            "receiver_contact": null,
            "receiver_number": "+9876543210",
            "message": "School was good! I aced my math quiz.",
            "message_time_stamp": "2023-11-10T18:30:00Z",
            "media_attachments": null
          }
        }
      },
      {
        "thread_id": "thread_6",
        "last_message": {
          "message_data": {
            "kidDeviceUID": "987654321",
            "sender_contact": "Friend",
            "sender_number": "+1122334455",
            "receiver_contact": null,
            "receiver_number": "+9876543210",
            "message": "Hey kiddo! How was school today?",
            "message_time_stamp": "2023-11-10T18:30:00Z",
            "media_attachments": null
          }
        }
      }
    ];
    List<ThreadModel> tempDataThreadsFinal = [];
    for (int i = 0; i < tempDataThreads.length; i++) {
      tempDataThreadsFinal.add(ThreadModel.fromJson(tempDataThreads[i]));
    }
    print("tempDataThreadsFinal.length");
    print(tempDataThreadsFinal.length);
    connectedKids[getSelectedKidIndex(kidId!)].threads = tempDataThreadsFinal;
    print("connectedKids[getSelectedKidIndex(kidId!)].threads.length");
    print(connectedKids[getSelectedKidIndex(kidId)].name);
    print(connectedKids[getSelectedKidIndex(kidId)].threads.length);
    update();
  }

  int getSelectedKidIndex(String kidId) {
    int index = 0;
    for (int i = 0; i < connectedKids.length; i++) {
      if (kidId == connectedKids[i].kidId) {
        index = i;
        break;
      }
    }
    return index;
  }

  Kid getSelectedKid(String kidId) {
    return connectedKids[getSelectedKidIndex(kidId)];
  }

  Future<List<MessageModel>> getMessages({String? threadId}) async {
    var tempMessages = [
      {
        "message_data": {
          "kidDeviceUID": "123456789",
          "sender_contact": "Monique",
          "sender_number": "+1234567890",
          "receiver_contact": "Jen",
          "receiver_number": "+9876543210",
          "message":
              "Hey! Have you heard about this amazing app called Moolah Guardian? It's a game-changer for keeping our kids safe online!",
          "message_time_stamp": "2023-11-09T16:00:00Z",
          "media_attachments": null
        }
      },
      {
        "message_data": {
          "kidDeviceUID": "987654321",
          "sender_contact": "Jen",
          "sender_number": "+9876543210",
          "receiver_contact": "Monique",
          "receiver_number": "+1234567890",
          "message": "No, I haven't. What does it do?",
          "message_time_stamp": "2023-11-09T16:05:00Z",
          "media_attachments": null
        }
      },
      {
        "message_data": {
          "kidDeviceUID": "123456789",
          "sender_contact": "Monique",
          "sender_number": "+1234567890",
          "receiver_contact": "Jen",
          "receiver_number": "+9876543210",
          "message":
              "It's fantastic! With Moolah Guardian, we can monitor our kids' text messages, check who they're talking to, and ensure they're using the internet safely. It even keeps track of message timestamps and media attachments!",
          "message_time_stamp": "2023-11-09T16:10:00Z",
          "media_attachments": null
        }
      },
      {
        "message_data": {
          "kidDeviceUID": "987654321",
          "sender_contact": "Jen",
          "sender_number": "+9876543210",
          "receiver_contact": "Monique",
          "receiver_number": "+1234567890",
          "message":
              "That sounds incredible! How can we get it for our devices?",
          "message_time_stamp": "2023-11-09T16:15:00Z",
          "media_attachments": null
        }
      },
      {
        "message_data": {
          "kidDeviceUID": "123456789",
          "sender_contact": "Monique",
          "sender_number": "+1234567890",
          "receiver_contact": "Jen",
          "receiver_number": "+9876543210",
          "message":
              "It's easy! Just go to the app store and search for Moolah Guardian. Once installed, we can ensure our kids have a safer digital experience. Let me know if you need any help setting it up!",
          "message_time_stamp": "2023-11-09T16:20:00Z",
          "media_attachments": null
        }
      },
      {
        "message_data": {
          "kidDeviceUID": "123456789",
          "sender_contact": "Jen",
          "sender_number": "+1234567890",
          "receiver_contact": "Monique",
          "receiver_number": "+9876543210",
          "message":
              "It's easy! Just go to www.moolahmobile.com/guardian to download the 	Moolah Guardian app today. Once installed, we can ensure our kids have a safer digital experience. Let me know if you need any help setting it up!",
          "message_time_stamp": "2023-11-09T16:20:00Z",
          "media_attachments": null
        }
      }
    ];
    List<MessageModel> tempMessagesFinal = [];
    for (int i = 0; i < tempMessages.length; i++) {
      tempMessagesFinal.add(MessageModel.fromJson(tempMessages[i]));
    }
    print("tempMessagesFinal.length");
    print(tempMessagesFinal.length);
    // connectedKids[getSelectedKidIndex(kidId!)].threads = tempMessagesFinal;
    // print("connectedKids[getSelectedKidIndex(kidId!)].threads.length");
    // print(connectedKids[getSelectedKidIndex(kidId)].name);
    // print(connectedKids[getSelectedKidIndex(kidId)].threads.length);
    // update();
    return tempMessagesFinal;
  }

  void logout() {
    connectedKids.clear();
    appUsageOfSelectedKid = null;
  }
}
