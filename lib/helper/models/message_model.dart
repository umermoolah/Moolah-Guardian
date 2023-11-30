// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageData? messageData;

  MessageModel({
    this.messageData,
  });

  MessageModel copyWith({
    MessageData? messageData,
  }) =>
      MessageModel(
        messageData: messageData ?? this.messageData,
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    messageData: json["message_data"] == null ? null : MessageData.fromJson(json["message_data"]),
  );

  Map<String, dynamic> toJson() => {
    "message_data": messageData?.toJson(),
  };
}

class MessageData {
  String? kidDeviceUid;
  String? senderContact;
  String? senderNumber;
  String? receiverContact;
  String? receiverNumber;
  String? message;
  DateTime? messageTimeStamp;
  dynamic mediaAttachments;

  MessageData({
    this.kidDeviceUid,
    this.senderContact,
    this.senderNumber,
    this.receiverContact,
    this.receiverNumber,
    this.message,
    this.messageTimeStamp,
    this.mediaAttachments,
  });

  MessageData copyWith({
    String? kidDeviceUid,
    String? senderContact,
    String? senderNumber,
    String? receiverContact,
    String? receiverNumber,
    String? message,
    DateTime? messageTimeStamp,
    dynamic mediaAttachments,
  }) =>
      MessageData(
        kidDeviceUid: kidDeviceUid ?? this.kidDeviceUid,
        senderContact: senderContact ?? this.senderContact,
        senderNumber: senderNumber ?? this.senderNumber,
        receiverContact: receiverContact ?? this.receiverContact,
        receiverNumber: receiverNumber ?? this.receiverNumber,
        message: message ?? this.message,
        messageTimeStamp: messageTimeStamp ?? this.messageTimeStamp,
        mediaAttachments: mediaAttachments ?? this.mediaAttachments,
      );

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
    kidDeviceUid: json["kidDeviceUID"],
    senderContact: json["sender_contact"],
    senderNumber: json["sender_number"],
    receiverContact: json["receiver_contact"],
    receiverNumber: json["receiver_number"],
    message: json["message"],
    messageTimeStamp: json["message_time_stamp"] == null ? null : DateTime.parse(json["message_time_stamp"]),
    mediaAttachments: json["media_attachments"],
  );

  Map<String, dynamic> toJson() => {
    "kidDeviceUID": kidDeviceUid,
    "sender_contact": senderContact,
    "sender_number": senderNumber,
    "receiver_contact": receiverContact,
    "receiver_number": receiverNumber,
    "message": message,
    "message_time_stamp": messageTimeStamp?.toIso8601String(),
    "media_attachments": mediaAttachments,
  };
}
