import 'common.dart';

part 'messagesState.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class MessagesState {
  final Set<String> chats;

  @JsonKey(ignore: true)
  final Contact peer;
//  final bool sendingMessage;
//  final bool sendFail;

  MessagesState({this.chats, this.peer});

  static MessagesState initialState() {
    return MessagesState(chats: null, peer: null);
  }

  MessagesState copy({Set<String> chats, Contact peer}) {
    print("message state copy\n\tpeer: $peer");
    return MessagesState(chats: chats ?? this.chats, peer: peer ?? this.peer);
  }

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            chats == other.chats &&
            peer == other.peer;
  }

  @override
  int get hashCode {
    return chats.hashCode ^ peer.hashCode;
  }

  @override
  String toString() {
    return 'MessagesState{chats: $chats, peer: $peer}';
  }

  factory MessagesState.fromJson(Map<String, dynamic> json) =>
      _$MessagesStateFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesStateToJson(this);
}
