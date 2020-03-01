import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  //String messageId;
  String senderId;
  String type;
  String content;
  String threadId;
  int timeSent;
  Timestamp timeRead;

  Message.now(this.content, this.senderId, this.type, this.threadId) {
    this.timeSent = DateTime.now().millisecondsSinceEpoch;
  }

  Message(this.content, this.senderId, this.timeSent, this.type, this.threadId);

  Message.fromJson(Map<dynamic, dynamic> json) {
    // messageid, threadid, timeRead
    senderId = json["senderId"];
    type = json["type"];
    content = json["content"];
    timeSent = json["timeSent"];
  }
}
