import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  String messageId;
  String senderId = "sender";
  String type;
  String content;
//  Timestamp timeSent;
  TimeOfDay timeSent;
  Timestamp timeRead;

  Message.now(String content, String senderId) {
    Message("Content", "Test", new TimeOfDay.now());
  }

  Message(String content, String senderId, TimeOfDay timeSent) {
    this.content = content;
    this.senderId = senderId;
    this.timeSent = timeSent;
  }

  String getSenderId() {
    return this.senderId;
  }
}