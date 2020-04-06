import 'common.dart';
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

  final Map<String, bool> pages;

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
      this.messagesState,
      this.profileUser,
      this.pages});

  static AppState initialState() {
    return AppState(
        currentUser: null,
        waiting: false,
        messagesState: MessagesState.initialState(),
        profileUser: null,
        pages: null);
  }

  AppState copy(
      {User currentUser,
      bool waiting,
      String loginError,
      MessagesState messagesState,
      User profileUser,
      Map<String, bool> pages}) {
    return AppState(
        currentUser: currentUser ?? this.currentUser,
        waiting: waiting ?? this.waiting,
        messagesState: messagesState ?? this.messagesState,
        profileUser: profileUser ?? this.profileUser,
        pages: pages ?? this.pages);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            currentUser == other.currentUser &&
            waiting == other.waiting &&
            messagesState == other.messagesState &&
            profileUser == other.profileUser &&
            mapEquals(pages, other.pages);
  }

  @override
  int get hashCode {
    return currentUser.hashCode ^
        waiting.hashCode ^
        messagesState.hashCode ^
        profileUser.hashCode ^
        pages.hashCode;
  }

  @override
  String toString() {
    String type = "none";
    if (currentUser != null && currentUser.userType != null) {
      type = currentUser.userType;
    }
    return "\nAppState:\n\tCurrent User (type: $type): ${this.currentUser.toString()}\n\twaiting: ${this.waiting}\n\tpages: ${pages != null ? pages.toString() : "no pages"}";
  }

  // creates this class instance from a map
  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  // declares support for serialization
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
