abstract class User {
  String userid;
  String userType;

  String name;
  String email;

  bool phoneVerified;

  // for Sprint 1 demo
  List<String> phones; // List of phone.dart objects later

  User(String userid, String userType, String email) {
    this.userid = userid;
    this.userType = userType;
    this.email = email;
    this.phones = new List<String>();
  }

  void addPhone(String phone) {
    this.phones.add(phone);
  }

  void removePhone(String phone) {
    this.phones.remove(phone);
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
          phones == other.phones;

  @override
  int get hashCode =>
      userid.hashCode ^
      userType.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneVerified.hashCode ^
      phones.hashCode;

  @override
  String toString() {
    return "$userid: $userType at $email";
  }
}
