// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['userid']);
  return Admin(
    userid: json['userid'] as String,
    userType: json['userType'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    phoneVerified: json['phoneVerified'] as bool,
    phones: (json['phones'] as List)
        ?.map(
            (e) => e == null ? null : Phone.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    chats: (json['chats'] as List)?.map((e) => e as String)?.toSet(),
  );
}

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'userid': instance.userid,
      'userType': instance.userType,
      'name': instance.name,
      'email': instance.email,
      'phones': instance.phones?.map((e) => e?.toJson())?.toList(),
      'chats': instance.chats?.toList(),
      'phoneVerified': instance.phoneVerified,
    };
