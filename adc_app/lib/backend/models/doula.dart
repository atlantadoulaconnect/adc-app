import 'package:flutter/foundation.dart';

import './user.dart';
import './client.dart';
import './phone.dart';

class Doula extends User {
  String bday;
  bool emailVerified;

  String bio;
  bool certified;
  bool certInProgress;
  String certProgram;
  int birthsNeeded;
  List<String> availableDates;
  bool photoRelease;

  List<Client> currentClients;

  Doula(
      {String userid,
      String userType,
      String name,
      String email,
      bool phoneVerified,
      List<Phone> phones,
      Set<String> chats,
      this.bday,
      this.emailVerified,
      this.bio,
      this.certified,
      this.certInProgress,
      this.certProgram,
      this.birthsNeeded,
      this.availableDates,
      this.photoRelease,
      this.currentClients})
      : super.full(userid, userType, name, email, phoneVerified, phones) {
    this.availableDates = new List<String>();
    this.currentClients = new List<Client>();
  }

  void addAvailableDate(String date) {
    this.availableDates.add(date);
  }

  void removeAvailableDate(String date) {
    this.availableDates.remove(date);
  }

  void addCurrentClient(Client client) {
    this.currentClients.add(client);
  }

  void removeCurrentClient(Client client) {
    this.currentClients.remove(client);
  }

  Doula copy(
      {String userid,
      String userType,
      String name,
      String email,
      bool phoneVerified,
      List<Phone> phones,
      Set<String> chats,
      String bday,
      bool emailVerified,
      String bio,
      bool certified,
      bool certInProgress,
      String certProgram,
      int birthsNeeded,
      List<String> availableDates,
      bool photoRelease,
      List<Client> currentClients}) {
    return Doula(
        userid: userid ?? this.userid,
        userType: userType ?? this.userType,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        chats: chats ?? this.chats,
        phones: phones ?? this.phones,
        bday: bday ?? this.bday,
        emailVerified: emailVerified ?? this.emailVerified,
        bio: bio ?? this.bio,
        certified: certified ?? this.certified,
        certInProgress: certInProgress ?? this.certInProgress,
        certProgram: certProgram ?? this.certProgram,
        birthsNeeded: birthsNeeded ?? this.birthsNeeded,
        availableDates: availableDates ?? this.availableDates,
        photoRelease: photoRelease ?? this.photoRelease,
        currentClients: currentClients ?? this.currentClients);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Doula &&
          runtimeType == other.runtimeType &&
          bday == other.bday &&
          emailVerified == other.emailVerified &&
          bio == other.bio &&
          certified == other.certified &&
          certInProgress == other.certInProgress &&
          certProgram == other.certProgram &&
          birthsNeeded == other.birthsNeeded &&
          listEquals(availableDates, other.availableDates) &&
          photoRelease == other.photoRelease &&
          currentClients == other.currentClients;

  @override
  int get hashCode =>
      super.hashCode ^
      bday.hashCode ^
      emailVerified.hashCode ^
      bio.hashCode ^
      certified.hashCode ^
      certInProgress.hashCode ^
      certProgram.hashCode ^
      birthsNeeded.hashCode ^
      availableDates.hashCode ^
      photoRelease.hashCode ^
      currentClients.hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
