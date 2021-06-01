import './common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  //String messageId;
  String senderId;
  String receiverId;
  String type;
  String content;
  String threadId;
  int timeSent;
  //Timestamp timeRead;

  Message.now(this.content, this.senderId, this.receiverId, this.type, this.threadId) {
    this.timeSent = DateTime.now().millisecondsSinceEpoch;
  }

  Message(this.content, this.senderId, this.receiverId, this.timeSent, this.type, this.threadId);

  @override
  String toString() {
    return content;
  }

  // creates this class instance from a map
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  // declares support for serialization
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
