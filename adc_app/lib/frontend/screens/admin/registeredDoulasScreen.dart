import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

import '../common.dart';

class RegisteredDoulasScreen extends StatelessWidget {
  final VoidCallback toProfile;
  final Future<void> Function(String, String) setProfileUser;

  RegisteredDoulasScreen(this.toProfile, this.setProfileUser)
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
                await setProfileUser(doc["userid"], doc["userType"]);
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
          title: Text('Registered Doulas'),
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

class RegisteredDoulasScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          RegisteredDoulasScreen(vm.toProfile, vm.setProfileUser),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  VoidCallback toProfile;
  Future<void> Function(String, String) setProfileUser;

  ViewModel.build({@required this.toProfile, @required this.setProfileUser});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        toProfile: () => dispatch(NavigateAction.pushNamed("/userProfile")),
        setProfileUser: (String userid, String userType) =>
            dispatchFuture(SetProfileUser(userid, userType)));
  }
}
