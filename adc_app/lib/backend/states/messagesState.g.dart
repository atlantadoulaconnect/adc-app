// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messagesState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesState _$MessagesStateFromJson(Map<String, dynamic> json) {
  return MessagesState(
    chats: (json['chats'] as List)?.map((e) => e as String)?.toSet(),
    appContacts:
        (json['appContacts'] as List)?.map((e) => e as String)?.toSet(),
  );
}

Map<String, dynamic> _$MessagesStateToJson(MessagesState instance) =>
    <String, dynamic>{
      'chats': instance.chats?.toList(),
      'appContacts': instance.appContacts?.toList(),
    };
