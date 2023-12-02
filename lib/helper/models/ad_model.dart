// To parse this JSON data, do
//
//     final adModel = adModelFromJson(jsonString);

import 'dart:convert';

AdModel adModelFromJson(String str) => AdModel.fromJson(json.decode(str));

String adModelToJson(AdModel data) => json.encode(data.toJson());

class AdModel {
  int? campaignId;
  String? advertiserId;
  String? email;
  double? bid;
  String? status;
  String? type;
  String? offerName;
  String? appName;
  String? link;
  DateTime? expiration;
  int? mulaah;
  String? description;
  String? icon;
  String? instructions;
  String? city;
  String? state;
  String? bannerImg;
  String? interstitialImg;
  int? installs;
  int? dailyLimit;
  int? totalBudget;
  int? bannerViews;
  int? interstitialViews;
  int? bannerClicks;
  int? interstitialClicks;
  dynamic question1;
  dynamic question2;
  dynamic question3;
  dynamic question4;
  dynamic question5;
  dynamic question6;
  dynamic question7;
  dynamic question8;
  dynamic question9;
  dynamic question10;

  AdModel({
    this.campaignId,
    this.advertiserId,
    this.email,
    this.bid,
    this.status,
    this.type,
    this.offerName,
    this.appName,
    this.link,
    this.expiration,
    this.mulaah,
    this.description,
    this.icon,
    this.instructions,
    this.city,
    this.state,
    this.bannerImg,
    this.interstitialImg,
    this.installs,
    this.dailyLimit,
    this.totalBudget,
    this.bannerViews,
    this.interstitialViews,
    this.bannerClicks,
    this.interstitialClicks,
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
    this.question6,
    this.question7,
    this.question8,
    this.question9,
    this.question10,
  });

  AdModel copyWith({
    int? campaignId,
    String? advertiserId,
    String? email,
    double? bid,
    String? status,
    String? type,
    String? offerName,
    String? appName,
    String? link,
    DateTime? expiration,
    int? mulaah,
    String? description,
    String? icon,
    String? instructions,
    String? city,
    String? state,
    String? bannerImg,
    String? interstitialImg,
    int? installs,
    int? dailyLimit,
    int? totalBudget,
    int? bannerViews,
    int? interstitialViews,
    int? bannerClicks,
    int? interstitialClicks,
    dynamic question1,
    dynamic question2,
    dynamic question3,
    dynamic question4,
    dynamic question5,
    dynamic question6,
    dynamic question7,
    dynamic question8,
    dynamic question9,
    dynamic question10,
  }) =>
      AdModel(
        campaignId: campaignId ?? this.campaignId,
        advertiserId: advertiserId ?? this.advertiserId,
        email: email ?? this.email,
        bid: bid ?? this.bid,
        status: status ?? this.status,
        type: type ?? this.type,
        offerName: offerName ?? this.offerName,
        appName: appName ?? this.appName,
        link: link ?? this.link,
        expiration: expiration ?? this.expiration,
        mulaah: mulaah ?? this.mulaah,
        description: description ?? this.description,
        icon: icon ?? this.icon,
        instructions: instructions ?? this.instructions,
        city: city ?? this.city,
        state: state ?? this.state,
        bannerImg: bannerImg ?? this.bannerImg,
        interstitialImg: interstitialImg ?? this.interstitialImg,
        installs: installs ?? this.installs,
        dailyLimit: dailyLimit ?? this.dailyLimit,
        totalBudget: totalBudget ?? this.totalBudget,
        bannerViews: bannerViews ?? this.bannerViews,
        interstitialViews: interstitialViews ?? this.interstitialViews,
        bannerClicks: bannerClicks ?? this.bannerClicks,
        interstitialClicks: interstitialClicks ?? this.interstitialClicks,
        question1: question1 ?? this.question1,
        question2: question2 ?? this.question2,
        question3: question3 ?? this.question3,
        question4: question4 ?? this.question4,
        question5: question5 ?? this.question5,
        question6: question6 ?? this.question6,
        question7: question7 ?? this.question7,
        question8: question8 ?? this.question8,
        question9: question9 ?? this.question9,
        question10: question10 ?? this.question10,
      );

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
    campaignId: json["campaign_id"],
    advertiserId: json["advertiser_id"],
    email: json["email"],
    bid: json["bid"]?.toDouble(),
    status: json["status"],
    type: json["type"],
    offerName: json["offer_name"],
    appName: json["app_name"],
    link: json["link"],
    expiration: json["expiration"] == null ? null : DateTime.parse(json["expiration"]),
    mulaah: json["mulaah"],
    description: json["description"],
    icon: json["icon"],
    instructions: json["instructions"],
    city: json["city"],
    state: json["state"],
    bannerImg: json["banner_img"],
    interstitialImg: json["interstitial_img"],
    installs: json["installs"],
    dailyLimit: json["daily_limit"],
    totalBudget: json["total_budget"],
    bannerViews: json["banner_views"],
    interstitialViews: json["interstitial_views"],
    bannerClicks: json["banner_clicks"],
    interstitialClicks: json["interstitial_clicks"],
    question1: json["question_1"],
    question2: json["question_2"],
    question3: json["question_3"],
    question4: json["question_4"],
    question5: json["question_5"],
    question6: json["question_6"],
    question7: json["question_7"],
    question8: json["question_8"],
    question9: json["question_9"],
    question10: json["question_10"],
  );

  Map<String, dynamic> toJson() => {
    "campaign_id": campaignId,
    "advertiser_id": advertiserId,
    "email": email,
    "bid": bid,
    "status": status,
    "type": type,
    "offer_name": offerName,
    "app_name": appName,
    "link": link,
    "expiration": expiration?.toIso8601String(),
    "mulaah": mulaah,
    "description": description,
    "icon": icon,
    "instructions": instructions,
    "city": city,
    "state": state,
    "banner_img": bannerImg,
    "interstitial_img": interstitialImg,
    "installs": installs,
    "daily_limit": dailyLimit,
    "total_budget": totalBudget,
    "banner_views": bannerViews,
    "interstitial_views": interstitialViews,
    "banner_clicks": bannerClicks,
    "interstitial_clicks": interstitialClicks,
    "question_1": question1,
    "question_2": question2,
    "question_3": question3,
    "question_4": question4,
    "question_5": question5,
    "question_6": question6,
    "question_7": question7,
    "question_8": question8,
    "question_9": question9,
    "question_10": question10,
  };
}
