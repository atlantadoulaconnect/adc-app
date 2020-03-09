// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicationState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationState _$ApplicationStateFromJson(Map<String, dynamic> json) {
  return ApplicationState(
    status: json['status'] as String,
    pages: (json['pages'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as bool),
    ),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$ApplicationStateToJson(ApplicationState instance) =>
    <String, dynamic>{
      'status': instance.status,
      'pages': instance.pages,
      'type': instance.type,
    };
