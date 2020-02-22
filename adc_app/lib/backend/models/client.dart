import 'package:flutter/foundation.dart';

import './emergencyContact.dart';
import './user.dart';
import './doula.dart';
import './phone.dart';

class Client extends User {
  String bday;

  Doula primaryDoula;
  Doula backupDoula;

  String dueDate;
  String birthLocation;
  String birthType;
  bool epidural;
  bool cesarean;
  List<EmergencyContact> emergencyContacts;

  int liveBirths;
  bool preterm;
  bool lowWeight;
  List<String> deliveryTypes;
  bool multiples;

  bool meetBefore;
  bool homeVisit;

  bool photoRelease;

  Client(
      {String userid,
      String userType,
      String name,
      String email,
      bool phoneVerified,
      List<Phone> phones,
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
      : super.full(userid, userType, name, email, phoneVerified, phones);

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
        email: email ?? this.email,
        phoneVerified: phoneVerified ?? this.phoneVerified,
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
          primaryDoula == other.primaryDoula &&
          backupDoula == other.backupDoula &&
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
    return "$userid: at $email\nname: $name\n contacts: $emergencyContacts";
  }
}
