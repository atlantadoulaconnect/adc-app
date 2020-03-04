import 'package:flutter/foundation.dart';
import './phone.dart';

class User {
  String userid;
  String userType;
  String name;
  String email;
  List<Phone> phones; // List of phone.dart objects later
  Set<String> chats;

  bool
      phoneVerified; // if the primary phone used for the app is verified via SMS confirmation

  User(String userid, String email) {
    this.userid = userid;
    this.email = email;
  }

  User.full(this.userid, this.userType, this.name, this.email,
      this.phoneVerified, this.phones);

  void addPhone(Phone phone) {
    this.phones.add(phone);
  }

  void removePhone(Phone phone) {
    this.phones.remove(phone);
  }

  Set<String> addChat(String threadId) {
    if (this.chats == null) {
      this.chats = Set<String>();
    }
    this.chats.add(threadId);
    return this.chats;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          userid == other.userid &&
          userType == other.userType &&
          name == other.name &&
          email == other.email &&
          phoneVerified == other.phoneVerified &&
          listEquals(phones, other.phones) &&
          setEquals(chats, other.chats);

  @override
  int get hashCode =>
      userid.hashCode ^
      userType.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneVerified.hashCode ^
      phones.hashCode ^
      chats.hashCode;

  @override
  String toString() {
    return "$userType $userid: at $email\nname: $name";
  }
}
