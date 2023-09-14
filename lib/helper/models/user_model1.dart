// To parse this JSON data, do
//
//     final userModel1 = userModel1FromJson(jsonString);

import 'dart:convert';

UserModel1 userModel1FromJson(String str) => UserModel1.fromJson(json.decode(str));

String userModel1ToJson(UserModel1 data) => json.encode(data.toJson());

class UserModel1 {
  int? loginAlert;
  String? loginAlertMsg;
  bool? status;
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  int? inviteContactsSent;
  String? email;
  dynamic photo;
  dynamic notifications;
  String? gender;
  String? carrier;
  String? referrerId;
  int? userRole;
  String? dob;
  dynamic passwordOtp;
  int? mulaahScore;
  int? lifetimeMulaah;
  int? monthlyMulaah;
  int? availableMulaah;
  String? referrerUsername;
  String? shareSent;
  int? adLevel;
  int? wifi;
  int? mobileServiceProvider;
  String? phone;
  int? autopayEnrolled;
  String? autopayStatus;
  dynamic autopayStart;
  dynamic autopayEnd;
  String? errorMsg;
  String? moolahWirelessStatus;
  String? minimumUpdateVersion;
  int? activeTheme;
  dynamic organizationId;
  bool? verifiedEmail;
  List<String>? moolahApps;

  UserModel1({
    this.loginAlert,
    this.loginAlertMsg,
    this.status,
    this.userId,
    this.firstName,
    this.lastName,
    this.username,
    this.inviteContactsSent,
    this.email,
    this.photo,
    this.notifications,
    this.gender,
    this.carrier,
    this.referrerId,
    this.userRole,
    this.dob,
    this.passwordOtp,
    this.mulaahScore,
    this.lifetimeMulaah,
    this.monthlyMulaah,
    this.availableMulaah,
    this.referrerUsername,
    this.shareSent,
    this.adLevel,
    this.wifi,
    this.mobileServiceProvider,
    this.phone,
    this.autopayEnrolled,
    this.autopayStatus,
    this.autopayStart,
    this.autopayEnd,
    this.errorMsg,
    this.moolahWirelessStatus,
    this.minimumUpdateVersion,
    this.activeTheme,
    this.organizationId,
    this.verifiedEmail,
    this.moolahApps,
  });

  factory UserModel1.fromJson(Map<String, dynamic> json) => UserModel1(
    loginAlert: json["loginAlert"],
    loginAlertMsg: json["loginAlertMsg"],
    status: json["status"],
    userId: json["user_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    username: json["username"],
    inviteContactsSent: json["invite_contacts_sent"],
    email: json["email"],
    photo: json["photo"],
    notifications: json["notifications"],
    gender: json["gender"],
    carrier: json["carrier"],
    referrerId: json["referrer_id"],
    userRole: json["user_role"],
    dob: json["dob"],
    passwordOtp: json["password_otp"],
    mulaahScore: json["mulaah_score"],
    lifetimeMulaah: json["lifetime_mulaah"],
    monthlyMulaah: json["monthly_mulaah"],
    availableMulaah: json["available_mulaah"],
    referrerUsername: json["referrer_username"],
    shareSent: json["shareSent"],
    adLevel: json["adLevel"],
    wifi: json["wifi"],
    mobileServiceProvider: json["mobileServiceProvider"],
    phone: json["phone"],
    autopayEnrolled: json["autopayEnrolled"],
    autopayStatus: json["autopayStatus"],
    autopayStart: json["autopayStart"],
    autopayEnd: json["autopayEnd"],
    errorMsg: json["errorMsg"],
    moolahWirelessStatus: json["moolah_wireless_status"],
    minimumUpdateVersion: json["minimum_update_version"],
    activeTheme: json["active_theme"],
    organizationId: json["organizationID"],
    verifiedEmail: json["verifiedEmail"],
    moolahApps: json["moolahApps"] == null ? [] : List<String>.from(json["moolahApps"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "loginAlert": loginAlert,
    "loginAlertMsg": loginAlertMsg,
    "status": status,
    "user_id": userId,
    "firstName": firstName,
    "lastName": lastName,
    "username": username,
    "invite_contacts_sent": inviteContactsSent,
    "email": email,
    "photo": photo,
    "notifications": notifications,
    "gender": gender,
    "carrier": carrier,
    "referrer_id": referrerId,
    "user_role": userRole,
    "dob": dob,
    "password_otp": passwordOtp,
    "mulaah_score": mulaahScore,
    "lifetime_mulaah": lifetimeMulaah,
    "monthly_mulaah": monthlyMulaah,
    "available_mulaah": availableMulaah,
    "referrer_username": referrerUsername,
    "shareSent": shareSent,
    "adLevel": adLevel,
    "wifi": wifi,
    "mobileServiceProvider": mobileServiceProvider,
    "phone": phone,
    "autopayEnrolled": autopayEnrolled,
    "autopayStatus": autopayStatus,
    "autopayStart": autopayStart,
    "autopayEnd": autopayEnd,
    "errorMsg": errorMsg,
    "moolah_wireless_status": moolahWirelessStatus,
    "minimum_update_version": minimumUpdateVersion,
    "active_theme": activeTheme,
    "organizationID": organizationId,
    "verifiedEmail": verifiedEmail,
    "moolahApps": moolahApps == null ? [] : List<dynamic>.from(moolahApps!.map((x) => x)),
  };
}
