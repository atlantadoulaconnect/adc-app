class Phone {
  String number;
  bool isPrimary;
  String extension;
  String type;

  Phone(String number, bool isPrimary, String extension, String type) {
    this.number = number;
    this.isPrimary = isPrimary;
    this.extension = extension;
    this.type = type;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Phone &&
            runtimeType == other.runtimeType &&
            number == other.number &&
            isPrimary == other.isPrimary &&
            extension == other.extension &&
            type == other.type;
  }

  @override
  int get hashCode {
    return number.hashCode ^
        isPrimary.hashCode ^
        extension.hashCode ^
        type.hashCode;
  }

  // TODO toString method
}
