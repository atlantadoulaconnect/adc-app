import '../../common.dart';

class DoulaAppConfirmationPage extends StatelessWidget {
  final Doula currentUser;
  final VoidCallback toRequestSent;
  final Future<void> Function(Doula) userToDB;
  final void Function(bool) cancelApplication;

  String phonesString;
  String photoPermission;

  DoulaAppConfirmationPage(this.currentUser, this.userToDB, this.toRequestSent,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            userToDB != null &&
            toRequestSent != null &&
            cancelApplication != null);

  String boolStr(bool value) {
    if (value) return "Yes";
    return "No";
  }

  confirmCancelDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Cancel Application"),
          content: Text("Do you want to cancel your application?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                //dispatch CancelApplication
                cancelApplication(true);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                cancelApplication(false);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    phonesString = currentUser.phones.join(", ");
    photoPermission = currentUser.photoRelease
        ? "Yes, I give permission for my photos to be used."
        : "No, I do not give permission for my photos to be used.";

    return Scaffold(
      appBar: AppBar(
        title: Text('Doula Application'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Confirm Your Doula Application',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center),
              // PERSONAL INFORMATION
              Text('Personal Information',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left),
              Text(
                'Name: ${currentUser.name}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Text(
                'Email: ${currentUser.email}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Text(
                'Phone(s): $phonesString',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Text(
                'Birthday (MM/YYYY): ${currentUser.bday}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              // SHORT BIO
              Text('Short Bio',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left),
              Text(
                '${currentUser.bio}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              // CERTIFICATION STATUS
              Text('Certification Status',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left),
              Text(
                'Are you a certified doula? ${boolStr(currentUser.certified)}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Text(
                'Are you working towards becomming a certified doula? ${boolStr(currentUser.certInProgress)}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Text(
                'Certification Program: ${currentUser.certProgram}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Text(
                'Number of documented births needed until you are certified: ${currentUser.birthsNeeded}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              // AVAILABLE DATES
              //              Text('Availability',
              //                  style: TextStyle(
              //                    fontFamily: 'Roboto',
              //                    color: themeColors['emoryBlue'],
              //                    fontWeight: FontWeight.bold,
              //                    fontSize: 25,
              //                    height: 2,
              //                  ),
              //                  textAlign: TextAlign.left),
              //              // PHOTO RELEASE
              Text('Photo Release',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left),
              Text(
                '$photoPermission',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: themeColors['lightBlue'])),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: themeColors['lightBlue'],
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        splashColor: themeColors['lightBlue'],
                        child: Text(
                          "PREVIOUS",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: themeColors['coolGray5'])),
                        onPressed: () {
                          // dialog to confirm cancellation
                          confirmCancelDialog(context);
                        },
                        color: themeColors['coolGray5'],
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        splashColor: themeColors['coolGray5'],
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: themeColors['black'],
                          ),
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: themeColors['yellow'])),
                        onPressed: () async {
                          // add application document
                          // add user to users collection
                          userToDB(currentUser);
                          toRequestSent();
                        },
                        color: themeColors['yellow'],
                        textColor: Colors.black,
                        padding: EdgeInsets.all(15.0),
                        splashColor: themeColors['yellow'],
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ]),
              )
            ]),
      )),
    );
  }
}

class DoulaAppConfirmationPageConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return DoulaAppConfirmationPage(vm.currentUser, vm.userToDB,
            vm.toRequestSent, vm.cancelApplication);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  Future<void> Function(Doula) userToDB;
  VoidCallback toRequestSent;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.userToDB,
      @required this.toRequestSent,
      @required this.cancelApplication})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        userToDB: (Doula user) => dispatchFuture(CreateDoulaUserDocument(user)),
        toRequestSent: () => dispatch(NavigateAction.pushNamed("/requestSent")),
        cancelApplication: (bool confirmed) {
          dispatch(NavigateAction.pop());
          if (confirmed) {
            dispatch(CancelApplicationAction());
            dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          }
        });
  }
}
