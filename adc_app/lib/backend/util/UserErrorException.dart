class UserErrorException implements Exception {
  final String msg;
  const UserErrorException(this.msg);
  String toString() => "UserErrorException: $msg";
}
