import 'common.dart';
import 'connectionsState.dart';

part 'appState.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class AppState {
  final User currentUser;

  @JsonKey(ignore: true)
  final bool waiting;

  //final Map<String, bool> pages;

  @JsonKey(ignore: true)
  final User profileUser; // User object of profile current user may be viewing

//  @JsonKey(ignore: true)
//  final ErrorsState;
//
//  @JsonKey(ignore: true)
//  final ConnectionsState;

  AppState({this.currentUser, this.waiting, this.profileUser});

  static AppState initialState() {
    return AppState(currentUser: null, waiting: false, profileUser: null);
  }

  AppState copy(
      {User currentUser,
      bool waiting,
      String loginError,
      User profileUser,
      Map<String, bool> pages}) {
    return AppState(
        currentUser: currentUser ?? this.currentUser,
        waiting: waiting ?? this.waiting,
        profileUser: profileUser ?? this.profileUser);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            currentUser == other.currentUser &&
            waiting == other.waiting &&
            profileUser == other.profileUser;
  }

  @override
  int get hashCode {
    return currentUser.hashCode ^ waiting.hashCode ^ profileUser.hashCode;
  }

  @override
  String toString() {
    String type = "none";
    if (currentUser != null && currentUser.userType != null) {
      type = currentUser.userType;
    }
    return "\nAppState:\n\tCurrent User (type: $type): ${this.currentUser.toString()}\n\twaiting: ${this.waiting}";
  }

  // creates this class instance from a map
  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  // declares support for serialization
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
