import 'common.dart';

part 'messagesState.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class MessagesState {
  final Set<String> chats; // list of user's conversations
  final Set<String> appContacts; // list of ppl user has auth to contact

  @JsonKey(ignore: true)
  final Contact peer;

//  final bool sendingMessage;
//  final bool sendFail;

  MessagesState({this.chats, this.appContacts, this.peer});

  static MessagesState initialState() {
    return MessagesState(chats: null, peer: null, appContacts: null);
  }

  // TODO functionality to remove chat or appContact

  // this method can't change the chats because chat is final
  // referenced by other classes calling the copy method
  MessagesState addChat(String threadId) {
    Set<String> newSet;
    if (this.chats == null) {
      newSet = Set<String>();
    } else {
      newSet = this.chats;
    }
    newSet.add(threadId);
    return copy(chats: newSet);
  }

  // this method can't change the appContacts because appContacts is final
  // referenced by other classes calling the copy method
  MessagesState addAppContact(String userId) {
    Set<String> newSet;
    if (this.appContacts == null) {
      newSet = Set<String>();
    } else {
      newSet = this.appContacts;
    }
    newSet.add(userId);
    //return newSet;
    return copy(appContacts: newSet);
  }

  MessagesState copy(
      {Set<String> chats, Contact peer, Set<String> appContacts}) {
    return MessagesState(
        chats: chats ?? this.chats,
        peer: peer ?? this.peer,
        appContacts: appContacts ?? this.appContacts);
  }

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            chats == other.chats &&
            appContacts == other.appContacts &&
            peer == other.peer;
  }

  @override
  int get hashCode {
    return chats.hashCode ^ peer.hashCode ^ appContacts.hashCode;
  }

  @override
  String toString() {
    return 'MessagesState{chats: $chats, peer: $peer, appContacts: $appContacts}';
  }

  factory MessagesState.fromJson(Map<String, dynamic> json) =>
      _$MessagesStateFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesStateToJson(this);
}
