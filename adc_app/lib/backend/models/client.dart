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

  bool epidural;
  bool homeVisit;
  int liveBirths;
  bool lowWeight;
  bool meetBefore;
  bool multiples;

  bool photoRelease;
  bool preterm;

  List<EmergencyContact> emergencyContacts;
  Map<String, String> primaryDoula; // {"name": "Debra D.", "userid": "ABCD123"}
  Map<String, String> backupDoula;

  Client(
      {String userid,
      String userType,
      String name,
      String email,
      bool phoneVerified,
      List<Phone> phones,
      Set<String> chats,
      String status,
      this.bday,
      this.primaryDoula,
      this.backupDoula,
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
      Set<String> chats,
      String status,
      String email,
      bool phoneVerified,
      String bday,
      Doula primaryDoula,
      Doula backupDoula,
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
        chats: chats ?? this.chats,
        email: email ?? this.email,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        status: status ?? this.status,
        bday: bday ?? this.bday,
        primaryDoula: primaryDoula ?? this.primaryDoula,
        backupDoula: backupDoula ?? this.backupDoula,
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
          mapEquals(primaryDoula, other.primaryDoula) &&
          mapEquals(backupDoula, other.backupDoula) &&
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
          photoRelease == other.photoRelease;

  @override
  int get hashCode =>
      super.hashCode ^
      bday.hashCode ^
      primaryDoula.hashCode ^
      backupDoula.hashCode ^
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
      photoRelease.hashCode;

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
