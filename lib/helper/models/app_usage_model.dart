// To parse this JSON data, do
//
//     final appUsage = appUsageFromJson(jsonString);

import 'dart:convert';

AppUsage appUsageFromJson(String str) => AppUsage.fromJson(json.decode(str));

String appUsageToJson(AppUsage data) => json.encode(data.toJson());

class AppUsage {
  int? installedAppsCount;
  String? deviceDailyAvgUsage;
  String? deviceDailyAvgUsageChange;
  List<ListOfInstalledApp>? listOfInstalledApps;
  String? msg;
  bool? success;

  AppUsage({
    this.installedAppsCount,
    this.deviceDailyAvgUsage,
    this.deviceDailyAvgUsageChange,
    this.listOfInstalledApps,
    this.msg,
    this.success,
  });

  AppUsage copyWith({
    int? installedAppsCount,
    String? deviceDailyAvgUsage,
    String? deviceDailyAvgUsageChange,
    List<ListOfInstalledApp>? listOfInstalledApps,
    String? msg,
    bool? success,
  }) =>
      AppUsage(
        installedAppsCount: installedAppsCount ?? this.installedAppsCount,
        deviceDailyAvgUsage: deviceDailyAvgUsage ?? this.deviceDailyAvgUsage,
        deviceDailyAvgUsageChange: deviceDailyAvgUsageChange ?? this.deviceDailyAvgUsageChange,
        listOfInstalledApps: listOfInstalledApps ?? this.listOfInstalledApps,
        msg: msg ?? this.msg,
        success: success ?? this.success,
      );

  factory AppUsage.fromJson(Map<String, dynamic> json) => AppUsage(
    installedAppsCount: json["installedAppsCount"],
    deviceDailyAvgUsage: json["deviceDailyAvgUsage"],
    deviceDailyAvgUsageChange: json["deviceDailyAvgUsageChange"],
    listOfInstalledApps: json["listOfInstalledApps"] == null ? [] : List<ListOfInstalledApp>.from(json["listOfInstalledApps"]!.map((x) => ListOfInstalledApp.fromJson(x))),
    msg: json["msg"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "installedAppsCount": installedAppsCount,
    "deviceDailyAvgUsage": deviceDailyAvgUsage,
    "deviceDailyAvgUsageChange": deviceDailyAvgUsageChange,
    "listOfInstalledApps": listOfInstalledApps == null ? [] : List<dynamic>.from(listOfInstalledApps!.map((x) => x.toJson())),
    "msg": msg,
    "success": success,
  };
}

class ListOfInstalledApp {
  int? appId;
  String? appName;
  String? appIcon;
  int? percentUsage;
  String? durationOfUsage;

  ListOfInstalledApp({
    this.appId,
    this.appName,
    this.appIcon,
    this.percentUsage,
    this.durationOfUsage,
  });

  ListOfInstalledApp copyWith({
    int? appId,
    String? appName,
    String? appIcon,
    int? percentUsage,
    String? durationOfUsage,
  }) =>
      ListOfInstalledApp(
        appId: appId ?? this.appId,
        appName: appName ?? this.appName,
        appIcon: appIcon ?? this.appIcon,
        percentUsage: percentUsage ?? this.percentUsage,
        durationOfUsage: durationOfUsage ?? this.durationOfUsage,
      );

  factory ListOfInstalledApp.fromJson(Map<String, dynamic> json) => ListOfInstalledApp(
    appId: json["appId"],
    appName: json["app_name"],
    appIcon: json["app_icon"],
    percentUsage: json["percent_usage"],
    durationOfUsage: json["duration_of_usage"],
  );

  Map<String, dynamic> toJson() => {
    "appId": appId,
    "app_name": appName,
    "app_icon": appIcon,
    "percent_usage": percentUsage,
    "duration_of_usage": durationOfUsage,
  };
}
