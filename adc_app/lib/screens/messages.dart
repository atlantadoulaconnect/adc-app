import 'package:adc_app/models/message.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/util/time_conversion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MessagesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    super.initState();
  }

  _buildMessage(Message message, bool isMe) {
    return Row(
      children: <Widget>[
        Container(
          margin: isMe
              ? EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: 80.0
                )
              : EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  right: 60.0,
                  left: 20.0
                ),
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: isMe ? themeColors["mediumBlue"] : themeColors["coolGray1"],
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                formatTimeHSS(message.timeSent),
                style: TextStyle(
                  color: isMe ? themeColors["white"] : themeColors["emoryBlue"],
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                message.content,
                style: TextStyle(
                  color: isMe ? themeColors["white"] : themeColors["emoryBlue"],
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: textController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: "Type a message..."
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              messages.add(new Message(textController.text, myId, new Timestamp.now()));
              textController.clear();
            },
          ),
        ],
      ),
    );
  }

  TextEditingController textController = new TextEditingController();

  final String otherUser = "Debbie";
  final String myId = "0";
  List<Message> messages = [
    new Message("Hello! My name is Debbie. I am your doula!", "1", new Timestamp.now()),
    new Message("Hi Debbie! I'm Jane!", "0", new Timestamp.now()),
    new Message("How long have you been a doula?", "0", new Timestamp.now()),
    new Message("I've been a doula for 3 years!", "1", new Timestamp.now()),
    new Message("What do you think of the Atlanta Doula Connect app?", "1", new Timestamp.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(otherUser)),
          actions: <Widget>[
            Container(
              width: 55,
              child: MaterialButton(
                onPressed: () {},
                child: Icon(Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 15.0),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = messages[index];
                    final bool isMe = message.getSenderId() == myId;
                    return _buildMessage(message, isMe);
//                    return Text(index.toString());
                  },
                ),
              ),
            ),
            _buildMessageComposer()
          ],
        )
    );
  }
}