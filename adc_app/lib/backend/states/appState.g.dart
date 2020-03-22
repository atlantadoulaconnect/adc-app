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
    waiting: json['waiting'] as bool,
    formState: json['formState'] == null
        ? null
        : ApplicationState.fromJson(json['formState'] as Map<String, dynamic>),
    messagesState: json['messagesState'] == null
        ? null
        : MessagesState.fromJson(json['messagesState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'currentUser': instance.currentUser?.toJson(),
      'waiting': instance.waiting,
      'messagesState': instance.messagesState?.toJson(),
      'formState': instance.formState?.toJson(),
    };
