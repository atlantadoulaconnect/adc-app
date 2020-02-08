import 'package:meta/meta.dart';
import '../models/user.dart';

@immutable
class UserState {
  final bool isLoggedIn;
  final User currentUser;

  UserState({this.isLoggedIn, this.currentUser});

  static UserState initialState() {
    return UserState(isLoggedIn: false, currentUser: null);
  }

  UserState copy({bool isLoggedIn, User currentUser}) {
    return UserState(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        currentUser: currentUser ?? this.currentUser);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UserState &&
            runtimeType == other.runtimeType &&
            isLoggedIn == other.isLoggedIn &&
            currentUser == other.currentUser;
  }

  @override
  int get hashCode {
    return isLoggedIn.hashCode ^ currentUser.hashCode;
  }
}
