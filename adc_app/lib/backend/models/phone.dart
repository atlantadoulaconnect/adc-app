class Phone {
  String number;
  bool isPrimary;

  //String type;

  Phone(String number, bool isPrimary) {
    this.number = number;
    this.isPrimary = isPrimary;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Phone &&
            runtimeType == other.runtimeType &&
            number == other.number &&
            isPrimary == other.isPrimary;
  }

  @override
  int get hashCode {
    return number.hashCode ^ isPrimary.hashCode;
  }

  // TODO toString method
  @override
  String toString() {
    // TODO: implement toString
    return this.number;
  }
}
