import 'package:adc_app/frontend/screens/common.dart';

import './common.dart';

part 'client.g.dart';

@JsonSerializable(explicitToJson: true)
class Client extends User {
  String bday;
  String birthLocation;
  String birthType;
  bool cesarean;
  List<String> deliveryTypes;
  String dueDate;

  String status;

  String primaryDoulaId;
  String primaryDoulaName;
  String backupDoulaId;
  String backupDoulaName;

  bool epidural;
  bool homeVisit;
  int liveBirths;
  bool lowWeight;
  bool meetBefore;
  bool multiples;

  bool photoRelease;
  bool preterm;

  List<EmergencyContact> emergencyContacts;

  Client(
      {String userid,
      String userType,
      String name,
      String email,
      bool phoneVerified,
      List<Phone> phones,
      Set<String> chats,
      Set<String> appContacts,
      String status,
      this.bday,
      this.primaryDoulaId,
      this.primaryDoulaName,
      this.backupDoulaId,
      this.backupDoulaName,
      this.dueDate,
      this.birthLocation,
      this.birthType,
      this.epidural,
      this.cesarean,
      this.emergencyContacts,
      this.liveBirths,
      this.preterm,
      this.lowWeight,
      this.deliveryTypes,
      this.multiples,
      this.meetBefore,
      this.homeVisit,
      this.photoRelease})
      : super.full(
            userid, userType, name, email, phoneVerified, phones, status);

  void addDeliveryType(String deliveryType) {
    this.deliveryTypes.add(deliveryType);
  }

  void removeDeliveryType(String deliveryType) {
    this.deliveryTypes.remove(deliveryType);
  }

  void addContact(EmergencyContact contact) {
    this.emergencyContacts.add(contact);
  }

  void removeContact(EmergencyContact contact) {
    this.emergencyContacts.remove(contact);
  }

  Client copy(
      {String userid,
      String userType,
      String name,
      List<Phone> phones,
      String status,
      String email,
      bool phoneVerified,
      String bday,
      String primaryDoulaId,
      String primaryDoulaName,
      String backupDoulaId,
      String backupDoulaName,
      String dueDate,
      String birthLocation,
      String birthType,
      bool epidural,
      bool cesarean,
      List<EmergencyContact> emergencyContacts,
      int liveBirths,
      bool preterm,
      bool lowWeight,
      List<String> deliveryTypes,
      bool multiples,
      bool meetBefore,
      bool homeVisit,
      bool photoRelease}) {
    return Client(
        userid: userid ?? this.userid,
        userType: userType ?? this.userType,
        name: name ?? this.name,
        phones: phones ?? this.phones,
        email: email ?? this.email,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        status: status ?? this.status,
        bday: bday ?? this.bday,
        primaryDoulaId: primaryDoulaId ?? this.primaryDoulaId,
        primaryDoulaName: primaryDoulaName ?? this.primaryDoulaName,
        backupDoulaId: backupDoulaId ?? this.backupDoulaId,
        backupDoulaName: backupDoulaName ?? this.backupDoulaName,
        dueDate: dueDate ?? this.dueDate,
        birthLocation: birthLocation ?? this.birthLocation,
        birthType: birthType ?? this.birthType,
        epidural: epidural ?? this.epidural,
        cesarean: cesarean ?? this.cesarean,
        emergencyContacts: emergencyContacts ?? this.emergencyContacts,
        liveBirths: liveBirths ?? this.liveBirths,
        preterm: preterm ?? this.preterm,
        lowWeight: lowWeight ?? this.lowWeight,
        deliveryTypes: deliveryTypes ?? this.deliveryTypes,
        multiples: multiples ?? this.multiples,
        meetBefore: meetBefore ?? this.meetBefore,
        homeVisit: homeVisit ?? this.homeVisit,
        photoRelease: photoRelease ?? this.photoRelease);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Client &&
          runtimeType == other.runtimeType &&
          bday == other.bday &&
          primaryDoulaId == other.primaryDoulaId &&
          primaryDoulaName == other.primaryDoulaName &&
          backupDoulaId == other.backupDoulaId &&
          backupDoulaName == other.backupDoulaName &&
          dueDate == other.dueDate &&
          birthLocation == other.birthLocation &&
          birthType == other.birthType &&
          epidural == other.epidural &&
          cesarean == other.cesarean &&
          listEquals(emergencyContacts, other.emergencyContacts) &&
          liveBirths == other.liveBirths &&
          preterm == other.preterm &&
          lowWeight == other.lowWeight &&
          listEquals(deliveryTypes, other.deliveryTypes) &&
          multiples == other.multiples &&
          meetBefore == other.meetBefore &&
          homeVisit == other.homeVisit &&
          status == other.status &&
          photoRelease == other.photoRelease;

  @override
  int get hashCode =>
      super.hashCode ^
      bday.hashCode ^
      primaryDoulaId.hashCode ^
      primaryDoulaName.hashCode ^
      backupDoulaId.hashCode ^
      backupDoulaName.hashCode ^
      dueDate.hashCode ^
      birthLocation.hashCode ^
      birthType.hashCode ^
      epidural.hashCode ^
      cesarean.hashCode ^
      emergencyContacts.hashCode ^
      liveBirths.hashCode ^
      preterm.hashCode ^
      lowWeight.hashCode ^
      deliveryTypes.hashCode ^
      multiples.hashCode ^
      meetBefore.hashCode ^
      homeVisit.hashCode ^
      photoRelease.hashCode ^
      status.hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return "client $userid: at $email\nname: $name";
  }

  // creates this class instance from a map
  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  // declares support for serialization
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
