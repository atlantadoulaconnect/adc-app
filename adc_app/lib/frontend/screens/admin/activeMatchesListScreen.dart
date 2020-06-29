import '../common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveMatchesListScreen extends StatelessWidget {

  final VoidCallback toActiveMatches;
  final VoidCallback toProfile;
  final Future<void> Function(String, String) setProfileUser;

  final Future<void> Function(User, String) changeStatus;
  final Future<void> Function(Client, String, String) setClientDoulas;
  final Future<void> Function(Client, String, String) setBackupDoulas;
  final Future<void> Function(String, String, String) removeClientDoulas;
  final User profileUser;

  ActiveMatchesListScreen(this.toActiveMatches, this.toProfile,
      this.setProfileUser, this.changeStatus, this.setClientDoulas,
      this.setBackupDoulas, this.profileUser, this.removeClientDoulas)
      : assert(toActiveMatches != null && toProfile != null
                && setProfileUser != null);

  createAlertDialog(BuildContext context, String clientId, String clientName,
      String primaryDoulaId, String primaryDoulaName, String backupDoulaId,
      String backupDoulaName) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Center(
              child: Text(
                  "Active Match",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(20.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Client: " + clientName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        side: BorderSide(color: themeColors['mediumBlue'])),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await setProfileUser(clientId, "client");
                      toProfile();
                    },
                    color: themeColors['mediumBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['mediumBlue'],
                    child: Text(
                      "View Profile",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Primary Doula: " + primaryDoulaName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        side: BorderSide(color: themeColors['mediumBlue'])),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await setProfileUser(primaryDoulaId, "doula");
                      toProfile();
                    },
                    color: themeColors['mediumBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['mediumBlue'],
                    child: Text(
                      "View Profile",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    backupDoulaName != null ?
                    "Backup Doula: " + backupDoulaName :
                    "Backup Doula: Not Assigned",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        side: BorderSide(color: themeColors['mediumBlue'])),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (backupDoulaName != null) {
                        await setProfileUser(backupDoulaId, "doula");
                        toProfile();
                      } else {
                        await setProfileUser(clientId, "client");
                        toProfile();
                      }
                    },
                    color: themeColors['mediumBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['mediumBlue'],
                    child: Text(
                      backupDoulaName != null ?
                      "View Profile" :
                      "Go to Client Profile",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        side: BorderSide(color: themeColors['red'])),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                    "Are you sure?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
//                              content: Text(
//                                "",
//                                style: TextStyle(
//                                  fontSize: 15,
//                                ),
//                              ),
                              actions: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0, left: 12.0, right: 5.0, top: 10.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(15.0),
                                        side: BorderSide(color: themeColors['mediumBlue'])),
                                    color: themeColors['mediumBlue'],
                                    textColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                                    splashColor: themeColors['mediumBlue'],
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Keep Match",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0, right: 12.0, left: 5.0, top: 10.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(15.0),
                                        side: BorderSide(color: themeColors['red'])),
                                    color: themeColors['red'],
                                    textColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                                    splashColor: themeColors['red'],
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await removeClientDoulas(
                                          clientId, clientName, primaryDoulaId);
                                    },
                                    child: Text(
                                      "Delete Match",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      );
                    },
                    color: themeColors['red'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['red'],
                    child: Text(
                      'Cancel This Match',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        side: BorderSide(color: themeColors['yellow'])),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: themeColors['yellow'],
                    textColor: Colors.black,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['yellow'],
                    child: Text(
                      'Close Window',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot doc) {
    return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
        child: Container(
            height: 110,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(const Radius.circular(20.0)),
            ),
            child: MaterialButton(
              onPressed: () {
                createAlertDialog(context, doc["clientId"], doc["clientName"],
                    doc["primaryDoulaId"], doc["primaryDoulaName"],
                    doc["backupDoulaId"], doc["backupDoulaName"]);
              },
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
                          IconData(0xe157, fontFamily: 'MaterialIcons'),
                          color: Colors.black,
                          size: 40,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 20.0, top: 8.0, bottom: 8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(doc["clientName"],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            "Primary: " + doc["primaryDoulaName"],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            doc["backupDoulaName"] != null ?
                            "Backup: " + doc["backupDoulaName"] :
                            "Backup: N/A",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ]),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Active Matches"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("matches")
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
                  })
          ),
        ),
    );
  }
}

class ActiveMatchesListScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return ActiveMatchesListScreen(vm.toActiveMatches,
            vm.toProfile, vm.setProfileUser, vm.changeStatus,
            vm.setClientDoulas, vm.setBackupDoulas, vm.profileUser,
            vm.removeClientDoulas);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  VoidCallback toActiveMatches;
  VoidCallback toProfile;
  Future<void> Function(String, String) setProfileUser;

  Future<void> Function(User, String) changeStatus;
  Future<void> Function(Client, String, String) setClientDoulas;
  Future<void> Function(Client, String, String) setBackupDoulas;
  Future<void> Function(String, String, String) removeClientDoulas;
  User profileUser;

  ViewModel.build({
    @required this.toActiveMatches,
    @required this.toProfile,
    @required this.setProfileUser,
    @required this.changeStatus,
    @required this.setClientDoulas,
    @required this.setBackupDoulas,
    @required this.profileUser,
    @required this.removeClientDoulas,
  });

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      toActiveMatches: () => dispatch(NavigateAction.pushNamed("/activeMatches")),
      toProfile: () => dispatch(NavigateAction.pushNamed("/userProfile")),
      setProfileUser: (String userid, String userType) =>
          dispatchFuture(SetProfileUser(userid, userType)),
      changeStatus: (User user, String status) =>
          dispatchFuture(UpdateUserStatus(user, status)),
      setClientDoulas:
          (Client client, String primaryDoulaId, String primaryDoulaName) =>
          dispatchFuture(
              UpdateClientDoulas(client, primaryDoulaId, primaryDoulaName)),
      setBackupDoulas: (Client client, String backupDoulaId,
          String backupDoulaName) =>
          dispatchFuture(
              UpdateClientBackupDoula(client, backupDoulaId, backupDoulaName)),
      profileUser: state.profileUser,
      removeClientDoulas: (String clientId, String clientName,
        String primaryDoulaId) =>
        dispatchFuture(
            RemoveClientDoulas(clientId, clientName, primaryDoulaId)),
    );
  }
}