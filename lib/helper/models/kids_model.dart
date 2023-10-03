// To parse this JSON data, do
//
//     final kid = kidFromJson(jsonString);

import 'dart:convert';

import 'app_usage_model.dart';

Kid kidFromJson(String str) => Kid.fromJson(json.decode(str));

String kidToJson(Kid data) => json.encode(data.toJson());

class Kid {
  String? kidId;
  String? name;
  String? deviceType;
  String? batteryStatus;
  String? connectId;
  String? dataUsageStatus;
  String? lastActive;
  String? kidPic;
  bool? walletEnabled;
  AppUsage? appUsage;

  Kid({
    this.kidId,
    this.name,
    this.deviceType,
    this.batteryStatus,
    this.connectId,
    this.dataUsageStatus,
    this.lastActive,
    this.kidPic,
    this.walletEnabled,
    this.appUsage
  });

  Kid copyWith({
    String? kidId,
    String? name,
    String? deviceType,
    String? batteryStatus,
    String? connectId,
    String? dataUsageStatus,
    String? lastActive,
    String? kidPic,
    bool? walletEnabled,
    AppUsage? appUsage
  }) =>
      Kid(
        kidId: kidId ?? this.kidId,
        name: name ?? this.name,
        deviceType: deviceType ?? this.deviceType,
        batteryStatus: batteryStatus ?? this.batteryStatus,
        connectId: connectId ?? this.connectId,
        dataUsageStatus: dataUsageStatus ?? this.dataUsageStatus,
        lastActive: lastActive ?? this.lastActive,
        kidPic: kidPic ?? this.kidPic,
        walletEnabled: walletEnabled ?? this.walletEnabled,
        appUsage: appUsage ?? this.appUsage
      );

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
  };
}
