abstract class User {
  String userid;
  String userType;

  String name;
  String email;

  // for Sprint 1 demo
  String phone; // List of phone.dart objects later

  User(String userid, String userType, String name, String email) {
    this.userid = userid;
    this.userType = userType;
    this.name = name;
    this.email = email;
  }
}
