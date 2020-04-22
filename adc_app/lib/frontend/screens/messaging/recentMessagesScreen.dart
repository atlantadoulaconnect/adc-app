import 'package:url_launcher/url_launcher.dart';

import '../common.dart';
//import 'package:url_launcher/url_launcher.dart';

class RecentMessagesScreen extends StatelessWidget {
  final User currentUser;

  // TODO messages page corresponds to card
  final VoidCallback toMessages;
  final VoidCallback toContacts;
  final MessagesState msgSt;
  final void Function(Contact) setPeer;
  final void Function(String) addThread;

  RecentMessagesScreen(this.currentUser, this.toMessages, this.toContacts,
      this.msgSt, this.setPeer, this.addThread);

  String calcThreadId(String current, String peer) {
    if (current.compareTo(peer) < 0) return "$peer-$current";
    return "$current-$peer";
  }

  String extractPeerId(String threadId) {
    String other = threadId.replaceAll(currentUser.userid, "");
    return other.replaceAll("-", "");
  }

  Widget buildItem(BuildContext context, DocumentSnapshot doc) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0),
              borderRadius: BorderRadius.all(const Radius.circular(20.0)),
            ),
            child: MaterialButton(
                onPressed: () {
                  String threadId =
                      calcThreadId(currentUser.userid, doc["userid"]);
                  Contact peer = Contact(
                      doc["name"], doc["userid"], doc["userType"], threadId);
                  addThread(threadId);
                  setPeer(peer);
                  toMessages();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .15,
                          height: MediaQuery.of(context).size.width * .15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 3.0, color: themeColors["black"])),
                          child: Icon(
                            // TODO replace with user profile picture
                            IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                            color: Colors.black,
                            size: MediaQuery.of(context).size.width * .1,
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              // user name
                              doc["name"],
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text(doc["userType"], style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        IconData(57545, fontFamily: 'MaterialIcons'),
                        color: Colors.black,
                        size: MediaQuery.of(context).size.width * .1,
                      ),
                    ),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recent Messages'),
          actions: <Widget>[
            Container(
              width: 55,
              child: MaterialButton(
                onPressed: () => toContacts(),
                child: Icon(
                  IconData(0xe150, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        drawer: Menu(),
        body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Container(
                child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("users/${currentUser.userid}/recentMsgs")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Text(
                          "No recent messages.\nSend a message to someone in your contacts."));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) =>
                      buildItem(context, snapshot.data.documents[index]),
                  itemCount: snapshot.data.documents.length,
                );
              },
            ))));
  }
}

class RecentMessagesScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return RecentMessagesScreen(vm.currentUser, vm.toMessages,
            vm.toContacts, vm.msgSt, vm.setPeer, vm.addThread);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toMessages;
  VoidCallback toContacts;
  MessagesState msgSt;
  void Function(Contact) setPeer;
  void Function(String) addThread;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toMessages,
      @required this.toContacts,
      @required this.msgSt,
      @required this.setPeer,
      @required this.addThread})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toMessages: () => dispatch(NavigateAction.pushNamed("/messages")),
        toContacts: () => dispatch(NavigateAction.pushNamed("/contacts")),
        msgSt: state.messagesState,
        setPeer: (Contact peer) => dispatch(SetPeer(peer)),
        addThread: (String peerId) => dispatch(AddChat(peerId)));
  }
}
