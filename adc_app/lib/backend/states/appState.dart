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

  @JsonKey(ignore: true)
  final bool waiting;

  final MessagesState messagesState;
  final ApplicationState formState;

  @JsonKey(ignore: true)
  final User profileUser; // User object of profile current user may be viewing

//  @JsonKey(ignore: true)
//  final ErrorsState;
//
//  @JsonKey(ignore: true)
//  final ConnectionsState;

  AppState(
      {this.currentUser,
      this.waiting,
      this.formState,
      this.messagesState,
      this.profileUser});

  static AppState initialState() {
    return AppState(
        currentUser: null,
        waiting: false,
        formState: ApplicationState.initialState(),
        messagesState: MessagesState.initialState(),
        profileUser: null);
  }

  AppState copy(
      {User currentUser,
      bool waiting,
      String loginError,
      MessagesState messagesState,
      ApplicationState formState,
      User profileUser}) {
    return AppState(
        currentUser: currentUser ?? this.currentUser,
        waiting: waiting ?? this.waiting,
        messagesState: messagesState ?? this.messagesState,
        formState: formState ?? this.formState,
        profileUser: profileUser ?? this.profileUser);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            currentUser == other.currentUser &&
            waiting == other.waiting &&
            messagesState == other.messagesState &&
            formState == other.formState &&
            profileUser == other.profileUser;
  }

  @override
  int get hashCode {
    return currentUser.hashCode ^
        waiting.hashCode ^
        messagesState.hashCode ^
        formState.hashCode ^
        profileUser.hashCode;
  }

  @override
  String toString() {
    String type = "none";
    if (currentUser != null && currentUser.userType != null) {
      type = currentUser.userType;
    }
    return "\nAppState:\n\tCurrent User (type: $type): ${this.currentUser.toString()}\n\twaiting: ${this.waiting}\n\t${this.formState.toString()}";
  }

  // creates this class instance from a map
  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  // declares support for serialization
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
