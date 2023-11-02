// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  dynamic dobOld;
  String? dob;
  String? username;
  String? deviceId;
  String? sim;
  DateTime? lastLogin;
  String? userId;
  dynamic photo;
  String? gender;
  dynamic latitude;
  dynamic longitude;
  dynamic pushToken;
  String? email;
  String? phone;
  String? smsEnabled;
  dynamic notifications;
  int? approvedVendor;
  dynamic paypalActive;
  dynamic paypalEmail;
  int? activeDailyCount;
  int? mulaahScore;
  int? lifetimeMulaah;
  int? monthlyMulaah;
  int? availableMoolah;
  dynamic boost;
  DateTime? signupDate;
  int? authVerified;
  String? boostExp;
  String? carrier;
  int? mobileServiceProvider;
  int? inviteContactsSent;
  dynamic lastWalletVisit;
  String? referrerUsername;
  String? referrerId;
  int? autopayEnrolled;
  String? autopayStatus;
  dynamic autopayStart;
  dynamic autopayEnd;
  String? imei;
  int? adLevel;
  int? wifi;
  String? shareSent;
  dynamic shares;
  dynamic dataUsed;
  dynamic usageTime;
  dynamic passwordOtp;
  int? userRole;
  String? moolahWirelessStatus;
  String? adNetworks;
  int? activeTheme;
  dynamic organizationId;
  bool? updatedPassword;
  bool? verifiedEmail;
  String? moolahApps;
  bool? walletEnabled;
  int? earnedMoolah;
  String? mixPanelId;
  int? legacyMoolah;
  String? ethnicity;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.dobOld,
    this.dob,
    this.username,
    this.deviceId,
    this.sim,
    this.lastLogin,
    this.userId,
    this.photo,
    this.gender,
    this.latitude,
    this.longitude,
    this.pushToken,
    this.email,
    this.phone,
    this.smsEnabled,
    this.notifications,
    this.approvedVendor,
    this.paypalActive,
    this.paypalEmail,
    this.activeDailyCount,
    this.mulaahScore,
    this.lifetimeMulaah,
    this.monthlyMulaah,
    this.availableMoolah,
    this.boost,
    this.signupDate,
    this.authVerified,
    this.boostExp,
    this.carrier,
    this.mobileServiceProvider,
    this.inviteContactsSent,
    this.lastWalletVisit,
    this.referrerUsername,
    this.referrerId,
    this.autopayEnrolled,
    this.autopayStatus,
    this.autopayStart,
    this.autopayEnd,
    this.imei,
    this.adLevel,
    this.wifi,
    this.shareSent,
    this.shares,
    this.dataUsed,
    this.usageTime,
    this.passwordOtp,
    this.userRole,
    this.moolahWirelessStatus,
    this.adNetworks,
    this.activeTheme,
    this.organizationId,
    this.updatedPassword,
    this.verifiedEmail,
    this.moolahApps,
    this.walletEnabled,
    this.earnedMoolah,
    this.mixPanelId,
    this.legacyMoolah,
    this.ethnicity,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    dynamic dobOld,
    String? dob,
    String? username,
    String? deviceId,
    String? sim,
    DateTime? lastLogin,
    String? userId,
    dynamic photo,
    String? gender,
    dynamic latitude,
    dynamic longitude,
    dynamic pushToken,
    String? email,
    String? phone,
    String? smsEnabled,
    dynamic notifications,
    int? approvedVendor,
    dynamic paypalActive,
    dynamic paypalEmail,
    int? activeDailyCount,
    int? mulaahScore,
    int? lifetimeMulaah,
    int? monthlyMulaah,
    int? availableMoolah,
    dynamic boost,
    DateTime? signupDate,
    int? authVerified,
    String? boostExp,
    String? carrier,
    int? mobileServiceProvider,
    int? inviteContactsSent,
    dynamic lastWalletVisit,
    String? referrerUsername,
    String? referrerId,
    int? autopayEnrolled,
    String? autopayStatus,
    dynamic autopayStart,
    dynamic autopayEnd,
    String? imei,
    int? adLevel,
    int? wifi,
    String? shareSent,
    dynamic shares,
    dynamic dataUsed,
    dynamic usageTime,
    dynamic passwordOtp,
    int? userRole,
    String? moolahWirelessStatus,
    String? adNetworks,
    int? activeTheme,
    dynamic organizationId,
    bool? updatedPassword,
    bool? verifiedEmail,
    String? moolahApps,
    bool? walletEnabled,
    int? earnedMoolah,
    String? mixPanelId,
    int? legacyMoolah,
    String? ethnicity,
  }) =>
      UserModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dobOld: dobOld ?? this.dobOld,
        dob: dob ?? this.dob,
        username: username ?? this.username,
        deviceId: deviceId ?? this.deviceId,
        sim: sim ?? this.sim,
        lastLogin: lastLogin ?? this.lastLogin,
        userId: userId ?? this.userId,
        photo: photo ?? this.photo,
        gender: gender ?? this.gender,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        pushToken: pushToken ?? this.pushToken,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        smsEnabled: smsEnabled ?? this.smsEnabled,
        notifications: notifications ?? this.notifications,
        approvedVendor: approvedVendor ?? this.approvedVendor,
        paypalActive: paypalActive ?? this.paypalActive,
        paypalEmail: paypalEmail ?? this.paypalEmail,
        activeDailyCount: activeDailyCount ?? this.activeDailyCount,
        mulaahScore: mulaahScore ?? this.mulaahScore,
        lifetimeMulaah: lifetimeMulaah ?? this.lifetimeMulaah,
        monthlyMulaah: monthlyMulaah ?? this.monthlyMulaah,
        availableMoolah: availableMoolah ?? this.availableMoolah,
        boost: boost ?? this.boost,
        signupDate: signupDate ?? this.signupDate,
        authVerified: authVerified ?? this.authVerified,
        boostExp: boostExp ?? this.boostExp,
        carrier: carrier ?? this.carrier,
        mobileServiceProvider: mobileServiceProvider ?? this.mobileServiceProvider,
        inviteContactsSent: inviteContactsSent ?? this.inviteContactsSent,
        lastWalletVisit: lastWalletVisit ?? this.lastWalletVisit,
        referrerUsername: referrerUsername ?? this.referrerUsername,
        referrerId: referrerId ?? this.referrerId,
        autopayEnrolled: autopayEnrolled ?? this.autopayEnrolled,
        autopayStatus: autopayStatus ?? this.autopayStatus,
        autopayStart: autopayStart ?? this.autopayStart,
        autopayEnd: autopayEnd ?? this.autopayEnd,
        imei: imei ?? this.imei,
        adLevel: adLevel ?? this.adLevel,
        wifi: wifi ?? this.wifi,
        shareSent: shareSent ?? this.shareSent,
        shares: shares ?? this.shares,
        dataUsed: dataUsed ?? this.dataUsed,
        usageTime: usageTime ?? this.usageTime,
        passwordOtp: passwordOtp ?? this.passwordOtp,
        userRole: userRole ?? this.userRole,
        moolahWirelessStatus: moolahWirelessStatus ?? this.moolahWirelessStatus,
        adNetworks: adNetworks ?? this.adNetworks,
        activeTheme: activeTheme ?? this.activeTheme,
        organizationId: organizationId ?? this.organizationId,
        updatedPassword: updatedPassword ?? this.updatedPassword,
        verifiedEmail: verifiedEmail ?? this.verifiedEmail,
        moolahApps: moolahApps ?? this.moolahApps,
        walletEnabled: walletEnabled ?? this.walletEnabled,
        earnedMoolah: earnedMoolah ?? this.earnedMoolah,
        mixPanelId: mixPanelId ?? this.mixPanelId,
        legacyMoolah: legacyMoolah ?? this.legacyMoolah,
        ethnicity: ethnicity ?? this.ethnicity,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    dobOld: json["dobOld"],
    dob: json["dob"],
    username: json["username"],
    deviceId: json["device_id"],
    sim: json["sim"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    userId: json["user_id"],
    photo: json["photo"],
    gender: json["gender"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    pushToken: json["push_token"],
    email: json["email"],
    phone: json["phone"],
    smsEnabled: json["smsEnabled"],
    notifications: json["notifications"],
    approvedVendor: json["approved_vendor"],
    paypalActive: json["paypal_active"],
    paypalEmail: json["paypal_email"],
    activeDailyCount: json["active_daily_count"],
    mulaahScore: json["mulaah_score"],
    lifetimeMulaah: json["lifetime_mulaah"],
    monthlyMulaah: json["monthly_mulaah"],
    availableMoolah: json["available_moolah"],
    boost: json["boost"],
    signupDate: json["signup_date"] == null ? null : DateTime.parse(json["signup_date"]),
    authVerified: json["authVerified"],
    boostExp: json["boost_exp"],
    carrier: json["carrier"],
    mobileServiceProvider: json["mobileServiceProvider"],
    inviteContactsSent: json["invite_contacts_sent"],
    lastWalletVisit: json["last_wallet_visit"],
    referrerUsername: json["referrer_username"],
    referrerId: json["referrer_id"],
    autopayEnrolled: json["autopayEnrolled"],
    autopayStatus: json["autopayStatus"],
    autopayStart: json["autopayStart"],
    autopayEnd: json["autopayEnd"],
    imei: json["imei"],
    adLevel: json["adLevel"],
    wifi: json["wifi"],
    shareSent: json["shareSent"],
    shares: json["shares"],
    dataUsed: json["data_used"],
    usageTime: json["usage_time"],
    passwordOtp: json["password_otp"],
    userRole: json["user_role"],
    moolahWirelessStatus: json["moolah_wireless_status"],
    adNetworks: json["ad_networks"],
    activeTheme: json["activeTheme"],
    organizationId: json["organizationID"],
    updatedPassword: json["updatedPassword"],
    verifiedEmail: json["verifiedEmail"],
    moolahApps: json["moolahApps"],
    walletEnabled: json["walletEnabled"],
    earnedMoolah: json["earned_moolah"],
    mixPanelId: json["mixPanelId"],
    legacyMoolah: json["legacy_moolah"],
    ethnicity: json["ethnicity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "dobOld": dobOld,
    "dob": dob,
    "username": username,
    "device_id": deviceId,
    "sim": sim,
    "last_login": lastLogin?.toIso8601String(),
    "user_id": userId,
    "photo": photo,
    "gender": gender,
    "latitude": latitude,
    "longitude": longitude,
    "push_token": pushToken,
    "email": email,
    "phone": phone,
    "smsEnabled": smsEnabled,
    "notifications": notifications,
    "approved_vendor": approvedVendor,
    "paypal_active": paypalActive,
    "paypal_email": paypalEmail,
    "active_daily_count": activeDailyCount,
    "mulaah_score": mulaahScore,
    "lifetime_mulaah": lifetimeMulaah,
    "monthly_mulaah": monthlyMulaah,
    "available_moolah": availableMoolah,
    "boost": boost,
    "signup_date": signupDate?.toIso8601String(),
    "authVerified": authVerified,
    "boost_exp": boostExp,
    "carrier": carrier,
    "mobileServiceProvider": mobileServiceProvider,
    "invite_contacts_sent": inviteContactsSent,
    "last_wallet_visit": lastWalletVisit,
    "referrer_username": referrerUsername,
    "referrer_id": referrerId,
    "autopayEnrolled": autopayEnrolled,
    "autopayStatus": autopayStatus,
    "autopayStart": autopayStart,
    "autopayEnd": autopayEnd,
    "imei": imei,
    "adLevel": adLevel,
    "wifi": wifi,
    "shareSent": shareSent,
    "shares": shares,
    "data_used": dataUsed,
    "usage_time": usageTime,
    "password_otp": passwordOtp,
    "user_role": userRole,
    "moolah_wireless_status": moolahWirelessStatus,
    "ad_networks": adNetworks,
    "activeTheme": activeTheme,
    "organizationID": organizationId,
    "updatedPassword": updatedPassword,
    "verifiedEmail": verifiedEmail,
    "moolahApps": moolahApps,
    "walletEnabled": walletEnabled,
    "earned_moolah": earnedMoolah,
    "mixPanelId": mixPanelId,
    "legacy_moolah": legacyMoolah,
    "ethnicity": ethnicity,
  };
}
