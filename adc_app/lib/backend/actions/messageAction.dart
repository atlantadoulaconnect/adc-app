import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/user.dart';
import '../models/admin.dart';
import '../models/client.dart';
import '../models/doula.dart';
import '../models/contact.dart';
import '../models/message.dart';
import '../states/appState.dart';
import '../actions/waitAction.dart';

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
    return state.copy(peer: peer);
  }
}

// when the messages screen opens, creates a thread object in rtdb if dne
// TODO check local storage is thread has already been established
class SetThread extends ReduxAction<AppState> {
  final User currentUser;
  final Contact peer;

  SetThread(this.currentUser, this.peer)
      : assert(currentUser != null && peer != null);

  @override
  Future<AppState> reduce() async {
    var ref = FirebaseDatabase.instance.reference();
    await ref
        .child("chats/${peer.threadId}")
        .once()
        .then((DataSnapshot ds) async {
      if (ds.value == null) {
        print("creating thread: ${peer.threadId}");
        // create thread node
        await ref
            .child("chats/${peer.threadId}")
            .set({"threadId": peer.threadId});
        await ref
            .child("chats/${peer.threadId}/members/${currentUser.userid}")
            .set({"username": currentUser.name});
        await ref
            .child("chats/${peer.threadId}/members/${peer.userId}")
            .set({"username": peer.name});
      }
    });

    return null;
  }
}
