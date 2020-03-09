// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doula.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doula _$DoulaFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['userid']);
  return Doula(
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
    bday: json['bday'] as String,
    emailVerified: json['emailVerified'] as bool,
    bio: json['bio'] as String,
    certified: json['certified'] as bool,
    certInProgress: json['certInProgress'] as bool,
    certProgram: json['certProgram'] as String,
    birthsNeeded: json['birthsNeeded'] as int,
    availableDates:
        (json['availableDates'] as List)?.map((e) => e as String)?.toList(),
    photoRelease: json['photoRelease'] as bool,
    currentClients: (json['currentClients'] as List)
        ?.map((e) =>
            e == null ? null : Client.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DoulaToJson(Doula instance) => <String, dynamic>{
      'userid': instance.userid,
      'userType': instance.userType,
      'name': instance.name,
      'email': instance.email,
      'phones': instance.phones?.map((e) => e?.toJson())?.toList(),
      'chats': instance.chats?.toList(),
      'phoneVerified': instance.phoneVerified,
      'bday': instance.bday,
      'emailVerified': instance.emailVerified,
      'bio': instance.bio,
      'certified': instance.certified,
      'certInProgress': instance.certInProgress,
      'certProgram': instance.certProgram,
      'birthsNeeded': instance.birthsNeeded,
      'availableDates': instance.availableDates,
      'photoRelease': instance.photoRelease,
      'currentClients':
          instance.currentClients?.map((e) => e?.toJson())?.toList(),
    };
