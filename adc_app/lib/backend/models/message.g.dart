// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['content'] as String,
    json['senderId'] as String,
    json['timeSent'] as int,
    json['type'] as String,
    json['threadId'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'senderId': instance.senderId,
      'type': instance.type,
      'content': instance.content,
      'threadId': instance.threadId,
      'timeSent': instance.timeSent,
    };
