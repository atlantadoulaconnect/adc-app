import 'common.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;


import '../actions/loadingAction.dart';

class SendMessageAction extends ReduxAction<AppState> {
  final Message msg;

  SendMessageAction(this.msg) : assert(msg != null);

  // appends message object to corresponding thread
  @override
  Future<AppState> reduce() async {
    String senderId, serverToken;
    try {
      var ref = FirebaseDatabase.instance.reference();
      senderId = ref.child("chats/${msg.senderId}").key;
      var serverTokenRef = ref.child('ServerToken');
      serverTokenRef.once().then((DataSnapshot snapshot){
        serverToken = snapshot.value;
      });

      // print("serverToken: $serverToken");
      //
      // print("sending: ${msg.content}");
      // print("senderId ref: $senderId");

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
    sendNotification(serverToken, senderId, msg.receiverId, msg);

    return null; // "messageDelivered" state change

  }

  Future<void> sendNotification(serverToken, sender, receiver, msg) async {
    Message message = msg;
    var token, name;
    //TODO gotta hide the server token for security reasons
    print("notification serverToken: $serverToken");
    final Firestore _db = Firestore.instance;
    await _db.collection('users')
        .document(sender).get().then((querySnapshot) {
      name = querySnapshot.data['name'].toString();
      //print("querySnapshot.data['token'].toString()" + querySnapshot.data['token'].toString());

    });

    await _db.collection('users')
        .document(receiver).get().then((querySnapshot) {
      token = querySnapshot.data['token'].toString();
      //print("querySnapshot.data['token'].toString()" + querySnapshot.data['token'].toString());

    });

    print("token1 : $token");

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '${message.content}',
            'title': '$name sent a new message!',
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': token,
        },
      ),
    );




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
