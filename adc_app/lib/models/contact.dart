class Contact {
  String contact_id;
  String name;
  String relationship;

  // todo list of phone.dart objects
  String phone;

  Contact(String name, String relationship, String phone) {
    this.name = name;
    this.relationship = relationship;
    this.phone = phone;
  }

  @override
  String toString() {
    return "${this.relationship}: ${this.name} at ${this.phone}";
  }
}
