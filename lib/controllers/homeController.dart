import 'dart:convert';
import 'dart:developer';
// import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moolah/helper/decrypter.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';

// import 'package:encrypt/encrypt.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_js/flutter_js.dart';
// import 'package:encrypt/encrypt.dart';
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
import 'package:pointycastle/api.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/ecb.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:rsa_pkcs/rsa_pkcs.dart' as rsa;
import 'package:fast_rsa/fast_rsa.dart' as rsa1;
import 'package:crypto/crypto.dart' as crypto;

import 'package:crypton/crypton.dart' as c;

import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart' as pointy;

import '../helper/models/app_usage_model.dart';
import '../helper/repo/singleKidRepo.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

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

    log("getConnectedKidDevices:::${responseModel.data}");
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
            privateKey: tem["privateKey"],
            dataUsageStatus: "0",
            deviceType: tem["kidDeviceType"],
            deviceData: DeviceDetail(deviceId: tem["device_id"]),
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

  getWalletStatus({required String kidId}) async {
    // if (isLoading) return;
    // isLoading = true;
    int index = getSelectedKidIndex(kidId);
    ResponseModel responseModel = await SingleKidRepo.getWalletStatus(kidId: kidId);
    print("getWalletStatus:::${responseModel.data}");
    connectedKids[index] = connectedKids[index].copyWith(walletEnabled: responseModel.data["walletEnabled"]);
    // isLoading = false;
  }

  getMSMSMonitoringStatus({required String kidId}) async {
    // if (isLoading) return;
    // isLoading = true;
    int index = getSelectedKidIndex(kidId);
    ResponseModel responseModel = await SingleKidRepo.getMSMSMonitoringStatus(kidId: kidId);
    print("getMSMSMonitoringStatus:::${responseModel.data}");
    connectedKids[index] = connectedKids[index].copyWith(msmsMonitoringStatus: responseModel.data["msmsMonitoringStatus"]);
    update();
    // isLoading = false;
  }

  Future<void> enableMSMSMonitoring(
      {required String kidId, required bool value}) async {
    if (isLoading) return;
    isLoading = true;
    int index = getSelectedKidIndex(kidId);
    connectedKids[index] = connectedKids[index].copyWith(msmsMonitoringStatus: value);
    print("Value::$value");
    ResponseModel responseModel =
        await SingleKidRepo.enableMSMSMonitoring(kidId: kidId, enable: value);
    print("enableMSMSMonitoring:::${responseModel.data}");
    isLoading = false;
  }
  Future<void> enableWallet(
      {required String kidId, required bool value}) async {
    if (isLoading) return;
    isLoading = true;
    int index = getSelectedKidIndex(kidId);
    connectedKids[index] = connectedKids[index].copyWith(walletEnabled: value);
    print("Value::$value");
    ResponseModel responseModel =
        await SingleKidRepo.enableWallet(kidId: kidId, enable: value);
    print("enableWallet:::${responseModel.data}");
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
    // log("responseModel::: ${responseModel.data}");
    // print();
    String resp = jsonEncode(responseModel.data);//Decrypter.decryptCode(getSelectedKid(kidId).privateKey!, responseModel.data["encryptedSymmetricKey"], responseModel.data["iv"], responseModel.data["encryptedData"]);
    log("responseModel::: ${resp}");
    print("DateTime.now()::${DateTime.now()}");
    connectedKids[getSelectedKidIndex(kidId)].msmsMonitoringStatus = jsonDecode(resp)["msmsMonitoringStatus"];
    DeviceDetail detail = DeviceDetail.fromJson(jsonDecode(resp));
    connectedKids[getSelectedKidIndex(kidId)].deviceDetail = detail;
    print("connectedKids[getSelectedKidIndex(kidId)].deviceDetail:::${connectedKids[getSelectedKidIndex(kidId)].deviceDetail?.data?.realTimeStats?.appUsageData?.length}");
      Duration time = (DateTime.now().difference(
          DateTime.fromMillisecondsSinceEpoch(
              detail.data?.lastReportedTime??0)));
      String timee =
          "${time.inHours != 0 ? "${time.inHours % 24}h" : ""} ${time.inMinutes != 0 ? "${time.inMinutes % 60}m" : ""}";
      connectedKids[getSelectedKidIndex(kidId)].lastActive = timee;
    // if (responseModel.data["code"] == 200) {
    //   Duration time = (DateTime.now().difference(
    //       DateTime.fromMillisecondsSinceEpoch(
    //           responseModel.data["data"]["lastReportedTime"])));
    //   String timee =
    //       "${time.inHours != 0 ? "${time.inHours % 24}h" : ""} ${time.inMinutes != 0 ? "${time.inMinutes % 60}m" : ""}";
    //   connectedKids[getSelectedKidIndex(kidId)].lastActive = timee;
    //   print(
    //       'responseModel.data["data"]["realtimeStats"]["batteryLevel"]:::${responseModel.data["data"]["realTimeStats"]["batteryLevel"]}');
    //   connectedKids[getSelectedKidIndex(kidId)].dataUsageStatus = responseModel
    //           .data["data"]["networkInfo"]["sim1"]["mDataRoaming"]
    //           ?.toString() ??
    //       "0";
    //   connectedKids[getSelectedKidIndex(kidId)].batteryStatus = responseModel
    //           .data["data"]["realTimeStats"]["batteryLevel"]
    //           ?.toString() ??
    //       "0";
    //
    //   /// ONLY FOR PRODUCTION
    //   DeviceDetail d = DeviceDetail.fromJson(responseModel.data);
    //   double totalTime = 0;
    //   for (int i = 0;
    //       i < (d.data?.realTimeStats?.appUsageData?.length ?? 0);
    //       i++) {
    //     totalTime += d.data!.realTimeStats!.appUsageData![i].mFgUsageTime ?? 0;
    //   }
    //   d.data?.realTimeStats?.totalAppUsageData = totalTime;
    //   connectedKids[getSelectedKidIndex(kidId)].deviceDetail = d;
    //
    //   /// ONLY FOR PRODUCTION
    // } else {
    //   // errorToast("Something went wrong!");
    // }
    update();
    isLoading = false;
  }

  Future<void> blacklistApp({required String kidId, required String deviceId, required String appPackage}) async {
    if (isLoading) return;
    isLoading = true;
    ResponseModel responseModel = await HomeRepo.sendActionToDevice(deviceId: deviceId.toString(), actionId: "27", message: appPackage);
    print("responseModel:::${responseModel.data}");
    if(responseModel.isSuccessful){
      await getDeviceDetail(kidId: kidId);
    }
    isLoading = false;
  }

  Future<void> deleteApp({required String kidId, required String deviceId, required String appPackage}) async {
    if (isLoading) return;
    isLoading = true;
    ResponseModel responseModel = await HomeRepo.sendActionToDevice(deviceId: deviceId.toString(), actionId: "20", message: appPackage);
    if(responseModel.isSuccessful){
      await getDeviceDetail(kidId: kidId);
    }
    // List<ListOfInstalledApp> apps = connectedKids[getSelectedKidIndex(kidId)]
    //         .appUsage!
    //         .listOfInstalledApps ??
    //     [];
    // int index = -1;
    // for (int i = 0; i < apps.length; i++) {
    //   print("appId: ${appId}");
    //   print("apps[i].appId: ${apps[i].appName}");
    //   print("apps[i].appId: ${apps[i].appId}");
    //   if (apps[i].appId == appId) {
    //     index = i;
    //     break;
    //   }
    // }
    // print("index: $index");
    // if (index != -1) {
    //   connectedKids[getSelectedKidIndex(kidId)]
    //       .appUsage!
    //       .listOfInstalledApps
    //       ?.removeAt(index);
    // }
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
    print("getBlacklistUrls");
    ResponseModel responseModel = await SingleKidRepo.getBlacklistUrls(kidId: getSelectedKid(kidId??"").kidId??"");
    print("getBlacklistUrls:::${responseModel.data}");
    print("getBlacklistUrls");
    connectedKids[getSelectedKidIndex(kidId!)].blockedUrls =
        BlockedUrlModel.fromJson(responseModel.data
    //         {
    //   "blocked_urls_data": {
    //     "kid_device_uid": "123456789",
    //     "parent_device_uid": "987654321",
    //     "blocked_urls": [
    //       "https://example.com/inappropriate-site1",
    //       "https://example.com/inappropriate-site2",
    //       "https://example.com/inappropriate-site3"
    //     ]
    //   }
    // }
    );
    print(
        "connectedKids[getSelectedKidIndex(kidId!)].blockedUrls:::${connectedKids[getSelectedKidIndex(kidId!)].blockedUrls}");
    update();
    // isLoading = false;
  }

  Future<void> addBlacklistUrl({String? kidId, String? url}) async {
    if((url??"").isEmpty) return;
    if (isLoading) return;
    isLoading = true;
    ResponseModel responseModel = await SingleKidRepo.addBlacklistUrl(kidId: connectedKids[getSelectedKidIndex(kidId!)].kidId, url: url);
    print("addBlacklistUrl::responseModel:::${responseModel.data}");
    if(responseModel.isSuccessful){
      connectedKids[getSelectedKidIndex(kidId!)].blockedUrls?.blockedUrlsData?.blockedUrls?.add(url??"");
      successToast(responseModel.data["message"]);
    }
    isLoading = false;
  }

  Future<void> getMessageThreads({String? kidId}) async {
    // var tempDataThreads = [
    //   {
    //     "thread_id": "thread_1",
    //     "last_message": {
    //       "message_data": {
    //         "kidDeviceUID": "123456789",
    //         "sender_contact": null,
    //         "sender_number": "+1234567890",
    //         "receiver_contact": "Parent",
    //         "receiver_number": "+9876543210",
    //         "message": "Thanks! You too. Catch you later!",
    //         "message_time_stamp": "2023-11-10T15:55:00Z",
    //         "media_attachments": null
    //       }
    //     }
    //   },
    //   {
    //     "thread_id": "thread_2",
    //     "last_message": {
    //       "message_data": {
    //         "kidDeviceUID": "987654321",
    //         "sender_contact": "Friend",
    //         "sender_number": "+1122334455",
    //         "receiver_contact": null,
    //         "receiver_number": "+9876543210",
    //         "message": "Sure! Let's plan something fun for the weekend.",
    //         "message_time_stamp": "2023-11-10T18:30:00Z",
    //         "media_attachments": null
    //       }
    //     }
    //   },
    //   {
    //     "thread_id": "thread_3",
    //     "last_message": {
    //       "message_data": {
    //         "kidDeviceUID": "987654321",
    //         "sender_contact": "Friend",
    //         "sender_number": "+1122334455",
    //         "receiver_contact": null,
    //         "receiver_number": "+9876543210",
    //         "message": "Just chilling and watching a movie. How about you?",
    //         "message_time_stamp": "2023-11-10T18:30:00Z",
    //         "media_attachments": null
    //       }
    //     }
    //   },
    //   {
    //     "thread_id": "thread_4",
    //     "last_message": {
    //       "message_data": {
    //         "kidDeviceUID": "987654321",
    //         "sender_contact": "Friend",
    //         "sender_number": "+1122334455",
    //         "receiver_contact": null,
    //         "receiver_number": "+9876543210",
    //         "message":
    //             "That's awesome! Anything exciting planned for the evening?",
    //         "message_time_stamp": "2023-11-10T18:30:00Z",
    //         "media_attachments": null
    //       }
    //     }
    //   },
    //   {
    //     "thread_id": "thread_5",
    //     "last_message": {
    //       "message_data": {
    //         "kidDeviceUID": "987654321",
    //         "sender_contact": "Friend",
    //         "sender_number": "+1122334455",
    //         "receiver_contact": null,
    //         "receiver_number": "+9876543210",
    //         "message": "School was good! I aced my math quiz.",
    //         "message_time_stamp": "2023-11-10T18:30:00Z",
    //         "media_attachments": null
    //       }
    //     }
    //   },
    //   {
    //     "thread_id": "thread_6",
    //     "last_message": {
    //       "message_data": {
    //         "kidDeviceUID": "987654321",
    //         "sender_contact": "Friend",
    //         "sender_number": "+1122334455",
    //         "receiver_contact": null,
    //         "receiver_number": "+9876543210",
    //         "message": "Hey kiddo! How was school today?",
    //         "message_time_stamp": "2023-11-10T18:30:00Z",
    //         "media_attachments": null
    //       }
    //     }
    //   }
    // ];

    List<ThreadModel> tempDataThreadsFinal = [];
    for (int i = 0; i < [].length; i++) {
      // tempDataThreadsFinal.add(ThreadModel.fromJson(tempDataThreads[i]));
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
      if (kidId == connectedKids[i].deviceData?.deviceId) {
        index = i;
        break;
      }
    }
    // print("Index::::$index");
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

  void getData() async {
    const workingPrivateKey =
        "-----BEGIN PRIVATE KEY-----\nMIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKmuOjB3/IBVOPirPcAws0LKGl/KYIofT0xpdz3Iv4twXZFIl1hMGVntSsHJH9ThwwQ2VegOCyiSdRNzCK39br2FQSk27JEVvOaA9nUxnGndSqB5QAEdvSKi8w0yGtKGVrQrciEq0Cqx1SlwwU5tZa9V7+QJxVnnTkGAVl3F1GKVAgMBAAECgYEAivizl/bty34BR0mZLcu1RkKZD1OFdhrmq8LFcsj0eJPzToaRzjOln82FqOm9NHIjc1O9UG4QHY62bNOOjFJBW4XhYtibydK3A93nR56cqDr6t0xZQakCAw7jqvH/g2xt6CLw2ySxrZ2OB2EsljLuhSMXijXoGeJOhfLacOlTM5ECQQD1C5HIt9EnnEQXojAp49TRor1sNiJUo4DOW2st3vGHHJf+t+6V/lb/AsFA5i4dgCYor0x/EC5ZCA0g98p0uqHLAkEAsUQk5jDFIFq2ft8lZAkOavi+ygk2SGyoJAlrxX7fPfxCIn9B6YT9utEpmQLKitLIS9lqPr/awFm9GAl9wqsBHwJAIa9adf4WyVwo3BrWhhukmMDHS0XRyFLFlRhqDl80Un9ywXglWwcgjGOjjzlVI4cHN9aJLHpb9K8vptWJRiyVqwJAZt9mDpSFAdbDC/PSDjDXRisfBb682uD73xX8jjunsKBBfSWfCbcdTJpv6pVdF51lkecVql7Kw1AQ1e9EJYH5/wJAFnaHGyo1Xm4GS++QPJeC6QLaslTAplb7w5gFJCJUErS1HB2g7VzIdWiWBMYj1v9e2sPQPB31er+hpyfK5zcLhw==\n-----END PRIVATE KEY-----\n";
    const workingEncryptedData =
        "PJQfNjS2gwuoqQ1k1j4givlFHebpQkSf7KqnWhQyrtToLwO1p7MP+koTPkCacINsXUjrfh1wDc2NV/5kSjnhkcK+ifhoEo/KeZCIhw/gxbazRMKctkk6wt1aUo3Uu2jrdbo6h9GHpRWwsq7nsDk3nNOkCVA4gHOzgSKSayWamwQ=";
    // var privateKey =
    //     """-----BEGIN PRIVATE KEY-----\n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\nXePq5IrmXuPu3CzEkem+8f3hAbZgzw0=\n-----END PRIVATE KEY-----\n"""; //.replaceAll("\n", "").replaceAll("-----END PRIVATE KEY-----", "").replaceAll("-----BEGIN PRIVATE KEY-----", "");
    var privateKey =
        """-----BEGIN PRIVATE KEY-----\n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\nptUcmX46+7DXCjjtIwd9WH7DRAZjqtI=\n-----END PRIVATE KEY-----\n""";
    const encryptedData =
        "hs6YPRluzcEWmT7y6Rfz0EmyEuDM7DGVk6ktcG9Mnl6r8pY73XqEiNBFfOFd5jVW+Y1VU+wOrmfVI/mWGbinbdzD4qpFEAftLm2OfE2peBdvDiW8lVcXhtW20UENlTlD8KTJqsAD6F5lFYx5zp0ovxCX4L+euKOVpuKTeB1pqH9v9uMRjfRc17cEQL3F9+U45hztybWKBLZd8Hip0BjuXBsQXjS9ZKvV8umWcWOzIRvd3NGvqvMniXUyELjKWE77m5fuanat5EaNeuZ+YSqivowrBDoFQC/3Om+6qAL45g8KEkn4SMEW40Ume73NZUL0bzh1ZSyF4FNyd434oSoq2cG3jXW9RsZ/akoGdAK6aQX4mPkSecxRYBj4ajulFDk89Mml7SV3UQ7Z4aGx5+hsO+H0cX5c5D/X8cPsb3ZW+jk6iNUqPdX07LKyK3IiRa4UdZ5eCOXoT4rIJWoR6dtG3OE5Im26kUj3dUSehRx14PMIaWASH0XmL78Xd8E0RBex36GVxkrh88RzkifMxwVTPTugfHRU7f9s4X6fOYTnS26ClCjzMjBgCqRsteyrEMCixJiBwOy1LofSnv62NTr7Ywx+bUsghzR2cXsXCVEEIexhy3nJtlJzyYVP2jsq7nREJZPQaOMciKeXptCt4NFY6MNslXbqavc+XhW+DEOZqBM=";

    /// /// /// /// /// /// /// /// /// /// ///
    var privateKey1 =
        """-----BEGIN PRIVATE KEY-----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-----END PRIVATE KEY-----\n"""
            .replaceAll("\n", "")
            .replaceAll("-----END PRIVATE KEY-----", "")
            .replaceAll("-----BEGIN PRIVATE KEY-----", "");
    const encryptedData1 =
        "IFitT0dS9HQT5JtqREoKFO4x05m/QSLC5Ch4F5UmVWiZG7tfidaeSia/lKl0kt6flS6DqZYf3+zoTUREH0b23SR3uBOC8M/zko7H9D5ou2Jmw2SdCqiFyq3YPh6o/Se6FVFrrmLGHbbqHY6Td3NdL1r3ot4oxNRUcH+4Qmis1EHuqAhY8EMLVUCq1Td26r4/jacwE6KHZyOAxnpx1UI0hiQXox2ShboFlimuOb1KMlZJBBI4I7HhSEsdtayKrH/UKxGwZJEi+wF+PEJupK+u/00Ew3XE6ZX9DUv2iENL9FDpo20i7qkLfEfzt2n/JZ95GPNn9HVkBAeJUYEOir67Q2+FxW/i5ZGfr9nWljcdKQxsXGMrdT81EKZVXDEq2GNuPUIwctTx8ZrDUZXNcAvilzEqppNl3p/9uzgGi/a1KsGQQqE/aCCBKxSeB925N39tVP2EHchPO+6d7qJiUf8ogAhr8IlPMxmVnv/fmyjdhmrTX/EdpgpyWHgSZZG1iJaMayxspGhXceOhV6sv6N0t+l8T6y4L0ElUnYtp6GsxpYyewt/e7ImOpc1F+Aar3osiSr1wgqhFBYWV7QPxmb8lV8h0RJshrUHHo1803i86CSmFaAHOHJpc3ij8+ymSd7OsLUkrIQCzxTTBFkwp4Bydlu0Nw0m+TZK6iKtIBgTfqeQ=";
    // print("privateKEY::$privateKey");
    print(decryptByPrivateKey1(privateKey,encryptedData));
    // cryptonDec(privateKey, encryptedData);
    // decrypt9Feb(privateKey, encryptedData);
    // print("jsDecrypt::${jsDecrypt()}");
    // print(decryptByPrivateKey1(privateKey,encryptedData));
    // print(await decryptData(privateKey, base64.decode(encryptedData)));
    // print(decryptByPrivateKey(privateKey, encryptedData));
    // newDecrypt(encryptedData1, privateKey1);
  }

  String decryptByPrivateKey(String private, String content) {
    encrypt.RSAKeyParser parser = encrypt.RSAKeyParser();
    RSAPrivateKey privateKey = parser.parse(private) as RSAPrivateKey;
    AsymmetricBlockCipher cipher = PKCS1Encoding(RSAEngine());
    cipher.init(false, PrivateKeyParameter<RSAPrivateKey>(privateKey));

    // print("privateKey.privateExponent");
    // print(privateKey.privateExponent);
    return utf8.decode(cipher.process(
        base64.decode(content) /*Encrypted.fromBase64(content).bytes*/));
    // Working here
  }
  // String decrypt(String keyString, Encrypted encryptedData) {
  //   print("Step 1");
  //   final key = Key.fromUtf8(keyString);
  //   print("Step 2");
  //   final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  //   print("Step 3");
  //   final initVector = IV.fromUtf8(keyString.substring(0, 16)/*"2gtCJbNlyuzUzLyRKIL4Xg=="*/);//keyString.substring(0, 16)
  //   print("Step 4");
  //   return encrypter.decrypt(encryptedData, iv: initVector);
  // }

  decryptData(String privateKeyString, Uint8List encryptedData) async {
    final rsa.RSAPKCSParser parser = rsa.RSAPKCSParser();
    final rsa.RSAKeyPair pair = parser.parsePEM(privateKeyString);
    final rsa.RSAPrivateKey privateKey = pair.private!;
    // var result = await rsa1.RSA();
    String prv = await rsa1.RSA.convertPrivateKeyToPKCS8(privateKeyString);

    // CryptoUtils.rsaPublicKeyFromPem(prv);
    print("prv::");
    print("$prv");

    PaddedBlockCipher cipher = PaddedBlockCipherImpl(
      PKCS7Padding() /*Padding("RSA/ECB/PKCS5Padding")*/, // Java defaults to PKCS5 which is equivalent
      ECBBlockCipher(
          AESFastEngine()), // Very weak mode - don't use this in the real world
    );

    cipher.init(
      false,
      PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
        KeyParameter(Uint8List.fromList(utf8.encode(prv))),
        null,
      ),
    );
    return cipher.process(encryptedData);

    /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
    // final rsaPrivateKey = parsePrivateKeyFromPem(prv);
    // final service = Encrypter(RSA(privateKey: rsaPrivateKey));
    //
    // print(service.decrypt(Encrypted(encryptedData)));
    //
    // final cipher = PKCS1Encoding(RSAEngine())
    //   ..init(false, PrivateKeyParameter<RSAPrivateKey>(rsaPrivateKey));
    //
    //
    // try {
    //   return cipher.process(encryptedData);
    // } catch (e) {
    //   print('Decryption error: $e');
    //   return Uint8List(0);
    // }
  }

  RSAPrivateKey parsePrivateKeyFromPem(String pemString) {
    final keyParser = encrypt.RSAKeyParser();
    final keyPair = keyParser.parse(pemString);

    if (keyPair is RSAPrivateKey) {
      return keyPair;
    } else {
      throw ArgumentError('Provided key is not an RSA private key.');
    }
  }
  // RSAPrivateKey parsePrivateKeyFromPem(String pemString) {
  //   final lines = pemString.split('\n');
  //   // final keyBytes = lines.sublist(1, lines.length - 1).join();
  //   // final decodeKey = base64.decode(keyBytes);
  //   final keyInfo = RSAKeyParser().parse(pemString);
  //   return RSAPrivateKey(
  //     keyInfo.modulus!,
  //     keyInfo.exponent!,
  //     keyInfo.n,
  //     keyInfo.n
  //   );
  // }
  // Uint8List decryptData(String privateKeyString, Uint8List encryptedData) {
  //   final privateKey = RSAPrivateKey.fromString(privateKeyString);
  //   final cipher = PKCS1Encoding(RSAEngine())
  //     ..init(false, PrivateKeyParameter<RSAPrivateKey>(privateKey));
  //
  //   try {
  //     return cipher.process(encryptedData);
  //   } catch (e) {
  //     print('Decryption error: $e');
  //     return Uint8List(0);
  //   }
  // }

  newDecrypt(encrypted, pkey) {
    // Your private key and IV

    // final key = encrypt.Key.fromUtf8('put32charactershereeeeeeeeeeeee!'); //32 chars
    // final iv = encrypt.IV.fromUtf8('put16characters!');
    //
    // final e = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    // final decryptedData = e.decrypt(encrypt.Encrypted.fromBase64(encrypted), iv: iv);
    // return decryptedData;
    print(pkey.toString().codeUnits);
    // final String privateKey = pkey; // Replace with your actual private key
    const String ivKey =
        '7PrYfqIrncey9ATaQQdWDQ=='; // Replace with your actual IV key
    // print("Private Key::$privateKey");
    // print("buffer:::${Uint32List.fromList([149, 50, 126, 191, 21, 20, 44, 71, 240, 174, 181, 74, 63, 57, 205, 252, 196, 237, 171, 7, 79, 4, 192, 3, 33, 99, 35, 85, 165, 140, 134, 172]).length}");
    final key = encrypt.Key.fromBase64(base64Encode(pkey)); //32 chars
    final iv = encrypt.IV.fromBase64(ivKey);

    final e = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final decryptedData =
        e.decrypt(encrypt.Encrypted.fromBase64(encrypted), iv: iv);

    print("Data:::");
    print(decryptedData);
  }

  // decrypt7Feb(encryptedSymmetricKey, privateKey){
  String decryptByPrivateKey1(String public, String content) {
    encrypt.RSAKeyParser parser = encrypt.RSAKeyParser();
    RSAPrivateKey publicKey = parser.parse(public) as RSAPrivateKey;
    AsymmetricBlockCipher cipher = PKCS1Encoding(RSAEngine());

    // encrypt.Encrypted.fromBase64(public).;
    var encr = encrypt.Encrypter(
      encrypt.RSA(
          privateKey: publicKey,
          encoding: encrypt.RSAEncoding.OAEP,
          digest: encrypt.RSADigest.SHA256),
    );

    print("Herllo Derypt");
    var newKey = encr.decryptBytes(encrypt.Encrypted.fromBase64(content));
    print("newkey:::$newKey");

    // newDecrypt("UPF+VyA/MSlV9VJX28EHSA==", newKey);
    return "";
    // cipher
    //   ..init(false, PrivateKeyParameter<RSAPrivateKey>(publicKey));
    // return utf8.decode(cipher.process(encrypt.Encrypted.fromBase64(content).bytes));
  }
  // if (privateKey == null || privateKey.isEmpty) {
  //  throw Exception('Invalid private key value');
  // }
  //
  // RSAPrivateKey rsaPrivateKey1 = parsePrivateKeyFromPem(privateKey);
  //   // RSAPrivateKey.fromPEM(privateKey) as PrivateKey;
  //
  // var rsaPrivateKey = encrypt.Encrypter(encrypt.RSA(privateKey: rsaPrivateKey1));
  //
  // Uint8List decryptedSymmetricKey = rsaPrivateKey.decrypt(
  //  encryptedSymmetricKey,
  //  pointy.AsymmetricEngine.OAEP,
  //  pointy.AsymmetricEngine.OAEP_PADDING,
  //  null,
  // );
  //
  // pointy.BlockCipher aesCipher = pointy.BlockCipher("AES/CBC/PKCS7");
  // pointy.ParametersWithIV<pointy.KeyParameter> params =
  //   pointy.ParametersWithIV<pointy.KeyParameter>(
  //     pointy.KeyParameter(decryptedSymmetricKey), base64Decode("oy76wjF0b0HSxAGBM7D1Og=="));
  //
  // aesCipher.init(false, params);
  //
  // Uint8List decryptedData = aesCipher.process(base64Decode("HZ3uyFugo93lOEzKsPBXRw=="));
  //
  // return utf8.decode(decryptedData);
  // }

  int steps = 0;
  printSteps(s) {
    print("Step: $s");
  }

  jsDecrypt() async {
    print("JS Decrypt: 1");
    final JavascriptRuntime javascriptRuntime =
        getJavascriptRuntime(forceJavascriptCoreOnAndroid: false);
    print("JS Decrypt: 2");
    JsEvalResult jsResult = await javascriptRuntime.evaluateAsync("""
const crypto = global.crypto;
function decryptPayload() {
var privateKey = `-----BEGIN PRIVATE KEY-----
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
XePq5IrmXuPu3CzEkem+8f3hAbZgzw0=
-----END PRIVATE KEY-----`;

const encryptedSymmetricKey =
"QpJOlvKPgtR+RgvfEkMOK/4lnoBXpkYKctChzTu0JDyGdj0qHm6hF6KLtYVVARKWCZtQ/fYBqFzB5wieXbQL7hqALDpHrxuNA0cKCzCe5QGZZCjE2xlaBr4Bdtdn1Lhr+Kt7qiZrrCHBMLQNcQk3eusx+DgqNLhMEZpQdkBiXDLXmjUS/1TSYu4bZEQ9fqFSXpefLCKaAaRw4Mlup+g95TAPYA40RQHmC5w3ASptMHdpXS/MDYGu9R9IP8rMxp16PEkZYY4I6Yytu3SL0x2gCYcKrm/rdjLymCWJ7mZ0HqETvfq5lTg3Leb4dbiPnfxKgfF5Xez+I73EuagYmm8FuCelOZAzITRxu5za/XLE0J4aDkqBwP8G4MjhIaekJKWFX9c7KDpbdGER3YDa+7P1zpvgN04ioO6v1ZEg1eq6vv/Z0qXtX07E39H3T2ylxFBST0titOFOTATtioRZ+Gj08aRM3MvkrbLbyy4p3ag6g1eDaiXsyL/hI1AM087YovTjNgaZf/r/MbavEsmSSXLPP4rboy05cjBt2mQ8gY8uIGqjzXu6SNkOwV9mw/JkO+v51wJrSJCVh2YbuoxdNnTOzz7WTy+MaAB+0wkwIsyQ8icQGbQALL5LEBmdPclUC5if7IiJMDLwx8PMhH1mIu/b1Vyd3OzIPnWamnuxH34gX7A=";

        if (!privateKey) {
            throw new Error("Invalid private key value")
        }

        crypto.privateDecrypt({
            key: privateKey,
            padding: crypto.constants.RSA_PKCS1_OAEP_PADDING,
            oaepHash: 'sha256',
        }, Buffer.from(encryptedSymmetricKey, 'base64'));
    }
    decryptPayload();

""", sourceUrl: 'script.js');
    print("JS Decrypt: 3");
    javascriptRuntime.executePendingJob();
    print("JS Decrypt: 4");
    JsEvalResult asyncResult = await javascriptRuntime.handlePromise(jsResult);

    print("asyncResult.stringResult:::${asyncResult.stringResult}");
  }

  decrypt9Feb(key, data) {
// Example data and RSA private key
    String encryptedBase64 = "$data"; // Your encrypted data in base64 format
    String privateKeyPEM = "$key"; // Your RSA private key in PEM format

    // Decode the base64 encrypted data
    Uint8List encryptedBytes = base64.decode(encryptedBase64);

    // Decode the RSA private key from PEM format
    Uint8List privateKeyData = utf8.encode(privateKeyPEM);
    final parser = encrypt.RSAKeyParser();
    final RSAPrivateKey privateKey =
        parser.parse(privateKeyPEM) as RSAPrivateKey;

    // Initialize RSA decryption with the private key
    final decryptor = OAEPEncoding(RSAEngine())
      ..init(false, PrivateKeyParameter<RSAPrivateKey>(privateKey));

    // Perform decryption
    Uint8List decryptedBytes = decryptor.process(encryptedBytes);

    // Convert decrypted bytes to a string
    String decryptedString = utf8.decode(decryptedBytes);

    // Output the decrypted string
    print("Decrypted data: $decryptedString");
  }

  cryptonDec(String key, String data) {
    var private = c.RSAPrivateKey.fromPEM(key);

    print("new decrypt");
    print(private.decryptData(private.createSHA256Signature(base64Decode(data))));
  }
}

class Payload {
  final Uint8List encryptedSymmetricKey;
  final Uint8List iv;
  final Uint8List encryptedData;

  Payload(this.encryptedSymmetricKey, this.iv, this.encryptedData);
}
