import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String messageId;
  String senderId = "sender";
  String type;
  String content;
  Timestamp timeSent;
  Timestamp timeRead;

  Message.now(String content, String senderId) {
    Message(content, senderId, new Timestamp.now());
  }

  Message(String content, String senderId, Timestamp timeSent) {
    this.content = content;
    this.senderId = senderId;
    this.timeSent = timeSent;
  }

  String getSenderId() {
    return this.senderId;
  }
}