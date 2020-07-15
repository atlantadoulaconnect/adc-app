import '../../common.dart';

class DoulaAppPage5 extends StatefulWidget {
  final Doula currentUser;
  final void Function(bool) updateDoula;
  final VoidCallback toDoulaAppConfirmation;
  final void Function(bool) cancelApplication;

  DoulaAppPage5(this.currentUser, this.updateDoula, this.toDoulaAppConfirmation,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDoulaAppConfirmation != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return DoulaAppPage5State();
  }
}

class DoulaAppPage5State extends State<DoulaAppPage5> {
  Doula currentUser;
  Function(bool) updatedoula;
  VoidCallback toDoulaAppConfirmation;
  void Function(bool) cancelApplication;

  bool photoReleasePermission;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updatedoula = widget.updateDoula;
    toDoulaAppConfirmation = widget.toDoulaAppConfirmation;
    cancelApplication = widget.cancelApplication;

    photoReleasePermission =
        (currentUser.photoRelease == null || !currentUser.photoRelease)
            ? false
            : true;

    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Doula Application'),
      ),
      body: Center(
        child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Photo Release',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 250,
                  child: LinearProgressIndicator(
                    backgroundColor: themeColors['skyBlue'],
                    valueColor: AlwaysStoppedAnimation<Color>(
                        themeColors['mediumBlue']),
                    value: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 330,
                  child: Text(
                    'I grant the Urban Health Initiative of Emory Photo/Video permission to use any photographs in Emory’s own publications or in any other broadcast, print,  or  electronic  media,  including—without  limitation—newspaper, radio,  television,  magazine,  internet.  I  waive  any  right  to  inspect  or  approve  my  depictions  in  these  works.    ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          child: Checkbox(
                        value: photoReleasePermission,
                        onChanged: (bool value) {
                          setState(() {
                            photoReleasePermission = value;
                          });
                        },
                      )),
                      Flexible(
                          child: Text(
                        "I agree to the statement above",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                        ),
                      ))
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              side:
                                  BorderSide(color: themeColors['mediumBlue'])),
                          onPressed: () {
                            // information will be lost
                            updatedoula(photoReleasePermission);

                            Navigator.pop(context);
                          },
                          color: themeColors['mediumBlue'],
                          textColor: Colors.white,
                          padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['mediumBlue'],
                          child: Text(
                            "PREVIOUS",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              side:
                                  BorderSide(color: themeColors['coolGray5'])),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () {
                            updatedoula(photoReleasePermission);
                            toDoulaAppConfirmation();
                          },
                          color: themeColors['yellow'],
                          textColor: Colors.white,
                          padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['yellow'],
                          child: Text(
                            "FINISH",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: themeColors['black'],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ]),
      ),
    );
  }
}

class DoulaAppPage5Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => DoulaAppPage5(
          vm.currentUser,
          vm.updateDoula,
          vm.toDoulaAppConfirmation,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(bool) updateDoula;
  VoidCallback toDoulaAppConfirmation;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppConfirmation,
      @required this.cancelApplication});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        updateDoula: (bool photoRelease) =>
            dispatch(UpdateDoulaUserAction(photoRelease: photoRelease)),
        toDoulaAppConfirmation: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppConfirmation")),
        cancelApplication: (bool confirmed) {
          dispatch(NavigateAction.pop());
          if (confirmed) {
            dispatch(CancelApplicationAction());
            dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          }
        });
  }
}
