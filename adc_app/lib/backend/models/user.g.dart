// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['userid']);
  return User(
    json['userid'] as String,
    json['email'] as String,
  )
    ..status = json['status'] as String
    ..userType = json['userType'] as String
    ..name = json['name'] as String
    ..phones = (json['phones'] as List)
        ?.map(
            (e) => e == null ? null : Phone.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..phoneVerified = json['phoneVerified'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userid': instance.userid,
      'status': instance.status,
      'userType': instance.userType,
      'name': instance.name,
      'email': instance.email,
      'phones': instance.phones?.map((e) => e?.toJson())?.toList(),
      'phoneVerified': instance.phoneVerified,
    };
