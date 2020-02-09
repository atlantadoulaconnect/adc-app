import 'package:meta/meta.dart';
import '../models/user.dart';

@immutable
class AppState {
  final User currentUser;

  AppState({this.currentUser});

  static AppState initialState() {
    // TODO try loading user from local state
    return AppState(currentUser: null);
  }

  AppState copy({User currentUser}) {
    return AppState(currentUser: currentUser ?? this.currentUser);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            currentUser == other.currentUser;
  }

  @override
  int get hashCode {
    return currentUser.hashCode;
  }
}
