// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['userid']);
  return Client(
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
    status: json['status'] as String,
    bday: json['bday'] as String,
    primaryDoula: json['primaryDoula'] == null
        ? null
        : Doula.fromJson(json['primaryDoula'] as Map<String, dynamic>),
    backupDoula: json['backupDoula'] == null
        ? null
        : Doula.fromJson(json['backupDoula'] as Map<String, dynamic>),
    dueDate: json['dueDate'] as String,
    birthLocation: json['birthLocation'] as String,
    birthType: json['birthType'] as String,
    epidural: json['epidural'] as bool,
    cesarean: json['cesarean'] as bool,
    emergencyContacts: (json['emergencyContacts'] as List)
        ?.map((e) => e == null
            ? null
            : EmergencyContact.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    liveBirths: json['liveBirths'] as int,
    preterm: json['preterm'] as bool,
    lowWeight: json['lowWeight'] as bool,
    deliveryTypes:
        (json['deliveryTypes'] as List)?.map((e) => e as String)?.toList(),
    multiples: json['multiples'] as bool,
    meetBefore: json['meetBefore'] as bool,
    homeVisit: json['homeVisit'] as bool,
    photoRelease: json['photoRelease'] as bool,
  );
}

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'userid': instance.userid,
      'status': instance.status,
      'userType': instance.userType,
      'name': instance.name,
      'email': instance.email,
      'phones': instance.phones?.map((e) => e?.toJson())?.toList(),
      'chats': instance.chats?.toList(),
      'phoneVerified': instance.phoneVerified,
      'bday': instance.bday,
      'birthLocation': instance.birthLocation,
      'birthType': instance.birthType,
      'cesarean': instance.cesarean,
      'deliveryTypes': instance.deliveryTypes,
      'dueDate': instance.dueDate,
      'epidural': instance.epidural,
      'homeVisit': instance.homeVisit,
      'liveBirths': instance.liveBirths,
      'lowWeight': instance.lowWeight,
      'meetBefore': instance.meetBefore,
      'multiples': instance.multiples,
      'photoRelease': instance.photoRelease,
      'preterm': instance.preterm,
      'emergencyContacts':
          instance.emergencyContacts?.map((e) => e?.toJson())?.toList(),
      'primaryDoula': instance.primaryDoula?.toJson(),
      'backupDoula': instance.backupDoula?.toJson(),
    };
