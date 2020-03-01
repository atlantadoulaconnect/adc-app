class Contact {
  String name;
  String userId;
  String title;
  String threadId;

  String photoURL;

  Contact(this.name, this.userId, this.title, this.threadId);

  @override
  bool operator ==(other) {
    identical(this, other) ||
        other is Contact &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            userId == other.userId &&
            title == other.title &&
            threadId == other.threadId &&
            photoURL == other.photoURL;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      userId.hashCode ^
      title.hashCode ^
      threadId.hashCode ^
      photoURL.hashCode;

  @override
  String toString() {
    return "$title $name $userId";
  }
}
