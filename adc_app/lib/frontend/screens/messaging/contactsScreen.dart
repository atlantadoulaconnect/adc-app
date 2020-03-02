import 'package:adc_app/backend/actions/messageAction.dart';

import '../common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './messagesScreen.dart';

class ContactsScreen extends StatelessWidget {
  final User currentUser;
  final VoidCallback toMessages;
  final void Function(Contact) setPeer;

  ContactsScreen(this.currentUser, this.toMessages, this.setPeer)
      : assert(currentUser != null && toMessages != null);

  String calcThreadId(String current, String peer) {
    if (current.compareTo(peer) < 0) return "$peer-$current";
    return "$current-$peer";
  }

  Widget buildItem(BuildContext context, DocumentSnapshot doc) {
    if (doc["userid"] == currentUser.userid) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(width: 2.0),
              borderRadius: BorderRadius.all(const Radius.circular(20.0))),
          child: MaterialButton(
              onPressed: () {
                // set peer to selected user
                Contact peer = Contact(
                    doc["name"],
                    doc["userid"],
                    doc["userType"],
                    calcThreadId(currentUser.userid, doc["userid"]));
                setPeer(peer);
                toMessages();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 3.0, color: themeColors["black"])),
                        child: Icon(
                          // TODO replace with user profile picture
                          IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                          color: Colors.black,
                          size: 50,
                        ),
                      )),
                  Padding(
                    //padding: EdgeInsets.only(left: 12, right: 20.0),
                    padding: EdgeInsets.all(5),
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
                  //Spacer(),
                  Icon(
                    IconData(57545, fontFamily: 'MaterialIcons'),
                    color: Colors.black,
                    size: 40,
                  ),
                ],
              )),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("users").snapshots(),
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
        return ContactsScreen(vm.currentUser, vm.toMessages, vm.setPeer);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toMessages;
  void Function(Contact) setPeer;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toMessages,
      @required this.setPeer})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toMessages: () => dispatch(NavigateAction.pushNamed("/messages")),
        setPeer: (Contact peer) => dispatch(SetPeer(peer)));
  }
}
