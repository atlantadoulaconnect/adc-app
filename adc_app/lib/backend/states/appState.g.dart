// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    currentUser: json['currentUser'] == null
        ? null
        : User.fromJson(json['currentUser'] as Map<String, dynamic>),
    messagesState: json['messagesState'] == null
        ? null
        : MessagesState.fromJson(json['messagesState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'currentUser': instance.currentUser?.toJson(),
      'messagesState': instance.messagesState?.toJson(),
    };
