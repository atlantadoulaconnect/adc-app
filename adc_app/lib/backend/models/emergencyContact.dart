import './common.dart';

part 'emergencyContact.g.dart';

@JsonSerializable(explicitToJson: true)
class EmergencyContact {
  String name;
  String relationship;

  // TODO list of phone.dart objects
  List<Phone> phones;

  EmergencyContact(String name, String relationship, List<Phone> phones) {
    this.name = name;
    this.relationship = relationship;
    this.phones = phones;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyContact &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          relationship == other.relationship &&
          listEquals(phones, other.phones);

  @override
  int get hashCode => name.hashCode ^ relationship.hashCode ^ phones.hashCode;

  @override
  String toString() {
    return "${this.relationship}: ${this.name} at ${this.phones.join(", ")}";
  }

  // creates this class instance from a map
  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);

  // declares support for serialization
  Map<String, dynamic> toJson() => _$EmergencyContactToJson(this);
}
