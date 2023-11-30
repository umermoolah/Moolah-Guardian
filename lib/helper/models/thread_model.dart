// To parse this JSON data, do
//
//     final threadModel = threadModelFromJson(jsonString);

import 'dart:convert';

ThreadModel threadModelFromJson(String str) => ThreadModel.fromJson(json.decode(str));

String threadModelToJson(ThreadModel data) => json.encode(data.toJson());

class ThreadModel {
  String? threadId;
  LastMessage? lastMessage;

  ThreadModel({
    this.threadId,
    this.lastMessage,
  });

  ThreadModel copyWith({
    String? threadId,
    LastMessage? lastMessage,
  }) =>
      ThreadModel(
        threadId: threadId ?? this.threadId,
        lastMessage: lastMessage ?? this.lastMessage,
      );

  factory ThreadModel.fromJson(Map<String, dynamic> json) => ThreadModel(
    threadId: json["thread_id"],
    lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
  );

  Map<String, dynamic> toJson() => {
    "thread_id": threadId,
    "last_message": lastMessage?.toJson(),
  };
}

class LastMessage {
  MessageData? messageData;

  LastMessage({
    this.messageData,
  });

  LastMessage copyWith({
    MessageData? messageData,
  }) =>
      LastMessage(
        messageData: messageData ?? this.messageData,
      );

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    messageData: json["message_data"] == null ? null : MessageData.fromJson(json["message_data"]),
  );

  Map<String, dynamic> toJson() => {
    "message_data": messageData?.toJson(),
  };
}

class MessageData {
  String? kidDeviceUid;
  dynamic senderContact;
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
    dynamic senderContact,
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
