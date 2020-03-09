// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['userId']);
  return Contact(
    json['name'] as String,
    json['userId'] as String,
    json['title'] as String,
    json['threadId'] as String,
  )..photoURL = json['photoURL'] as String;
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'name': instance.name,
      'userId': instance.userId,
      'title': instance.title,
      'threadId': instance.threadId,
      'photoURL': instance.photoURL,
    };
