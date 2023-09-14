// To parse this JSON data, do
//
//     final kid = kidFromJson(jsonString);

import 'dart:convert';

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
  });

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
