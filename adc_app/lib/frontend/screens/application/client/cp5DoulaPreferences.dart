import '../../common.dart';

class Cp5DoulaPreferences extends StatefulWidget {
  final Client currentUser;
  final void Function(bool, bool) updateClient;
  final VoidCallback toCp6PhotoRelease;
  final void Function(bool) cancelApplication;

  Cp5DoulaPreferences(this.currentUser, this.updateClient,
      this.toCp6PhotoRelease, this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toCp6PhotoRelease != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return Cp5DoulaPreferencesState();
  }
}

class Cp5DoulaPreferencesState extends State<Cp5DoulaPreferences> {
  final GlobalKey<FormState> _c5formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(bool, bool) updateClient;
  VoidCallback toCp6PhotoRelease;
  void Function(bool) cancelApplication;

  int meetDoula;
  int doulaVisit;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toCp6PhotoRelease = widget.toCp6PhotoRelease;
    cancelApplication = widget.cancelApplication;

    initialPlaceholders();

    super.initState();
  }

  void initialPlaceholders() {
    meetDoula = currentUser.meetBefore != null
        ? (currentUser.meetBefore ? 1 : 2)
        : null;
    doulaVisit =
        currentUser.homeVisit != null ? (currentUser.homeVisit ? 1 : 2) : null;
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

  void saveValidInputs() {
    final form = _c5formKey.currentState;
    form.save();

    updateClient(meetDoula == null ? null : meetDoula == 1,
        doulaVisit == null ? null : doulaVisit == 1);
  }

  Future<bool> _onBackPressed() {
    saveValidInputs();
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(title: Text("Request a Doula")),
          body: Center(
              child: Form(
                  key: _c5formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Doula Preferences',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: themeColors['emoryBlue'],
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250,
                          child: LinearProgressIndicator(
                            backgroundColor: themeColors['skyBlue'],
                            valueColor: AlwaysStoppedAnimation<Color>(
                                themeColors['mediumBlue']),
                            value: 0.8,
                          ),
                        ),
                      ),
                      //meet your doula?
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Would you like to meet your doula in person before delivery? ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                        child: Row(children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: meetDoula,
                            onChanged: (T) {
                              setState(() {
                                meetDoula = T;
                              });
                            },
                          ),
                          Text('Yes'),
                          Radio(
                            value: 2,
                            groupValue: meetDoula,
                            onChanged: (T) {
                              setState(() {
                                meetDoula = T;
                              });
                            },
                          ),
                          Text('No'),
                        ]),
                      ),
                      //doula home visit?
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Would you like your doula to make a home visit after delivery? ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                        child: Row(children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: doulaVisit,
                            onChanged: (T) {
                              setState(() {
                                doulaVisit = T;
                              });
                            },
                          ),
                          Text('Yes'),
                          Radio(
                            value: 2,
                            groupValue: doulaVisit,
                            onChanged: (T) {
                              setState(() {
                                doulaVisit = T;
                              });
                            },
                          ),
                          Text('No'),
                        ]),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  side: BorderSide(
                                      color: themeColors['lightBlue'])),
                              onPressed: () {
                                saveValidInputs();

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
                                  side: BorderSide(
                                      color: themeColors['coolGray5'])),
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
                                  side:
                                      BorderSide(color: themeColors['yellow'])),
                              onPressed: () {
                                final form = _c5formKey.currentState;
                                if (form.validate()) {
                                  form.save();

                                  updateClient(meetDoula == 1, doulaVisit == 1);

                                  toCp6PhotoRelease();
                                }
                              },
                              color: themeColors['yellow'],
                              textColor: Colors.black,
                              padding: EdgeInsets.all(15.0),
                              splashColor: themeColors['yellow'],
                              child: Text(
                                "NEXT",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ]),
                    ],
                  ))),
        ));
  }
}

class Cp5DoulaPreferencesConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => Cp5DoulaPreferences(
          vm.currentUser,
          vm.updateClient,
          vm.toCp6PhotoRelease,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(bool, bool) updateClient;
  VoidCallback toCp6PhotoRelease;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toCp6PhotoRelease,
      @required this.cancelApplication})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      toCp6PhotoRelease: () =>
          dispatch(NavigateAction.pushNamed("/cp6PhotoRelease")),
      updateClient: (bool meetBefore, bool homeVisit) => dispatch(
          UpdateClientUserAction(meetBefore: meetBefore, homeVisit: homeVisit)),
      cancelApplication: (bool confirmed) {
        dispatch(NavigateAction.pop());
        if (confirmed) {
          dispatch(CancelApplicationAction());
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        }
      },
//        completePage: (String pageName) =>
//            dispatch(CompletePageAction(pageName))
    );
  }
}