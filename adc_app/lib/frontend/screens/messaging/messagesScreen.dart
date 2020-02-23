import 'package:cloud_firestore/cloud_firestore.dart';

import '../common.dart';

class MessagesScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback toTextBank;

  MessagesScreen(this.currentUser, this.toTextBank);

  @override
  State<StatefulWidget> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  User currentUser;
  VoidCallback toTextBank;

  @override
  void initState() {
    currentUser = widget.currentUser;
    toTextBank = widget.toTextBank;
    super.initState();
  }

  _buildMessage(Message message, bool isMe) {
    return Row(
      children: <Widget>[
        Container(
          margin: isMe
              ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
              : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0, left: 20.0),
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: isMe ? themeColors["mediumBlue"] : themeColors["coolGray1"],
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              decoration:
                  InputDecoration.collapsed(hintText: "Type a message..."),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              messages.add(
                  new Message(textController.text, myId, new Timestamp.now()));
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
    Message("Hello! My name is Debbie. I am your doula!", "1",
        Timestamp.fromDate(DateTime(2020, 2, 17, 21, 50))),
    Message("Hi Debbie! I'm Jane!", "0",
        Timestamp.fromDate(DateTime(2020, 2, 17, 21, 51))),
    Message("How long have you been a doula?", "0",
        Timestamp.fromDate(DateTime(2020, 2, 17, 21, 51))),
    Message("I've been a doula for 3 years!", "1",
        Timestamp.fromDate(DateTime(2020, 2, 17, 21, 53))),
    Message("What do you think of the Atlanta Doula Connect app?", "1",
        Timestamp.fromDate(DateTime(2020, 2, 17, 21, 53)))
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
        ));
  }
}

class MessagesScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          MessagesScreen(vm.currentUser, vm.toTextBank),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toTextBank;

  ViewModel.build({@required currentUser, @required toTextBank})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toTextBank: () =>
            dispatch(NavigateAction.pushNamed("/textBankConnector")));
  }
}
