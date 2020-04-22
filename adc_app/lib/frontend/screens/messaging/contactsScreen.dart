import 'package:adc_app/backend/actions/messageAction.dart';

import '../common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsScreen extends StatelessWidget {
  final User currentUser;
  final VoidCallback toMessages;
  final void Function(Contact) setPeer;
  final void Function(String) addThread;
  final Set<String> appContacts;

  ContactsScreen(this.currentUser, this.toMessages, this.setPeer,
      this.addThread, this.appContacts)
      : assert(currentUser != null &&
            toMessages != null &&
            setPeer != null &&
            addThread != null);

  String calcThreadId(String current, String peer) {
    if (current.compareTo(peer) < 0) return "$peer-$current";
    return "$current-$peer";
  }

  Widget buildItem(BuildContext context, DocumentSnapshot doc) {
    if (doc["userid"] == currentUser.userid) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          height: 100,
          //width: MediaQuery.of(context).size.width * .6,
          decoration: BoxDecoration(
              border: Border.all(width: 2.0),
              borderRadius: BorderRadius.all(const Radius.circular(20.0))),
          child: MaterialButton(
              onPressed: () {
                // set peer to selected user
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
              )),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // default is admin only
    Firestore fs = Firestore.instance;
    Query getContacts;

    // if user is notype, contact list from messages state
    // if admin, contact list is everyone except for them
    // if client, contact list is pulled from firestore
    // if doula, contact list is pulled from firestore

    // null users do not have access to contacts screen
//    switch (currentUser.userType) {
//      case "admin":
//        {
//          getContacts = fs.collection("users");
//        }
//        break;
//      case "client":
//        {
//          getContacts = fs
//              .collection("users")
//              .where("userid", whereIn: appContacts.toList());
//        }
//        break;
//      case "doula":
//        {
//          getContacts = fs.collection("users");
//        }
//        break;
//      default:
//        {
//          getContacts = fs
//              .collection("users")
//              .where("userid", whereIn: appContacts.toList());
//        }
//        break;
//    }

    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("users").snapshots(),
              //stream: contacts.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(themeColors["lightBlue"]),
                  ));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) =>
                      buildItem(context, snapshot.data.documents[index]),
                  itemCount: snapshot.data.documents.length,
                );
              }),
        ),
      ),
    );
  }
}

class ContactsScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return ContactsScreen(vm.currentUser, vm.toMessages, vm.setPeer,
            vm.addThread, vm.appContacts);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toMessages;
  void Function(Contact) setPeer;
  void Function(String) addThread;
  Set<String> appContacts;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toMessages,
      @required this.setPeer,
      @required this.addThread,
      @required this.appContacts})
      : super(equals: [currentUser, appContacts]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toMessages: () => dispatch(NavigateAction.pushNamed("/messages")),
        setPeer: (Contact peer) => dispatch(SetPeer(peer)),
        addThread: (String peerId) {
          dispatch(AddChat(peerId));
        },
        appContacts: state.messagesState.appContacts);
  }
}
