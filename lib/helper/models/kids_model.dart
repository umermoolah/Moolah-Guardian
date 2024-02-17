// To parse this JSON data, do
//
//     final kid = kidFromJson(jsonString);

import 'dart:convert';

import 'package:moolah/helper/models/thread_model.dart';

import 'app_usage_model.dart';
import 'blocked_url_model.dart';
import 'device_detail_model.dart';

Kid kidFromJson(String str) => Kid.fromJson(json.decode(str));

String kidToJson(Kid data) => json.encode(data.toJson());

class Kid {
  String? kidId;
  String? name;
  String? deviceType;
  String? batteryStatus;
  String? privateKey;
  String? connectId;
  String? dataUsageStatus;
  String? lastActive;
  String? kidPic;
  bool? walletEnabled;
  AppUsage? appUsage;
  DeviceDetail? deviceDetail;
  bool? msmsMonitoringStatus;
  List<ThreadModel> threads;
  BlockedUrlModel? blockedUrls;
  DeviceDetail? deviceData;

  Kid(
      {this.kidId,
      this.name,
      this.deviceType,
      this.batteryStatus,
      this.privateKey,
      this.connectId,
      this.dataUsageStatus,
      this.lastActive,
      this.kidPic,
      this.walletEnabled,
      this.appUsage,
      this.deviceDetail,
      this.threads = const [],
      this.blockedUrls,
      this.deviceData,
      this.msmsMonitoringStatus});

  Kid copyWith(
          {String? kidId,
          String? name,
          String? deviceType,
          String? batteryStatus,
          String? privateKey,
          String? connectId,
          String? dataUsageStatus,
          String? lastActive,
          String? kidPic,
          bool? walletEnabled,
          AppUsage? appUsage,
          DeviceDetail? deviceDetail,
          List<ThreadModel>? threads,
          BlockedUrlModel? blockedUrls,
          DeviceDetail? deviceData,
          bool? msmsMonitoringStatus}) =>
      Kid(
          kidId: kidId ?? this.kidId,
          name: name ?? this.name,
          deviceType: deviceType ?? this.deviceType,
          batteryStatus: batteryStatus ?? this.batteryStatus,
          privateKey: privateKey ?? this.privateKey,
          connectId: connectId ?? this.connectId,
          dataUsageStatus: dataUsageStatus ?? this.dataUsageStatus,
          lastActive: lastActive ?? this.lastActive,
          kidPic: kidPic ?? this.kidPic,
          walletEnabled: walletEnabled ?? this.walletEnabled,
          appUsage: appUsage ?? this.appUsage,
          deviceDetail: deviceDetail ?? this.deviceDetail,
          threads: threads ?? this.threads,
          blockedUrls: blockedUrls ?? this.blockedUrls,
          deviceData: deviceData ?? this.deviceData,
          msmsMonitoringStatus:
              msmsMonitoringStatus ?? this.msmsMonitoringStatus);

  factory Kid.fromJson(Map<String, dynamic> json) => Kid(
        kidId: json["kidID"],
        name: json["name"],
        deviceType: json["deviceType"],
        batteryStatus: json["batteryStatus"],
        connectId: json["connectID"],
        dataUsageStatus: json["dataUsageStatus"],
        lastActive: json["lastActive"],
        kidPic: json["kidPic"],
        walletEnabled: json["walletEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "kidID": kidId,
        "name": name,
        "deviceType": deviceType,
        "batteryStatus": batteryStatus,
        "connectID": connectId,
        "dataUsageStatus": dataUsageStatus,
        "lastActive": lastActive,
        "kidPic": kidPic,
        "walletEnabled": walletEnabled,
        "deviceDetail": deviceDetail?.toJson(),
        "deviceData": deviceData?.toJson(),
        "msmsMonitoringStatus": msmsMonitoringStatus
      };
}

// // To parse this JSON data, do
// //
// //     final deviceData = deviceDataFromJson(jsonString);
//
// DeviceData deviceDataFromJson(String str) => DeviceData.fromJson(json.decode(str));
//
// String deviceDataToJson(DeviceData data) => json.encode(data.toJson());
//
// class DeviceData {
//   String? id;
//   String? deviceStatus;
//   String? state;
//   String? city;
//   String? branch;
//   int? deviceInitTime;
//   int? hasAdminReg;
//   int? hasMultiUser;
//   String? imeiNumber;
//   String? deviceId;
//   int? lastReportedTime;
//   int? createdTime;
//   NetworkInfo? networkInfo;
//   HardwareInfo? hardwareInfo;
//   RealTimeStats? realTimeStats;
//   String? deviceType;
//   String? serialNumber;
//   String? bluetoothMacAddr;
//   String? wifiMacAddr;
//   String? version;
//   int? deviceLastSuspendTime;
//   bool? oemLocked;
//
//   DeviceData({
//     this.id,
//     this.deviceStatus,
//     this.state,
//     this.city,
//     this.branch,
//     this.deviceInitTime,
//     this.hasAdminReg,
//     this.hasMultiUser,
//     this.imeiNumber,
//     this.deviceId,
//     this.lastReportedTime,
//     this.createdTime,
//     this.networkInfo,
//     this.hardwareInfo,
//     this.realTimeStats,
//     this.deviceType,
//     this.serialNumber,
//     this.bluetoothMacAddr,
//     this.wifiMacAddr,
//     this.version,
//     this.deviceLastSuspendTime,
//     this.oemLocked,
//   });
//
//   DeviceData copyWith({
//     String? id,
//     String? deviceStatus,
//     String? state,
//     String? city,
//     String? branch,
//     int? deviceInitTime,
//     int? hasAdminReg,
//     int? hasMultiUser,
//     String? imeiNumber,
//     String? deviceId,
//     int? lastReportedTime,
//     int? createdTime,
//     NetworkInfo? networkInfo,
//     HardwareInfo? hardwareInfo,
//     RealTimeStats? realTimeStats,
//     String? deviceType,
//     String? serialNumber,
//     String? bluetoothMacAddr,
//     String? wifiMacAddr,
//     String? version,
//     int? deviceLastSuspendTime,
//     bool? oemLocked,
//   }) =>
//       DeviceData(
//         id: id ?? this.id,
//         deviceStatus: deviceStatus ?? this.deviceStatus,
//         state: state ?? this.state,
//         city: city ?? this.city,
//         branch: branch ?? this.branch,
//         deviceInitTime: deviceInitTime ?? this.deviceInitTime,
//         hasAdminReg: hasAdminReg ?? this.hasAdminReg,
//         hasMultiUser: hasMultiUser ?? this.hasMultiUser,
//         imeiNumber: imeiNumber ?? this.imeiNumber,
//         deviceId: deviceId ?? this.deviceId,
//         lastReportedTime: lastReportedTime ?? this.lastReportedTime,
//         createdTime: createdTime ?? this.createdTime,
//         networkInfo: networkInfo ?? this.networkInfo,
//         hardwareInfo: hardwareInfo ?? this.hardwareInfo,
//         realTimeStats: realTimeStats ?? this.realTimeStats,
//         deviceType: deviceType ?? this.deviceType,
//         serialNumber: serialNumber ?? this.serialNumber,
//         bluetoothMacAddr: bluetoothMacAddr ?? this.bluetoothMacAddr,
//         wifiMacAddr: wifiMacAddr ?? this.wifiMacAddr,
//         version: version ?? this.version,
//         deviceLastSuspendTime: deviceLastSuspendTime ?? this.deviceLastSuspendTime,
//         oemLocked: oemLocked ?? this.oemLocked,
//       );
//
//   factory DeviceData.fromJson(Map<String, dynamic> json) => DeviceData(
//     id: json["id"],
//     deviceStatus: json["deviceStatus"],
//     state: json["state"],
//     city: json["city"],
//     branch: json["branch"],
//     deviceInitTime: json["deviceInitTime"],
//     hasAdminReg: json["hasAdminReg"],
//     hasMultiUser: json["hasMultiUser"],
//     imeiNumber: json["imeiNumber"],
//     deviceId: json["deviceId"],
//     lastReportedTime: json["lastReportedTime"],
//     createdTime: json["createdTime"],
//     networkInfo: json["networkInfo"] == null ? null : NetworkInfo.fromJson(json["networkInfo"]),
//     hardwareInfo: json["hardwareInfo"] == null ? null : HardwareInfo.fromJson(json["hardwareInfo"]),
//     realTimeStats: json["realTimeStats"] == null ? null : RealTimeStats.fromJson(json["realTimeStats"]),
//     deviceType: json["deviceType"],
//     serialNumber: json["serialNumber"],
//     bluetoothMacAddr: json["bluetoothMacAddr"],
//     wifiMacAddr: json["wifiMacAddr"],
//     version: json["version"],
//     deviceLastSuspendTime: json["deviceLastSuspendTime"],
//     oemLocked: json["oemLocked"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "deviceStatus": deviceStatus,
//     "state": state,
//     "city": city,
//     "branch": branch,
//     "deviceInitTime": deviceInitTime,
//     "hasAdminReg": hasAdminReg,
//     "hasMultiUser": hasMultiUser,
//     "imeiNumber": imeiNumber,
//     "deviceId": deviceId,
//     "lastReportedTime": lastReportedTime,
//     "createdTime": createdTime,
//     "networkInfo": networkInfo?.toJson(),
//     "hardwareInfo": hardwareInfo?.toJson(),
//     "realTimeStats": realTimeStats?.toJson(),
//     "deviceType": deviceType,
//     "serialNumber": serialNumber,
//     "bluetoothMacAddr": bluetoothMacAddr,
//     "wifiMacAddr": wifiMacAddr,
//     "version": version,
//     "deviceLastSuspendTime": deviceLastSuspendTime,
//     "oemLocked": oemLocked,
//   };
// }
//
// class HardwareInfo {
//   double? cpuSpeed;
//   int? dpi;
//   String? manufacturer;
//   String? model;
//   String? operatingSystem;
//   String? osVersion;
//   int? screenHeight;
//   int? screenWidth;
//   int? totalMemory;
//   int? memoryUsed;
//   int? internalStorageSize;
//   double? screenSize;
//   int? screenDensity;
//   String? bootloader;
//   String? deviceFingerprint;
//   String? radioHwVersion;
//   bool? fingerprintSensor;
//   int? buildDate;
//   List<String>? abis;
//
//   HardwareInfo({
//     this.cpuSpeed,
//     this.dpi,
//     this.manufacturer,
//     this.model,
//     this.operatingSystem,
//     this.osVersion,
//     this.screenHeight,
//     this.screenWidth,
//     this.totalMemory,
//     this.memoryUsed,
//     this.internalStorageSize,
//     this.screenSize,
//     this.screenDensity,
//     this.bootloader,
//     this.deviceFingerprint,
//     this.radioHwVersion,
//     this.fingerprintSensor,
//     this.buildDate,
//     this.abis,
//   });
//
//   HardwareInfo copyWith({
//     double? cpuSpeed,
//     int? dpi,
//     String? manufacturer,
//     String? model,
//     String? operatingSystem,
//     String? osVersion,
//     int? screenHeight,
//     int? screenWidth,
//     int? totalMemory,
//     int? memoryUsed,
//     int? internalStorageSize,
//     double? screenSize,
//     int? screenDensity,
//     String? bootloader,
//     String? deviceFingerprint,
//     String? radioHwVersion,
//     bool? fingerprintSensor,
//     int? buildDate,
//     List<String>? abis,
//   }) =>
//       HardwareInfo(
//         cpuSpeed: cpuSpeed ?? this.cpuSpeed,
//         dpi: dpi ?? this.dpi,
//         manufacturer: manufacturer ?? this.manufacturer,
//         model: model ?? this.model,
//         operatingSystem: operatingSystem ?? this.operatingSystem,
//         osVersion: osVersion ?? this.osVersion,
//         screenHeight: screenHeight ?? this.screenHeight,
//         screenWidth: screenWidth ?? this.screenWidth,
//         totalMemory: totalMemory ?? this.totalMemory,
//         memoryUsed: memoryUsed ?? this.memoryUsed,
//         internalStorageSize: internalStorageSize ?? this.internalStorageSize,
//         screenSize: screenSize ?? this.screenSize,
//         screenDensity: screenDensity ?? this.screenDensity,
//         bootloader: bootloader ?? this.bootloader,
//         deviceFingerprint: deviceFingerprint ?? this.deviceFingerprint,
//         radioHwVersion: radioHwVersion ?? this.radioHwVersion,
//         fingerprintSensor: fingerprintSensor ?? this.fingerprintSensor,
//         buildDate: buildDate ?? this.buildDate,
//         abis: abis ?? this.abis,
//       );
//
//   factory HardwareInfo.fromJson(Map<String, dynamic> json) => HardwareInfo(
//     cpuSpeed: json["cpuSpeed"]?.toDouble(),
//     dpi: json["dpi"],
//     manufacturer: json["manufacturer"],
//     model: json["model"],
//     operatingSystem: json["operatingSystem"],
//     osVersion: json["osVersion"],
//     screenHeight: json["screenHeight"],
//     screenWidth: json["screenWidth"],
//     totalMemory: json["totalMemory"],
//     memoryUsed: json["memoryUsed"],
//     internalStorageSize: json["internalStorageSize"],
//     screenSize: json["screenSize"]?.toDouble(),
//     screenDensity: json["screenDensity"],
//     bootloader: json["bootloader"],
//     deviceFingerprint: json["deviceFingerprint"],
//     radioHwVersion: json["radioHwVersion"],
//     fingerprintSensor: json["fingerprintSensor"],
//     buildDate: json["buildDate"],
//     abis: json["abis"] == null ? [] : List<String>.from(json["abis"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cpuSpeed": cpuSpeed,
//     "dpi": dpi,
//     "manufacturer": manufacturer,
//     "model": model,
//     "operatingSystem": operatingSystem,
//     "osVersion": osVersion,
//     "screenHeight": screenHeight,
//     "screenWidth": screenWidth,
//     "totalMemory": totalMemory,
//     "memoryUsed": memoryUsed,
//     "internalStorageSize": internalStorageSize,
//     "screenSize": screenSize,
//     "screenDensity": screenDensity,
//     "bootloader": bootloader,
//     "deviceFingerprint": deviceFingerprint,
//     "radioHwVersion": radioHwVersion,
//     "fingerprintSensor": fingerprintSensor,
//     "buildDate": buildDate,
//     "abis": abis == null ? [] : List<dynamic>.from(abis!.map((x) => x)),
//   };
// }
//
// class NetworkInfo {
//   String? currentCarrier;
//   int? lastRoamingReportedTime;
//   int? lastUpdatedTime;
//   String? roamingStatus;
//   Sim? sim1;
//   Sim? sim2;
//   bool? mobileDataOn;
//   bool? wifiDataOn;
//   bool? mobileDataUsed;
//
//   NetworkInfo({
//     this.currentCarrier,
//     this.lastRoamingReportedTime,
//     this.lastUpdatedTime,
//     this.roamingStatus,
//     this.sim1,
//     this.sim2,
//     this.mobileDataOn,
//     this.wifiDataOn,
//     this.mobileDataUsed,
//   });
//
//   NetworkInfo copyWith({
//     String? currentCarrier,
//     int? lastRoamingReportedTime,
//     int? lastUpdatedTime,
//     String? roamingStatus,
//     Sim? sim1,
//     Sim? sim2,
//     bool? mobileDataOn,
//     bool? wifiDataOn,
//     bool? mobileDataUsed,
//   }) =>
//       NetworkInfo(
//         currentCarrier: currentCarrier ?? this.currentCarrier,
//         lastRoamingReportedTime: lastRoamingReportedTime ?? this.lastRoamingReportedTime,
//         lastUpdatedTime: lastUpdatedTime ?? this.lastUpdatedTime,
//         roamingStatus: roamingStatus ?? this.roamingStatus,
//         sim1: sim1 ?? this.sim1,
//         sim2: sim2 ?? this.sim2,
//         mobileDataOn: mobileDataOn ?? this.mobileDataOn,
//         wifiDataOn: wifiDataOn ?? this.wifiDataOn,
//         mobileDataUsed: mobileDataUsed ?? this.mobileDataUsed,
//       );
//
//   factory NetworkInfo.fromJson(Map<String, dynamic> json) => NetworkInfo(
//     currentCarrier: json["currentCarrier"],
//     lastRoamingReportedTime: json["lastRoamingReportedTime"],
//     lastUpdatedTime: json["lastUpdatedTime"],
//     roamingStatus: json["roamingStatus"],
//     sim1: json["sim1"] == null ? null : Sim.fromJson(json["sim1"]),
//     sim2: json["sim2"] == null ? null : Sim.fromJson(json["sim2"]),
//     mobileDataOn: json["mobileDataOn"],
//     wifiDataOn: json["wifiDataOn"],
//     mobileDataUsed: json["mobileDataUsed"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "currentCarrier": currentCarrier,
//     "lastRoamingReportedTime": lastRoamingReportedTime,
//     "lastUpdatedTime": lastUpdatedTime,
//     "roamingStatus": roamingStatus,
//     "sim1": sim1?.toJson(),
//     "sim2": sim2?.toJson(),
//     "mobileDataOn": mobileDataOn,
//     "wifiDataOn": wifiDataOn,
//     "mobileDataUsed": mobileDataUsed,
//   };
// }
//
// class Sim {
//   int? mId;
//   dynamic mIccId;
//   int? mSimSlotIndex;
//   dynamic mDisplayName;
//   dynamic mCarrierName;
//   int? mNameSource;
//   int? mIconTint;
//   dynamic mNumber;
//   int? mDataRoaming;
//   int? mMcc;
//   int? mMnc;
//   dynamic mCountryIso;
//   bool? mIsEmbedded;
//   String? mCardId;
//   dynamic imsi;
//   String? imei;
//
//   Sim({
//     this.mId,
//     this.mIccId,
//     this.mSimSlotIndex,
//     this.mDisplayName,
//     this.mCarrierName,
//     this.mNameSource,
//     this.mIconTint,
//     this.mNumber,
//     this.mDataRoaming,
//     this.mMcc,
//     this.mMnc,
//     this.mCountryIso,
//     this.mIsEmbedded,
//     this.mCardId,
//     this.imsi,
//     this.imei,
//   });
//
//   Sim copyWith({
//     int? mId,
//     dynamic mIccId,
//     int? mSimSlotIndex,
//     dynamic mDisplayName,
//     dynamic mCarrierName,
//     int? mNameSource,
//     int? mIconTint,
//     dynamic mNumber,
//     int? mDataRoaming,
//     int? mMcc,
//     int? mMnc,
//     dynamic mCountryIso,
//     bool? mIsEmbedded,
//     String? mCardId,
//     dynamic imsi,
//     String? imei,
//   }) =>
//       Sim(
//         mId: mId ?? this.mId,
//         mIccId: mIccId ?? this.mIccId,
//         mSimSlotIndex: mSimSlotIndex ?? this.mSimSlotIndex,
//         mDisplayName: mDisplayName ?? this.mDisplayName,
//         mCarrierName: mCarrierName ?? this.mCarrierName,
//         mNameSource: mNameSource ?? this.mNameSource,
//         mIconTint: mIconTint ?? this.mIconTint,
//         mNumber: mNumber ?? this.mNumber,
//         mDataRoaming: mDataRoaming ?? this.mDataRoaming,
//         mMcc: mMcc ?? this.mMcc,
//         mMnc: mMnc ?? this.mMnc,
//         mCountryIso: mCountryIso ?? this.mCountryIso,
//         mIsEmbedded: mIsEmbedded ?? this.mIsEmbedded,
//         mCardId: mCardId ?? this.mCardId,
//         imsi: imsi ?? this.imsi,
//         imei: imei ?? this.imei,
//       );
//
//   factory Sim.fromJson(Map<String, dynamic> json) => Sim(
//     mId: json["mId"],
//     mIccId: json["mIccId"],
//     mSimSlotIndex: json["mSimSlotIndex"],
//     mDisplayName: json["mDisplayName"],
//     mCarrierName: json["mCarrierName"],
//     mNameSource: json["mNameSource"],
//     mIconTint: json["mIconTint"],
//     mNumber: json["mNumber"],
//     mDataRoaming: json["mDataRoaming"],
//     mMcc: json["mMcc"],
//     mMnc: json["mMnc"],
//     mCountryIso: json["mCountryIso"],
//     mIsEmbedded: json["mIsEmbedded"],
//     mCardId: json["mCardId"],
//     imsi: json["imsi"],
//     imei: json["imei"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "mId": mId,
//     "mIccId": mIccId,
//     "mSimSlotIndex": mSimSlotIndex,
//     "mDisplayName": mDisplayName,
//     "mCarrierName": mCarrierName,
//     "mNameSource": mNameSource,
//     "mIconTint": mIconTint,
//     "mNumber": mNumber,
//     "mDataRoaming": mDataRoaming,
//     "mMcc": mMcc,
//     "mMnc": mMnc,
//     "mCountryIso": mCountryIso,
//     "mIsEmbedded": mIsEmbedded,
//     "mCardId": mCardId,
//     "imsi": imsi,
//     "imei": imei,
//   };
// }
//
// class RealTimeStats {
//   int? rtLastUpdatedTime;
//   int? isOnline;
//   int? lastUpdatedTime;
//   int? brightnessLevel;
//   int? cpuUtilization;
//   int? memoryUsed;
//   int? powerOnTime;
//   int? screenOnTime;
//   int? hasMultiUser;
//   bool? selEnforced;
//   bool? deviceRooted;
//   bool? gsfInstalled;
//   bool? lockScreenSet;
//   bool? fpEnrolled;
//   int? numCameras;
//   bool? cameraActive;
//   String? activeCameraId;
//   double? deviceTemperature;
//   double? batteryTemperature;
//   double? batteryVoltage;
//   String? batteryHealth;
//   int? batteryLevel;
//   String? batteryStatus;
//   int? lastChargerPluggedTime;
//   int? lastLocationUpdateTime;
//   double? currentLatitude;
//   double? currentLongitude;
//   String? gpsEnabledType;
//   bool? gpsEnabled;
//   bool? btEnabled;
//   List<dynamic>? btPairedDevices;
//   bool? wifiEnabled;
//   String? wifiSsid;
//   String? wifiMacAddr;
//   bool? hdmiActive;
//   int? internalStorageUsed;
//   int? internalStorageFree;
//   bool? sdCardInserted;
//   int? sdCardSize;
//   int? sdCardUsed;
//   int? currentSystemTime;
//   int? deviceRingerMode;
//   int? screenOrientationMode;
//   String? currentLocale;
//   int? deviceId;
//   int? pedometer;
//   int? sleepTime;
//   String? ipAddress;
//   int? appMemoryUsed;
//   int? appMemoryAvailable;
//   int? subscriptionExpiryDate;
//   int? lastSubscriptionExpiredDate;
//   int? rxBytes;
//   int? txBytes;
//   int? rxBytesMobile;
//   int? txBytesMobile;
//   int? totalUsedBytes;
//   int? percentInternalStorageUsed;
//   bool? powerSaveMode;
//   bool? deviceIdleMode;
//   bool? lowPowerStandbyEnabled;
//   List<AppUsageDatum>? appUsageData;
//   int? deviceDataUsage;
//   int? deviceWiFiUsage;
//   String? currentTimeZone;
//   bool? runningOnEmulator;
//
//   RealTimeStats({
//     this.rtLastUpdatedTime,
//     this.isOnline,
//     this.lastUpdatedTime,
//     this.brightnessLevel,
//     this.cpuUtilization,
//     this.memoryUsed,
//     this.powerOnTime,
//     this.screenOnTime,
//     this.hasMultiUser,
//     this.selEnforced,
//     this.deviceRooted,
//     this.gsfInstalled,
//     this.lockScreenSet,
//     this.fpEnrolled,
//     this.numCameras,
//     this.cameraActive,
//     this.activeCameraId,
//     this.deviceTemperature,
//     this.batteryTemperature,
//     this.batteryVoltage,
//     this.batteryHealth,
//     this.batteryLevel,
//     this.batteryStatus,
//     this.lastChargerPluggedTime,
//     this.lastLocationUpdateTime,
//     this.currentLatitude,
//     this.currentLongitude,
//     this.gpsEnabledType,
//     this.gpsEnabled,
//     this.btEnabled,
//     this.btPairedDevices,
//     this.wifiEnabled,
//     this.wifiSsid,
//     this.wifiMacAddr,
//     this.hdmiActive,
//     this.internalStorageUsed,
//     this.internalStorageFree,
//     this.sdCardInserted,
//     this.sdCardSize,
//     this.sdCardUsed,
//     this.currentSystemTime,
//     this.deviceRingerMode,
//     this.screenOrientationMode,
//     this.currentLocale,
//     this.deviceId,
//     this.pedometer,
//     this.sleepTime,
//     this.ipAddress,
//     this.appMemoryUsed,
//     this.appMemoryAvailable,
//     this.subscriptionExpiryDate,
//     this.lastSubscriptionExpiredDate,
//     this.rxBytes,
//     this.txBytes,
//     this.rxBytesMobile,
//     this.txBytesMobile,
//     this.totalUsedBytes,
//     this.percentInternalStorageUsed,
//     this.powerSaveMode,
//     this.deviceIdleMode,
//     this.lowPowerStandbyEnabled,
//     this.appUsageData,
//     this.deviceDataUsage,
//     this.deviceWiFiUsage,
//     this.currentTimeZone,
//     this.runningOnEmulator,
//   });
//
//   RealTimeStats copyWith({
//     int? rtLastUpdatedTime,
//     int? isOnline,
//     int? lastUpdatedTime,
//     int? brightnessLevel,
//     int? cpuUtilization,
//     int? memoryUsed,
//     int? powerOnTime,
//     int? screenOnTime,
//     int? hasMultiUser,
//     bool? selEnforced,
//     bool? deviceRooted,
//     bool? gsfInstalled,
//     bool? lockScreenSet,
//     bool? fpEnrolled,
//     int? numCameras,
//     bool? cameraActive,
//     String? activeCameraId,
//     double? deviceTemperature,
//     double? batteryTemperature,
//     double? batteryVoltage,
//     String? batteryHealth,
//     int? batteryLevel,
//     String? batteryStatus,
//     int? lastChargerPluggedTime,
//     int? lastLocationUpdateTime,
//     double? currentLatitude,
//     double? currentLongitude,
//     String? gpsEnabledType,
//     bool? gpsEnabled,
//     bool? btEnabled,
//     List<dynamic>? btPairedDevices,
//     bool? wifiEnabled,
//     String? wifiSsid,
//     String? wifiMacAddr,
//     bool? hdmiActive,
//     int? internalStorageUsed,
//     int? internalStorageFree,
//     bool? sdCardInserted,
//     int? sdCardSize,
//     int? sdCardUsed,
//     int? currentSystemTime,
//     int? deviceRingerMode,
//     int? screenOrientationMode,
//     String? currentLocale,
//     int? deviceId,
//     int? pedometer,
//     int? sleepTime,
//     String? ipAddress,
//     int? appMemoryUsed,
//     int? appMemoryAvailable,
//     int? subscriptionExpiryDate,
//     int? lastSubscriptionExpiredDate,
//     int? rxBytes,
//     int? txBytes,
//     int? rxBytesMobile,
//     int? txBytesMobile,
//     int? totalUsedBytes,
//     int? percentInternalStorageUsed,
//     bool? powerSaveMode,
//     bool? deviceIdleMode,
//     bool? lowPowerStandbyEnabled,
//     List<AppUsageDatum>? appUsageData,
//     int? deviceDataUsage,
//     int? deviceWiFiUsage,
//     String? currentTimeZone,
//     bool? runningOnEmulator,
//   }) =>
//       RealTimeStats(
//         rtLastUpdatedTime: rtLastUpdatedTime ?? this.rtLastUpdatedTime,
//         isOnline: isOnline ?? this.isOnline,
//         lastUpdatedTime: lastUpdatedTime ?? this.lastUpdatedTime,
//         brightnessLevel: brightnessLevel ?? this.brightnessLevel,
//         cpuUtilization: cpuUtilization ?? this.cpuUtilization,
//         memoryUsed: memoryUsed ?? this.memoryUsed,
//         powerOnTime: powerOnTime ?? this.powerOnTime,
//         screenOnTime: screenOnTime ?? this.screenOnTime,
//         hasMultiUser: hasMultiUser ?? this.hasMultiUser,
//         selEnforced: selEnforced ?? this.selEnforced,
//         deviceRooted: deviceRooted ?? this.deviceRooted,
//         gsfInstalled: gsfInstalled ?? this.gsfInstalled,
//         lockScreenSet: lockScreenSet ?? this.lockScreenSet,
//         fpEnrolled: fpEnrolled ?? this.fpEnrolled,
//         numCameras: numCameras ?? this.numCameras,
//         cameraActive: cameraActive ?? this.cameraActive,
//         activeCameraId: activeCameraId ?? this.activeCameraId,
//         deviceTemperature: deviceTemperature ?? this.deviceTemperature,
//         batteryTemperature: batteryTemperature ?? this.batteryTemperature,
//         batteryVoltage: batteryVoltage ?? this.batteryVoltage,
//         batteryHealth: batteryHealth ?? this.batteryHealth,
//         batteryLevel: batteryLevel ?? this.batteryLevel,
//         batteryStatus: batteryStatus ?? this.batteryStatus,
//         lastChargerPluggedTime: lastChargerPluggedTime ?? this.lastChargerPluggedTime,
//         lastLocationUpdateTime: lastLocationUpdateTime ?? this.lastLocationUpdateTime,
//         currentLatitude: currentLatitude ?? this.currentLatitude,
//         currentLongitude: currentLongitude ?? this.currentLongitude,
//         gpsEnabledType: gpsEnabledType ?? this.gpsEnabledType,
//         gpsEnabled: gpsEnabled ?? this.gpsEnabled,
//         btEnabled: btEnabled ?? this.btEnabled,
//         btPairedDevices: btPairedDevices ?? this.btPairedDevices,
//         wifiEnabled: wifiEnabled ?? this.wifiEnabled,
//         wifiSsid: wifiSsid ?? this.wifiSsid,
//         wifiMacAddr: wifiMacAddr ?? this.wifiMacAddr,
//         hdmiActive: hdmiActive ?? this.hdmiActive,
//         internalStorageUsed: internalStorageUsed ?? this.internalStorageUsed,
//         internalStorageFree: internalStorageFree ?? this.internalStorageFree,
//         sdCardInserted: sdCardInserted ?? this.sdCardInserted,
//         sdCardSize: sdCardSize ?? this.sdCardSize,
//         sdCardUsed: sdCardUsed ?? this.sdCardUsed,
//         currentSystemTime: currentSystemTime ?? this.currentSystemTime,
//         deviceRingerMode: deviceRingerMode ?? this.deviceRingerMode,
//         screenOrientationMode: screenOrientationMode ?? this.screenOrientationMode,
//         currentLocale: currentLocale ?? this.currentLocale,
//         deviceId: deviceId ?? this.deviceId,
//         pedometer: pedometer ?? this.pedometer,
//         sleepTime: sleepTime ?? this.sleepTime,
//         ipAddress: ipAddress ?? this.ipAddress,
//         appMemoryUsed: appMemoryUsed ?? this.appMemoryUsed,
//         appMemoryAvailable: appMemoryAvailable ?? this.appMemoryAvailable,
//         subscriptionExpiryDate: subscriptionExpiryDate ?? this.subscriptionExpiryDate,
//         lastSubscriptionExpiredDate: lastSubscriptionExpiredDate ?? this.lastSubscriptionExpiredDate,
//         rxBytes: rxBytes ?? this.rxBytes,
//         txBytes: txBytes ?? this.txBytes,
//         rxBytesMobile: rxBytesMobile ?? this.rxBytesMobile,
//         txBytesMobile: txBytesMobile ?? this.txBytesMobile,
//         totalUsedBytes: totalUsedBytes ?? this.totalUsedBytes,
//         percentInternalStorageUsed: percentInternalStorageUsed ?? this.percentInternalStorageUsed,
//         powerSaveMode: powerSaveMode ?? this.powerSaveMode,
//         deviceIdleMode: deviceIdleMode ?? this.deviceIdleMode,
//         lowPowerStandbyEnabled: lowPowerStandbyEnabled ?? this.lowPowerStandbyEnabled,
//         appUsageData: appUsageData ?? this.appUsageData,
//         deviceDataUsage: deviceDataUsage ?? this.deviceDataUsage,
//         deviceWiFiUsage: deviceWiFiUsage ?? this.deviceWiFiUsage,
//         currentTimeZone: currentTimeZone ?? this.currentTimeZone,
//         runningOnEmulator: runningOnEmulator ?? this.runningOnEmulator,
//       );
//
//   factory RealTimeStats.fromJson(Map<String, dynamic> json) => RealTimeStats(
//     rtLastUpdatedTime: json["rtLastUpdatedTime"],
//     isOnline: json["isOnline"],
//     lastUpdatedTime: json["lastUpdatedTime"],
//     brightnessLevel: json["brightnessLevel"],
//     cpuUtilization: json["cpuUtilization"],
//     memoryUsed: json["memoryUsed"],
//     powerOnTime: json["powerOnTime"],
//     screenOnTime: json["screenOnTime"],
//     hasMultiUser: json["hasMultiUser"],
//     selEnforced: json["selEnforced"],
//     deviceRooted: json["deviceRooted"],
//     gsfInstalled: json["gsfInstalled"],
//     lockScreenSet: json["lockScreenSet"],
//     fpEnrolled: json["fpEnrolled"],
//     numCameras: json["numCameras"],
//     cameraActive: json["cameraActive"],
//     activeCameraId: json["activeCameraId"],
//     deviceTemperature: json["deviceTemperature"]?.toDouble(),
//     batteryTemperature: json["batteryTemperature"]?.toDouble(),
//     batteryVoltage: json["batteryVoltage"]?.toDouble(),
//     batteryHealth: json["batteryHealth"],
//     batteryLevel: json["batteryLevel"],
//     batteryStatus: json["batteryStatus"],
//     lastChargerPluggedTime: json["lastChargerPluggedTime"],
//     lastLocationUpdateTime: json["lastLocationUpdateTime"],
//     currentLatitude: json["currentLatitude"]?.toDouble(),
//     currentLongitude: json["currentLongitude"]?.toDouble(),
//     gpsEnabledType: json["gpsEnabledType"],
//     gpsEnabled: json["gpsEnabled"],
//     btEnabled: json["btEnabled"],
//     btPairedDevices: json["btPairedDevices"] == null ? [] : List<dynamic>.from(json["btPairedDevices"]!.map((x) => x)),
//     wifiEnabled: json["wifiEnabled"],
//     wifiSsid: json["wifiSSID"],
//     wifiMacAddr: json["wifiMacAddr"],
//     hdmiActive: json["hdmiActive"],
//     internalStorageUsed: json["internalStorageUsed"],
//     internalStorageFree: json["internalStorageFree"],
//     sdCardInserted: json["sdCardInserted"],
//     sdCardSize: json["sdCardSize"],
//     sdCardUsed: json["sdCardUsed"],
//     currentSystemTime: json["currentSystemTime"],
//     deviceRingerMode: json["deviceRingerMode"],
//     screenOrientationMode: json["screenOrientationMode"],
//     currentLocale: json["currentLocale"],
//     deviceId: json["deviceId"],
//     pedometer: json["pedometer"],
//     sleepTime: json["sleepTime"],
//     ipAddress: json["ipAddress"],
//     appMemoryUsed: json["appMemoryUsed"],
//     appMemoryAvailable: json["appMemoryAvailable"],
//     subscriptionExpiryDate: json["subscriptionExpiryDate"],
//     lastSubscriptionExpiredDate: json["lastSubscriptionExpiredDate"],
//     rxBytes: json["rxBytes"],
//     txBytes: json["txBytes"],
//     rxBytesMobile: json["rxBytesMobile"],
//     txBytesMobile: json["txBytesMobile"],
//     totalUsedBytes: json["totalUsedBytes"],
//     percentInternalStorageUsed: json["percentInternalStorageUsed"],
//     powerSaveMode: json["powerSaveMode"],
//     deviceIdleMode: json["deviceIdleMode"],
//     lowPowerStandbyEnabled: json["lowPowerStandbyEnabled"],
//     appUsageData: json["appUsageData"] == null ? [] : List<AppUsageDatum>.from(json["appUsageData"]!.map((x) => AppUsageDatum.fromJson(x))),
//     deviceDataUsage: json["deviceDataUsage"],
//     deviceWiFiUsage: json["deviceWiFiUsage"],
//     currentTimeZone: json["currentTimeZone"],
//     runningOnEmulator: json["runningOnEmulator"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "rtLastUpdatedTime": rtLastUpdatedTime,
//     "isOnline": isOnline,
//     "lastUpdatedTime": lastUpdatedTime,
//     "brightnessLevel": brightnessLevel,
//     "cpuUtilization": cpuUtilization,
//     "memoryUsed": memoryUsed,
//     "powerOnTime": powerOnTime,
//     "screenOnTime": screenOnTime,
//     "hasMultiUser": hasMultiUser,
//     "selEnforced": selEnforced,
//     "deviceRooted": deviceRooted,
//     "gsfInstalled": gsfInstalled,
//     "lockScreenSet": lockScreenSet,
//     "fpEnrolled": fpEnrolled,
//     "numCameras": numCameras,
//     "cameraActive": cameraActive,
//     "activeCameraId": activeCameraId,
//     "deviceTemperature": deviceTemperature,
//     "batteryTemperature": batteryTemperature,
//     "batteryVoltage": batteryVoltage,
//     "batteryHealth": batteryHealth,
//     "batteryLevel": batteryLevel,
//     "batteryStatus": batteryStatus,
//     "lastChargerPluggedTime": lastChargerPluggedTime,
//     "lastLocationUpdateTime": lastLocationUpdateTime,
//     "currentLatitude": currentLatitude,
//     "currentLongitude": currentLongitude,
//     "gpsEnabledType": gpsEnabledType,
//     "gpsEnabled": gpsEnabled,
//     "btEnabled": btEnabled,
//     "btPairedDevices": btPairedDevices == null ? [] : List<dynamic>.from(btPairedDevices!.map((x) => x)),
//     "wifiEnabled": wifiEnabled,
//     "wifiSSID": wifiSsid,
//     "wifiMacAddr": wifiMacAddr,
//     "hdmiActive": hdmiActive,
//     "internalStorageUsed": internalStorageUsed,
//     "internalStorageFree": internalStorageFree,
//     "sdCardInserted": sdCardInserted,
//     "sdCardSize": sdCardSize,
//     "sdCardUsed": sdCardUsed,
//     "currentSystemTime": currentSystemTime,
//     "deviceRingerMode": deviceRingerMode,
//     "screenOrientationMode": screenOrientationMode,
//     "currentLocale": currentLocale,
//     "deviceId": deviceId,
//     "pedometer": pedometer,
//     "sleepTime": sleepTime,
//     "ipAddress": ipAddress,
//     "appMemoryUsed": appMemoryUsed,
//     "appMemoryAvailable": appMemoryAvailable,
//     "subscriptionExpiryDate": subscriptionExpiryDate,
//     "lastSubscriptionExpiredDate": lastSubscriptionExpiredDate,
//     "rxBytes": rxBytes,
//     "txBytes": txBytes,
//     "rxBytesMobile": rxBytesMobile,
//     "txBytesMobile": txBytesMobile,
//     "totalUsedBytes": totalUsedBytes,
//     "percentInternalStorageUsed": percentInternalStorageUsed,
//     "powerSaveMode": powerSaveMode,
//     "deviceIdleMode": deviceIdleMode,
//     "lowPowerStandbyEnabled": lowPowerStandbyEnabled,
//     "appUsageData": appUsageData == null ? [] : List<dynamic>.from(appUsageData!.map((x) => x.toJson())),
//     "deviceDataUsage": deviceDataUsage,
//     "deviceWiFiUsage": deviceWiFiUsage,
//     "currentTimeZone": currentTimeZone,
//     "runningOnEmulator": runningOnEmulator,
//   };
// }
//
// class AppUsageDatum {
//   String? mPackageName;
//   int? mBgUsageTime;
//   int? mFgUsageTime;
//   int? lastUsedTime;
//   int? wifiUsageBytes;
//   int? dataUsageBytes;
//
//   AppUsageDatum({
//     this.mPackageName,
//     this.mBgUsageTime,
//     this.mFgUsageTime,
//     this.lastUsedTime,
//     this.wifiUsageBytes,
//     this.dataUsageBytes,
//   });
//
//   AppUsageDatum copyWith({
//     String? mPackageName,
//     int? mBgUsageTime,
//     int? mFgUsageTime,
//     int? lastUsedTime,
//     int? wifiUsageBytes,
//     int? dataUsageBytes,
//   }) =>
//       AppUsageDatum(
//         mPackageName: mPackageName ?? this.mPackageName,
//         mBgUsageTime: mBgUsageTime ?? this.mBgUsageTime,
//         mFgUsageTime: mFgUsageTime ?? this.mFgUsageTime,
//         lastUsedTime: lastUsedTime ?? this.lastUsedTime,
//         wifiUsageBytes: wifiUsageBytes ?? this.wifiUsageBytes,
//         dataUsageBytes: dataUsageBytes ?? this.dataUsageBytes,
//       );
//
//   factory AppUsageDatum.fromJson(Map<String, dynamic> json) => AppUsageDatum(
//     mPackageName: json["mPackageName"],
//     mBgUsageTime: json["mBgUsageTime"],
//     mFgUsageTime: json["mFgUsageTime"],
//     lastUsedTime: json["lastUsedTime"],
//     wifiUsageBytes: json["wifiUsageBytes"],
//     dataUsageBytes: json["dataUsageBytes"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "mPackageName": mPackageName,
//     "mBgUsageTime": mBgUsageTime,
//     "mFgUsageTime": mFgUsageTime,
//     "lastUsedTime": lastUsedTime,
//     "wifiUsageBytes": wifiUsageBytes,
//     "dataUsageBytes": dataUsageBytes,
//   };
// }
