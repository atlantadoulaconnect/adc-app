import '../../common.dart';

class ClientAppConfirmationPage extends StatelessWidget {
  final Client currentUser;
  final VoidCallback toRequestSent;
  final Future<void> Function(Client) userToDB;
  final void Function(bool) cancelApplication;

  String phonesString;
  String deliveryTypes;
  String photoPermission;

  ClientAppConfirmationPage(this.currentUser, this.toRequestSent, this.userToDB,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
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
    deliveryTypes = currentUser.deliveryTypes.join(", ");

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
            children: <Widget>[
              Text('Confirm Your Doula Request',
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

              // EMERGENCY CONTACTS

              Text('Emergency Contacts',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left),
              Text(
                "${currentUser.emergencyContacts.join("\n")}",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),

              // CURRENT PREGNANCY DETAILS

              Text('Current Pregnancy Details',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left),
              Text(
                "Due date: ${currentUser.dueDate}",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Text(
                "Planned Birth Location: ${currentUser.birthLocation}",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Text(
                "Birth Types: ${currentUser.birthType}",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),

              // PREVIOUS BIRTH DETAILS

              Text('Previous Birth Details',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left),
              Text(
                "Number of Previous Live Births: ${currentUser.liveBirths}",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Visibility(
                visible: currentUser.liveBirths > 0,
                child: Text(
                  "Did you give birth to a preterm baby? ${boolStr(currentUser.preterm)}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
              ),
              Visibility(
                visible: currentUser.liveBirths > 0,
                child: Text(
                  "Did you give birth to a low weight baby? ${boolStr(currentUser.lowWeight)}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
              ),
              Visibility(
                visible: currentUser.liveBirths > 0,
                child: Text(
                  "Previous ways you gave birth: $deliveryTypes",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
              ),

              // DOULA PREFERENCES
              Text('Doula Preferences',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left),
              Text(
                "I want to meet my doula before I give birth: ${boolStr(currentUser.meetBefore)}",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
              Text(
                "I want my doula to visit my home after I give birth: ${boolStr(currentUser.homeVisit)}",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['black'],
                    fontSize: 18,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),

              // PHOTO RELEASE

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
            ],
          ),
        ),
      ),
    );
  }
}

class ClientAppConfirmationPageConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return ClientAppConfirmationPage(vm.currentUser, vm.toRequestSent,
            vm.userToDB, vm.cancelApplication);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  VoidCallback toRequestSent;
  Future<void> Function(Client) userToDB;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toRequestSent,
      @required this.userToDB,
      @required this.cancelApplication})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      userToDB: (Client user) => dispatchFuture(CreateClientUserDocument(user)),
      toRequestSent: () => dispatch(NavigateAction.pushNamed("/requestSent")),
      cancelApplication: (bool confirmed) {
        dispatch(NavigateAction.pop());
        if (confirmed) {
          dispatch(CancelApplicationAction());
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        }
      },
    );
  }
}
