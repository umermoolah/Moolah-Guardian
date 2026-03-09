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
    print("--- START: getSyncedKidDevices ---");
    ResponseModel responseModel = await HomeRepo.getSyncedKidDevices();

    log("getConnectedKidDevices Response Data: ${responseModel.data}");
    
    if (responseModel.isSuccessful && responseModel.data != null && responseModel.data["devices"] != null) {
      List<Kid> temp = [];
      var devicesList = responseModel.data["devices"] as List;
      
      print("Found ${devicesList.length} devices. Processing...");
      
      for (var tem in devicesList) {
        print("Syncing device: ${tem["kidFullName"]} (ID: ${tem["kidDeviceAccountUserID"]})");
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
      
      connectedKids = temp;
      print("Successfully updated connectedKids list. Total: ${connectedKids.length}");
    } else {
      print("ERROR or EMPTY: Failed to fetch synced devices. Data: ${responseModel.data}");
    }

    update();
    print("--- END: getSyncedKidDevices ---");
  }

  getWalletStatus({required String kidId}) async {
    int index = getSelectedKidIndex(kidId);
    ResponseModel responseModel = await SingleKidRepo.getWalletStatus(kidId: kidId);
    print("getWalletStatus Response: ${responseModel.data}");
    if(responseModel.isSuccessful && responseModel.data != null) {
      connectedKids[index] = connectedKids[index].copyWith(walletEnabled: responseModel.data["walletEnabled"]);
    }
    update();
  }

  getMSMSMonitoringStatus({required String kidId}) async {
    int index = getSelectedKidIndex(kidId);
    ResponseModel responseModel = await SingleKidRepo.getMSMSMonitoringStatus(kidId: kidId);
    print("getMSMSMonitoringStatus Response: ${responseModel.data}");
    if(responseModel.isSuccessful && responseModel.data != null) {
      connectedKids[index] = connectedKids[index].copyWith(msmsMonitoringStatus: responseModel.data["msmsMonitoringStatus"]);
    }
    update();
  }

  Future<void> enableMSMSMonitoring({required String kidId, required bool value}) async {
    if (isLoading) return;
    isLoading = true;
    print("Enabling MSMS Monitoring: $value for kidId: $kidId");
    int index = getSelectedKidIndex(kidId);
    connectedKids[index] = connectedKids[index].copyWith(msmsMonitoringStatus: value);
    update();
    
    ResponseModel responseModel = await SingleKidRepo.enableMSMSMonitoring(kidId: kidId, enable: value);
    print("enableMSMSMonitoring Response: ${responseModel.data}");
    isLoading = false;
  }

  Future<void> enableWallet({required String kidId, required bool value}) async {
    if (isLoading) return;
    isLoading = true;
    print("Enabling Wallet: $value for kidId: $kidId");
    int index = getSelectedKidIndex(kidId);
    connectedKids[index] = connectedKids[index].copyWith(walletEnabled: value);
    update();
    
    ResponseModel responseModel = await SingleKidRepo.enableWallet(kidId: kidId, enable: value);
    print("enableWallet Response: ${responseModel.data}");
    isLoading = false;
  }

  Future<void> getAppUsage({required String kidId}) async {
    if (connectedKids[getSelectedKidIndex(kidId)].appUsage == null) {
      connectedKids[getSelectedKidIndex(kidId)].appUsage = AppUsage(
          deviceDailyAvgUsage: "7h 32 m",
          deviceDailyAvgUsageChange: "+35% from last Week",
          installedAppsCount: 4,
          listOfInstalledApps: [],
          msg: "",
          success: true);
    }
    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
  }

  Future<void> getDeviceDetail({required String kidId}) async {
    isLoading = true;
    print("Fetching Device Details for: $kidId");
    ResponseModel responseModel = await SingleKidRepo.getDeviceDetails(kidId: kidId);
    
    if (responseModel.isSuccessful && responseModel.data != null) {
      String resp = jsonEncode(responseModel.data);
      log("getDeviceDetail Response: $resp");
      
      var decodedData = jsonDecode(resp);
      int index = getSelectedKidIndex(kidId);
      
      connectedKids[index].msmsMonitoringStatus = decodedData["msmsMonitoringStatus"];
      DeviceDetail detail = DeviceDetail.fromJson(decodedData);
      connectedKids[index].deviceDetail = detail;
      
      Duration time = (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(detail.data?.lastReportedTime ?? 0)));
      String timee = "${time.inHours != 0 ? "${time.inHours % 24}h" : ""} ${time.inMinutes != 0 ? "${time.inMinutes % 60}m" : ""}";
      connectedKids[index].lastActive = timee;
    } else {
      print("Failed to fetch device details for: $kidId");
    }
    
    update();
    isLoading = false;
  }

  Future<void> blacklistApp({required String kidId, required String deviceId, required String appPackage}) async {
    if (isLoading) return;
    isLoading = true;
    print("Blacklisting app: $appPackage on device: $deviceId");
    ResponseModel responseModel = await HomeRepo.sendActionToDevice(deviceId: deviceId.toString(), actionId: "27", message: appPackage);
    print("blacklistApp Response: ${responseModel.data}");
    if(responseModel.isSuccessful){
      await getDeviceDetail(kidId: kidId);
    }
    isLoading = false;
  }

  Future<void> deleteApp({required String kidId, required String deviceId, required String appPackage}) async {
    if (isLoading) return;
    isLoading = true;
    print("Deleting app: $appPackage on device: $deviceId");
    ResponseModel responseModel = await HomeRepo.sendActionToDevice(deviceId: deviceId.toString(), actionId: "20", message: appPackage);
    print("deleteApp Response: ${responseModel.data}");
    if(responseModel.isSuccessful){
      await getDeviceDetail(kidId: kidId);
    }
    isLoading = false;
  }

  Future<void> getBlacklistUrls({String? kidId}) async {
    print("Fetching Blacklist URLs for: $kidId");
    ResponseModel responseModel = await SingleKidRepo.getBlacklistUrls(kidId: getSelectedKid(kidId ?? "").kidId ?? "");
    print("getBlacklistUrls Response: ${responseModel.data}");
    
    if (responseModel.isSuccessful && responseModel.data != null) {
      connectedKids[getSelectedKidIndex(kidId!)].blockedUrls = BlockedUrlModel.fromJson(responseModel.data);
    }
    update();
  }

  Future<void> addBlacklistUrl({String? kidId, String? url}) async {
    if((url ?? "").isEmpty) return;
    if (isLoading) return;
    isLoading = true;
    print("Adding URL to Blacklist: $url for kidId: $kidId");
    ResponseModel responseModel = await SingleKidRepo.addBlacklistUrl(kidId: connectedKids[getSelectedKidIndex(kidId!)].kidId, url: url);
    print("addBlacklistUrl Response: ${responseModel.data}");
    if(responseModel.isSuccessful){
      connectedKids[getSelectedKidIndex(kidId!)].blockedUrls?.blockedUrlsData?.blockedUrls?.add(url ?? "");
      successToast(responseModel.data["message"]);
    }
    isLoading = false;
  }

  Future<void> getMessageThreads({String? kidId}) async {
    print("Fetching Message Threads for: $kidId");
    List<ThreadModel> tempDataThreadsFinal = [];
    connectedKids[getSelectedKidIndex(kidId!)].threads = tempDataThreadsFinal;
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
    return index;
  }

  Kid getSelectedKid(String kidId) {
    return connectedKids[getSelectedKidIndex(kidId)];
  }

  Future<List<MessageModel>> getMessages({String? threadId}) async {
    print("Fetching Messages for Thread: $threadId");
    List<MessageModel> tempMessagesFinal = [];
    return tempMessagesFinal;
  }

  void logout() {
    connectedKids.clear();
    appUsageOfSelectedKid = null;
  }
}
