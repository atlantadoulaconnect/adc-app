import './common.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(required: true)
  String userid;
  String status; // incomplete is default, admin has status "approved"

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
      this.phoneVerified, this.phones, this.status);

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
          setEquals(chats, other.chats) &&
          status == other.status;

  @override
  int get hashCode =>
      userid.hashCode ^
      userType.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneVerified.hashCode ^
      phones.hashCode ^
      chats.hashCode ^
      status.hashCode;

  @override
  String toString() {
    return "$userType $userid: at $email\nname: $name status: $status";
  }

  // creates this class instance from a map
  factory User.fromJson(Map<String, dynamic> json) {
    switch (json["userType"]) {
      case "admin":
        {
          return Admin.fromJson(json);
        }
        break;
      case "client":
        {
          return Client.fromJson(json);
        }
        break;
      case "doula":
        {
          return Doula.fromJson(json);
        }
    }
    return _$UserFromJson(json);
  }

  // declares support for serialization
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
