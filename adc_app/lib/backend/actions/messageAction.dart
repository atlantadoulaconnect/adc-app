import 'common.dart';

import 'package:firebase_database/firebase_database.dart';

import '../actions/loadingAction.dart';

class SendMessageAction extends ReduxAction<AppState> {
  final Message msg;

  SendMessageAction(this.msg) : assert(msg != null);

  // appends message object to corresponding thread
  @override
  Future<AppState> reduce() async {
    try {
      var ref = FirebaseDatabase.instance.reference();
      print("sending: ${msg.content}");

      await ref.child("chats/${msg.threadId}/messages/").push().set({
        "senderId": msg.senderId,
        "type": msg.type,
        "content": msg.content,
        "timeSent": msg.timeSent
      });
    } catch (e) {
      print("error sending: $e");
      // change error state ie "message not sent"
    }
    return null; // "messageDelivered" state change
  }

// TODO before/after "deliveringMessage" state change

}

class SetPeer extends ReduxAction<AppState> {
  final Contact peer;

  SetPeer(this.peer) : assert(peer != null);

  @override
  AppState reduce() {
    return state.copy(messagesState: state.messagesState.copy(peer: peer));
  }
}

class AddAppContact extends ReduxAction<AppState> {
  final String userid;

  AddAppContact(this.userid) : assert(userid != null);

  @override
  AppState reduce() {
    return state.copy(messagesState: state.messagesState.addAppContact(userid));
  }
}

class AddChat extends ReduxAction<AppState> {
  final String peerId;

  AddChat(this.peerId) : assert(peerId != null);

  @override
  AppState reduce() {
    return state.copy(messagesState: state.messagesState.addChat(peerId));
  }
}
