// To parse this JSON data, do
//
//     final blockedUrlModel = blockedUrlModelFromJson(jsonString);

import 'dart:convert';

BlockedUrlModel blockedUrlModelFromJson(String str) => BlockedUrlModel.fromJson(json.decode(str));

String blockedUrlModelToJson(BlockedUrlModel data) => json.encode(data.toJson());

class BlockedUrlModel {
  BlockedUrlsData? blockedUrlsData;

  BlockedUrlModel({
    this.blockedUrlsData,
  });

  BlockedUrlModel copyWith({
    BlockedUrlsData? blockedUrlsData,
  }) =>
      BlockedUrlModel(
        blockedUrlsData: blockedUrlsData ?? this.blockedUrlsData,
      );

  factory BlockedUrlModel.fromJson(Map<String, dynamic> json) => BlockedUrlModel(
    blockedUrlsData: json["blocked_urls_data"] == null ? null : BlockedUrlsData.fromJson(json["blocked_urls_data"]),
  );

  Map<String, dynamic> toJson() => {
    "blocked_urls_data": blockedUrlsData?.toJson(),
  };
}

class BlockedUrlsData {
  String? kidDeviceUid;
  String? parentDeviceUid;
  List<String>? blockedUrls;

  BlockedUrlsData({
    this.kidDeviceUid,
    this.parentDeviceUid,
    this.blockedUrls,
  });

  BlockedUrlsData copyWith({
    String? kidDeviceUid,
    String? parentDeviceUid,
    List<String>? blockedUrls,
  }) =>
      BlockedUrlsData(
        kidDeviceUid: kidDeviceUid ?? this.kidDeviceUid,
        parentDeviceUid: parentDeviceUid ?? this.parentDeviceUid,
        blockedUrls: blockedUrls ?? this.blockedUrls,
      );

  factory BlockedUrlsData.fromJson(Map<String, dynamic> json) => BlockedUrlsData(
    kidDeviceUid: json["kid_device_uid"],
    parentDeviceUid: json["parent_device_uid"],
    blockedUrls: json["blockedUrls"] == null ? [] : List<String>.from(json["blockedUrls"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "kid_device_uid": kidDeviceUid,
    "parent_device_uid": parentDeviceUid,
    "blocked_urls": blockedUrls == null ? [] : List<dynamic>.from(blockedUrls!.map((x) => x)),
  };
}
