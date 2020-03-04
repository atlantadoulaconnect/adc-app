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
