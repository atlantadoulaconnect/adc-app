import '../common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingApplicationsScreen extends StatelessWidget {
  final Admin currentUser;
  final VoidCallback toProfile;

  PendingApplicationsScreen(this.currentUser, this.toProfile)
      : assert(currentUser != null && toProfile != null);

  Widget buildItem(BuildContext context, DocumentSnapshot doc) {
    return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
        child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(const Radius.circular(20.0)),
            ),
            child: MaterialButton(
              onPressed: () {}, // TODO takes you to that doula's profile
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3.0,
                            color: themeColors["black"],
                          ),
                        ),
                        child: Icon(
                          IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                          color: Colors.black,
                          size: 40,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(doc["name"],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            doc["userType"],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ]),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      IconData(0xe88f, fontFamily: 'MaterialIcons'),
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final _Tabs = <Tab>[Tab(text: 'Doula'), Tab(text: 'Client')];
    return DefaultTabController(
      length: _Tabs.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Pending Applications"),
            bottom: TabBar(
              tabs: _Tabs,
            ),
          ),
          body: TabBarView(
//          Padding(
//              padding: const EdgeInsets.symmetric(vertical: 20.0),
            children: [
              Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("users")
                          .where("userType", isEqualTo: "doula")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                themeColors["lightBlue"]),
                          ));
                        }
                        return ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) => buildItem(
                              context, snapshot.data.documents[index]),
                          itemCount: snapshot.data.documents.length,
                        );
                      })),
              Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("users")
                          .where("userType", isEqualTo: "client")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                themeColors["lightBlue"]),
                          ));
                        }
                        return ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) => buildItem(
                              context, snapshot.data.documents[index]),
                          itemCount: snapshot.data.documents.length,
                        );
                      }))
            ],
//          )
          )),
    );
  }
}

class PendingApplicationsScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return PendingApplicationsScreen(vm.currentUser, vm.toProfile);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toProfile;

  ViewModel.build({@required this.currentUser, @required this.toProfile})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      toProfile: () => dispatch(NavigateAction.pushNamed("/profile")),
      //setPeer: (Contact peer) => dispatch(SetPeer(peer))
    );
  }
}
