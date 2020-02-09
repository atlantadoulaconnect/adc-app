class Contact {
  String contact_id;
  String name;
  String relationship;

  // TODO list of phone.dart objects
  String phone;

  Contact(String name, String relationship, String phone) {
    this.name = name;
    this.relationship = relationship;
    this.phone = phone;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          contact_id == other.contact_id &&
          name == other.name &&
          relationship == other.relationship &&
          phone == other.phone;

  @override
  int get hashCode =>
      contact_id.hashCode ^
      name.hashCode ^
      relationship.hashCode ^
      phone.hashCode;

  @override
  String toString() {
    return "${this.relationship}: ${this.name} at ${this.phone}";
  }
}
