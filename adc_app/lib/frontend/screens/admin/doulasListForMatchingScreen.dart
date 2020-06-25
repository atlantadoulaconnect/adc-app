import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

import '../common.dart';

class DoulasListForMatchingScreen extends StatelessWidget {
  final VoidCallback toProfile;
  final User assignee;
  final Future<void> Function(String, String) setProfileUser;
  final Future<void> Function(Client, String, String) setClientDoulas;
  final Future<void> Function(User, String) changeStatus;
  final VoidCallback popScreen;
  final Future<void> Function(Client, String, String) setBackupDoula;

  DoulasListForMatchingScreen(
      this.toProfile,
      this.setProfileUser,
      this.assignee,
      this.setClientDoulas,
      this.changeStatus,
      this.popScreen,
      this.setBackupDoula)
      : assert(toProfile != null && setProfileUser != null);

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
              onPressed: () async {
                //TODO: assign this doula to client
                if ((assignee as Client).primaryDoulaId == null) {
                  await setClientDoulas(
                      (assignee as Client), doc["userid"], doc["name"]);
                } else {
                  await setBackupDoula(
                      (assignee as Client), doc["userid"], doc["name"]);
                  await changeStatus(assignee, "matched");
                }
                toProfile();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                            width: 3.0,
                            color: themeColors["black"],
                          ),
                        ),
                        child: Icon(
                          IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                          color: Colors.black,
                          size: 50,
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
                            "Doula",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ]),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Available Doulas'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("users")
                        .where("userType", isEqualTo: "doula")
                        .where("status", isEqualTo: "approved")
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
                        itemBuilder: (context, index) =>
                            buildItem(context, snapshot.data.documents[index]),
                        itemCount: snapshot.data.documents.length,
                      );
                    }))));
  }
}

class DoulasListForMatchingScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          DoulasListForMatchingScreen(
              vm.toProfile,
              vm.setProfileUser,
              vm.assignee,
              vm.setClientDoulas,
              vm.changeStatus,
              vm.popScreen,
              vm.setBackupDoulas),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  VoidCallback toProfile;
  User assignee;
  Future<void> Function(String, String) setProfileUser;
  Future<void> Function(Client, String, String) setClientDoulas;
  Future<void> Function(User, String) changeStatus;
  VoidCallback popScreen;
  Future<void> Function(Client, String, String) setBackupDoulas;

  ViewModel.build({
    @required this.toProfile,
    @required this.setProfileUser,
    @required this.assignee,
    @required this.setClientDoulas,
    @required this.changeStatus,
    @required this.popScreen,
    @required this.setBackupDoulas,
  });

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      assignee: state.profileUser,
      toProfile: () =>
          dispatch(NavigateAction.pushReplacementNamed("/userProfile")),
      setProfileUser: (String userid, String userType) =>
          dispatchFuture(SetProfileUser(userid, userType)),
      setClientDoulas:
          (Client client, String primaryDoulaId, String primaryDoulaName) =>
              dispatchFuture(
                  UpdateClientDoulas(client, primaryDoulaId, primaryDoulaName)),
      changeStatus: (User user, String status) =>
          dispatchFuture(UpdateUserStatus(user, status)),
      popScreen: () => dispatch(NavigateAction.pop()),
      setBackupDoulas: (Client client, String backupDoulaId,
              String backupDoulaName) =>
          dispatchFuture(
              UpdateClientBackupDoula(client, backupDoulaId, backupDoulaName)),
    );
  }
}
