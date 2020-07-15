import 'package:adc_app/backend/actions/messageAction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common.dart';

class MessagesScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback toTextBank;
  final Contact peer;
  final Future<void> Function(Message) sendMsg;

  MessagesScreen(this.currentUser, this.toTextBank, this.peer, this.sendMsg)
      : assert(currentUser != null &&
            toTextBank != null &&
            peer != null &&
            sendMsg != null);

  @override
  State<StatefulWidget> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  User currentUser;
  VoidCallback toTextBank;
  Contact peer;
  Future<void> Function(Message) sendMsg;

  @override
  void initState() {
    currentUser = widget.currentUser;
    toTextBank = widget.toTextBank;
    peer = widget.peer;
    sendMsg = widget.sendMsg;
    super.initState();
  }

  _buildMessage(BuildContext context, Message msg) {
    bool isMe = msg.senderId == currentUser.userid;
    Timestamp timeSent = new Timestamp.fromMillisecondsSinceEpoch(msg.timeSent);
    return Row(
      children: <Widget>[
        Container(
          margin: isMe
              ? EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: (MediaQuery.of(context).size.width * .25))
              : EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          width: MediaQuery.of(context).size.width * 0.70,
          decoration: BoxDecoration(
            color: isMe ? themeColors["mediumBlue"] : themeColors["coolGray1"],
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                formatTimeHSS(timeSent),
                style: TextStyle(
                  color: isMe ? themeColors["white"] : themeColors["emoryBlue"],
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0),
              FlatButton(
                padding: EdgeInsets.all(0.0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      msg.content,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: isMe ? themeColors["white"] : themeColors["emoryBlue"],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  if (await canLaunch(msg.content)) {
                    await launch(msg.content);
                  }
                },
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
              decoration:
                  InputDecoration.collapsed(hintText: "Type a message..."),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              // todo handle difference context, validate user input
              print(
                  "message: ${textController.text.toString()}\nme: ${currentUser.userid}\nthread: ${peer.threadId}");
              await sendMsg(Message.now(textController.text.toString(),
                  currentUser.userid, "text", peer.threadId));
              textController.clear();
            },
          ),
        ],
      ),
    );
  }

  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(peer.name)),
          actions: <Widget>[
            Container(
              width: 55,
              child: MaterialButton(
                onPressed: () => toTextBank(),
                child: Icon(
                  Icons.search,
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
                  child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child("chats/${peer.threadId}/messages")
                    .orderByChild("timeSent")
                    .limitToLast(10)
                    .onValue,
                builder: (BuildContext ontext, ds) {
                  if (ds.hasData &&
                      !ds.hasError &&
                      ds.data.snapshot.value != null) {
                    Map data = ds.data.snapshot.value;
                    List<Message> messages = List<Message>();
                    data.forEach((key, value) {
                      messages.add(Message(
                        value["content"],
                        value["senderId"],
                        value["timeSent"],
                        value["type"],
                        peer.threadId,
                      ));
                    });
                    messages.sort((a, b) => b.timeSent.compareTo(a.timeSent));
                    for (Message m in messages) {
                      print(m);
                    }

                    return ListView.builder(
                      padding: EdgeInsets.only(top: 15.0),
                      itemCount: messages.length,
                      itemBuilder: (context, index) =>
                          _buildMessage(context, messages[index]),
                      reverse: true,
                    );
                  }
//                  return Center(
//                      child: CircularProgressIndicator(
//                    valueColor:
//                        AlwaysStoppedAnimation<Color>(themeColors["lightBlue"]),
//                  ));
                    return Container();
                },
              )),
            ),
            _buildMessageComposer()
          ],
        ));
  }
}

class MessagesScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          MessagesScreen(vm.currentUser, vm.toTextBank, vm.peer, vm.sendMsg),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toTextBank;
  Contact peer;
  Future<void> Function(Message) sendMsg;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toTextBank,
      @required this.peer,
      @required this.sendMsg})
      : super(equals: [currentUser, peer]);

  @override
  ViewModel fromStore() {
    print("vm from store peer: ${state.messagesState.peer}");
    return ViewModel.build(
        currentUser: state.currentUser,
        toTextBank: () => dispatch(NavigateAction.pushNamed("/textBank")),
        peer: state.messagesState.peer,
        sendMsg: (Message msg) => dispatchFuture(SendMessageAction(msg)));
  }
}
