import 'package:flutter/foundation.dart';
import './phone.dart';
import './user.dart';

class Admin extends User {
  String role;
  List<String> privileges;

  Admin(
      {String userid,
      String userType,
      String name,
      String email,
      bool phoneVerified,
      List<Phone> phones,
      this.role,
      this.privileges})
      : super.full(userid, userType, name, email, phoneVerified, phones);

  void addPrivilege(String privilege) {
    this.privileges.add(privilege);
  }

  void removeDeliveryType(String privilege) {
    this.privileges.remove(privilege);
  }

  Admin copy(
      {String userid,
      String userType,
      String name,
      List<Phone> phones,
      String email,
      bool phoneVerified,
      String role,
      List<String> privileges}) {
    return Admin(
        userid: userid ?? this.userid,
        userType: userType ?? this.userType,
        name: name ?? this.name,
        phones: phones ?? this.phones,
        email: email ?? this.email,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        role: role ?? this.role,
        privileges: privileges ?? this.privileges);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Admin &&
          runtimeType == other.runtimeType &&
          role == other.role &&
          listEquals(privileges, other.privileges);

  @override
  int get hashCode => super.hashCode ^ role.hashCode ^ privileges.hashCode;

  @override
  String toString() {
    return super.toString();
  }
}
