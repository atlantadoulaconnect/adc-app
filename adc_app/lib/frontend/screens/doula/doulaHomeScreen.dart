import '../common.dart';

class DoulaHomeScreen extends StatelessWidget {
  final Doula currentUser;
  final VoidCallback logout;
  final VoidCallback toHome;
  final VoidCallback toRecentMessages;
  final VoidCallback toInfo;
  final VoidCallback toProfile;
  final Future<void> Function(String, String) setProfileUser;

  DoulaHomeScreen(this.currentUser, this.logout, this.toHome,
      this.toRecentMessages, this.toInfo, this.toProfile, this.setProfileUser)
      : assert(logout != null &&
            toHome != null &&
            toRecentMessages != null &&
            toInfo != null);

  Widget buildItem(BuildContext context, DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
            side: BorderSide(color: themeColors['seaGreen'], width: 3.0)),
        onPressed: () async {
          await setProfileUser(doc["clientId"], "client");
          toProfile();
        },
        color: themeColors['kellyGreen'],
        textColor: Colors.white,
        padding: EdgeInsets.all(15.0),
        splashColor: themeColors['kellyGreen'],
        child: Text(
          "See ${doc["clientName"]}'s Profile",
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> clientProfileButtons = new List<Widget>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Menu(),
        body: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Center(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            children: <Widget>[
              NotificationHandler(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Welcome${currentUser != null && currentUser.name != null ? ", ${currentUser.name}" : ""}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              //TODO ADD IN CLIENT NAME AFTER MATCHING PAGE IS UP
//              Text("Current Client: ",
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                    fontSize: 20.0,
//                    fontWeight: FontWeight.bold,
//                  )),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: themeColors["lighterGray"],
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(
                        color: themeColors["coolGray2"],
                        width: 3.0,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
                            child: Center(
                                child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection("matches")
                                  .where("primaryDoulaId",
                                      isEqualTo: currentUser.userid)
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
                                return Text(
                                  "You have ${snapshot.data.documents.length} current client(s):",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                );
                              },
                            ))),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Container(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection("matches")
                                    .where("primaryDoulaId",
                                        isEqualTo: currentUser.userid)
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
                                    padding: EdgeInsets.all(20.0),
                                    itemBuilder: (context, index) => buildItem(
                                        context,
                                        snapshot.data.documents[index]),
                                    itemCount: snapshot.data.documents.length,
                                    shrinkWrap: true,
                                  );
                                }),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: themeColors['mediumBlue'])),
                  onPressed: toRecentMessages,
                  color: themeColors['mediumBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['mediumBlue'],
                  child: Text(
                    "See Messages",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: themeColors['mediumBlue'])),
                  onPressed: () async {
                    await setProfileUser(
                        currentUser.userid, currentUser.userType);
                    toProfile();
                  },
                  color: themeColors['mediumBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['mediumBlue'],
                  child: Text(
                    "See My Profile",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: themeColors['mediumBlue'])),
                  onPressed: toInfo,
                  color: themeColors['mediumBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['mediumBlue'],
                  child: Text(
                    "Frequently Asked Questions",
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: themeColors['yellow'])),
                  color: themeColors['yellow'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "LOG OUT",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: themeColors['black'],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    logout();
                    toHome();
                  },
                ),
              ),
            ],
          )),
        ));
  }
}

class DoulaHomeScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => DoulaHomeScreen(
          vm.currentUser,
          vm.logout,
          vm.toHome,
          vm.toRecentMessages,
          vm.toInfo,
          vm.toProfile,
          vm.setProfileUser),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  VoidCallback logout;
  VoidCallback toHome;
  VoidCallback toRecentMessages;
  VoidCallback toInfo;
  VoidCallback toProfile;
  Future<void> Function(String, String) setProfileUser;

  ViewModel.build({
    @required this.currentUser,
    @required this.logout,
    @required this.toHome,
    @required this.toRecentMessages,
    @required this.toInfo,
    @required this.toProfile,
    @required this.setProfileUser,
  }) : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      logout: () {
        dispatch(LogoutUserAction());
        dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
      },
      toHome: () => dispatch(NavigateAction.pushNamed("/")),
      toRecentMessages: () =>
          dispatch(NavigateAction.pushNamed("/recentMessages")),
      toInfo: () => dispatch(NavigateAction.pushNamed("/info")),
      toProfile: () => dispatch(NavigateAction.pushNamed("/userProfile")),
      setProfileUser: (String userid, String userType) =>
          dispatchFuture(SetProfileUser(userid, userType)),
    );
  }
}
