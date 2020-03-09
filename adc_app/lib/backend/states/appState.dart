import 'common.dart';
import 'applicationState.dart';
import 'connectionsState.dart';
import 'errorsState.dart';
import 'messagesState.dart';

part 'appState.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class AppState {
  final User currentUser;
  final bool waiting;
  final Contact peer;

  //final messagesState;
  final ApplicationState formState;

//  @JsonKey(ignore: true)
//  final ErrorsState;
//
//  @JsonKey(ignore: true)
//  final ConnectionsState;

  // TODO State object for all the errors

  AppState({this.currentUser, this.waiting, this.peer, this.formState}) {
    print(
        "AppState\n\tcurrent user: $currentUser\n\twaiting: $waiting\n\tpeer: $peer");
  }

  static AppState initialState() {
    return AppState(
        currentUser: null, waiting: false, peer: null, formState: null);
  }

  AppState copy(
      {User currentUser,
      bool waiting,
      String loginError,
      Contact peer,
      ApplicationState formState}) {
    return AppState(
        currentUser: currentUser ?? this.currentUser,
        waiting: waiting ?? this.waiting,
        peer: peer ?? this.peer,
        formState: formState ?? this.formState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            currentUser == other.currentUser &&
            waiting == other.waiting &&
            peer == other.peer &&
            formState == other.formState;
  }

  @override
  int get hashCode {
    return currentUser.hashCode ^
        waiting.hashCode ^
        peer.hashCode ^
        formState.hashCode;
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
