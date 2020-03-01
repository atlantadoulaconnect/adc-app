abstract class User {
  String userid;
  String userType;

  String name;
  String email;

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
  String toString() {
    return "$userid: $userType at $email";
  }
}
