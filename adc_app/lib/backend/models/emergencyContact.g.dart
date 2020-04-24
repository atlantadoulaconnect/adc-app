// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergencyContact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) {
  return EmergencyContact(
    json['name'] as String,
    json['relationship'] as String,
    (json['phones'] as List)
        ?.map(
            (e) => e == null ? null : Phone.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) =>
    <String, dynamic>{
      'name': instance.name,
      'relationship': instance.relationship,
      'phones': instance.phones?.map((e) => e?.toJson())?.toList(),
    };
