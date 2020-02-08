import 'package:meta/meta.dart';
import './userState.dart';

@immutable
class AppState {
  final UserState userState;

  AppState({this.userState});

  static AppState initialState() {
    return AppState(userState: UserState.initialState());
  }

  AppState copy({UserState userState}) {
    return AppState(userState: userState ?? this.userState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            userState == other.userState;
  }

  @override
  int get hashCode {
    return userState.hashCode;
  }
}
