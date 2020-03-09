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
    peer: json['peer'] == null
        ? null
        : Contact.fromJson(json['peer'] as Map<String, dynamic>),
    formState: json['formState'] == null
        ? null
        : ApplicationState.fromJson(json['formState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'currentUser': instance.currentUser?.toJson(),
      'waiting': instance.waiting,
      'peer': instance.peer?.toJson(),
      'formState': instance.formState?.toJson(),
    };
