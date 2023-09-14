
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
  String? passwordText;
  dynamic passwordNum;
  String? hash;
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
  dynamic authSentDate;
  dynamic authCode;
  String? signupDate;
  String? moolahRolloverDate;
  int? authVerified;
  String? boostExp;
  dynamic giftCodeId;
  String? carrier;
  int? mobileServiceProvider;
  dynamic peanutLabsId;
  int? inviteContactsSent;
  dynamic lastWalletVisit;
  int? distributorApproved;
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
  dynamic moolah02021;
  dynamic moolah12021;
  dynamic moolah32021;
  dynamic moolah42021;
  dynamic moolah52021;
  dynamic moolah62021;
  dynamic moolah72021;
  dynamic moolah82021;
  dynamic moolah92021;
  dynamic moolah102021;
  dynamic moolah112021;
  dynamic distributorId;
  dynamic distributorUsername;
  dynamic passwordOtp;
  int? userRole;
  String? randKey;
  dynamic userProfileKey;
  String? moolahWirelessStatus;
  String? adNetworks;
  int? activeTheme;
  dynamic organizationId;
  int? updatedPassword;
  bool? verifiedEmail;
  String? moolahApps;

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
    this.passwordText,
    this.passwordNum,
    this.hash,
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
    this.authSentDate,
    this.authCode,
    this.signupDate,
    this.moolahRolloverDate,
    this.authVerified,
    this.boostExp,
    this.giftCodeId,
    this.carrier,
    this.mobileServiceProvider,
    this.peanutLabsId,
    this.inviteContactsSent,
    this.lastWalletVisit,
    this.distributorApproved,
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
    this.moolah02021,
    this.moolah12021,
    this.moolah32021,
    this.moolah42021,
    this.moolah52021,
    this.moolah62021,
    this.moolah72021,
    this.moolah82021,
    this.moolah92021,
    this.moolah102021,
    this.moolah112021,
    this.distributorId,
    this.distributorUsername,
    this.passwordOtp,
    this.userRole,
    this.randKey,
    this.userProfileKey,
    this.moolahWirelessStatus,
    this.adNetworks,
    this.activeTheme,
    this.organizationId,
    this.updatedPassword,
    this.verifiedEmail,
    this.moolahApps,
  });

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
    passwordText: json["password_text"],
    passwordNum: json["password_num"],
    hash: json["hash"],
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
    authSentDate: json["authSentDate"],
    authCode: json["authCode"],
    signupDate: json["signup_date"],
    moolahRolloverDate: json["moolah_rollover_date"],
    authVerified: json["authVerified"],
    boostExp: json["boost_exp"],
    giftCodeId: json["giftCode_id"],
    carrier: json["carrier"],
    mobileServiceProvider: json["mobileServiceProvider"],
    peanutLabsId: json["peanutLabs_id"],
    inviteContactsSent: json["invite_contacts_sent"],
    lastWalletVisit: json["last_wallet_visit"],
    distributorApproved: json["distributor_approved"],
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
    moolah02021: json["Moolah_0_2021"],
    moolah12021: json["Moolah_1_2021"],
    moolah32021: json["Moolah_3_2021"],
    moolah42021: json["Moolah_4_2021"],
    moolah52021: json["Moolah_5_2021"],
    moolah62021: json["Moolah_6_2021"],
    moolah72021: json["Moolah_7_2021"],
    moolah82021: json["Moolah_8_2021"],
    moolah92021: json["Moolah_9_2021"],
    moolah102021: json["Moolah_10_2021"],
    moolah112021: json["Moolah_11_2021"],
    distributorId: json["distributor_id"],
    distributorUsername: json["distributor_username"],
    passwordOtp: json["password_otp"],
    userRole: json["user_role"],
    randKey: json["randKey"],
    userProfileKey: json["userProfileKey"],
    moolahWirelessStatus: json["moolah_wireless_status"],
    adNetworks: json["ad_networks"],
    activeTheme: json["activeTheme"],
    organizationId: json["organizationID"],
    updatedPassword: json["updatedPassword"],
    verifiedEmail: json["verifiedEmail"],
    moolahApps: json["moolahApps"].toString(),
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
    "password_text": passwordText,
    "password_num": passwordNum,
    "hash": hash,
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
    "authSentDate": authSentDate,
    "authCode": authCode,
    "signup_date": signupDate,
    "moolah_rollover_date": moolahRolloverDate,
    "authVerified": authVerified,
    "boost_exp": boostExp,
    "giftCode_id": giftCodeId,
    "carrier": carrier,
    "mobileServiceProvider": mobileServiceProvider,
    "peanutLabs_id": peanutLabsId,
    "invite_contacts_sent": inviteContactsSent,
    "last_wallet_visit": lastWalletVisit,
    "distributor_approved": distributorApproved,
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
    "Moolah_0_2021": moolah02021,
    "Moolah_1_2021": moolah12021,
    "Moolah_3_2021": moolah32021,
    "Moolah_4_2021": moolah42021,
    "Moolah_5_2021": moolah52021,
    "Moolah_6_2021": moolah62021,
    "Moolah_7_2021": moolah72021,
    "Moolah_8_2021": moolah82021,
    "Moolah_9_2021": moolah92021,
    "Moolah_10_2021": moolah102021,
    "Moolah_11_2021": moolah112021,
    "distributor_id": distributorId,
    "distributor_username": distributorUsername,
    "password_otp": passwordOtp,
    "user_role": userRole,
    "randKey": randKey,
    "userProfileKey": userProfileKey,
    "moolah_wireless_status": moolahWirelessStatus,
    "ad_networks": adNetworks,
    "activeTheme": activeTheme,
    "organizationID": organizationId,
    "updatedPassword": updatedPassword,
    "verifiedEmail": verifiedEmail,
    "moolahApps": moolahApps,
  };
}
