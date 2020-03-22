import './common.dart';

part 'admin.g.dart';

@JsonSerializable(explicitToJson: true)
class Admin extends User {
  Admin(
      {String userid,
      String userType,
      String name,
      String email,
      bool phoneVerified,
      List<Phone> phones,
      Set<String> chats})
      : super.full(userid, userType, name, email, phoneVerified, phones);

  Admin copy(
      {String userid,
      String userType,
      String name,
      List<Phone> phones,
      String email,
      bool phoneVerified,
      Set<String> chats}) {
    return Admin(
        userid: userid ?? this.userid,
        userType: userType ?? this.userType,
        name: name ?? this.name,
        phones: phones ?? this.phones,
        email: email ?? this.email,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        chats: chats ?? this.chats);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other && other is Admin && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return super.toString();
  }

  // creates this class instance from a map
  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  // declares support for serialization
  Map<String, dynamic> toJson() => _$AdminToJson(this);
}
