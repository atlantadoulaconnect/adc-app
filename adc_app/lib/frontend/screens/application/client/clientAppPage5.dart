import '../../common.dart';

class ClientAppPage5 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, bool, bool) updateClient;
  final VoidCallback toClientAppPage6;
  final void Function(bool) cancelApplication;

  ClientAppPage5(this.currentUser, this.updateClient, this.toClientAppPage6,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage6 != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage5State();
  }
}

class ClientAppPage5State extends State<ClientAppPage5> {
  final GlobalKey<FormState> _c5formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, bool, bool) updateClient;
  VoidCallback toClientAppPage6;
  void Function(bool) cancelApplication;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage6 = widget.toClientAppPage6;
    cancelApplication = widget.cancelApplication;
    super.initState();
  }

  int meetDoula = 1;
  int doulaVisit = 1;

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
      appBar: AppBar(title: Text("Request a Doula")),
      body: Center(
          child: Form(
              key: _c5formKey,
              autovalidate: false,
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
                              side:
                                  BorderSide(color: themeColors['lightBlue'])),
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
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () {
                            final form = _c5formKey.currentState;
                            if (form.validate()) {
                              form.save();

                              updateClient(
                                  currentUser, meetDoula == 1, doulaVisit == 1);

                              toClientAppPage6();
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
    );
  }
}

class ClientAppPage5Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => ClientAppPage5(
          vm.currentUser,
          vm.updateClient,
          vm.toClientAppPage6,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, bool, bool) updateClient;
  VoidCallback toClientAppPage6;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage6,
      @required this.cancelApplication})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      toClientAppPage6: () =>
          dispatch(NavigateAction.pushNamed("/clientAppPage6")),
      updateClient: (Client user, bool meetBefore, bool homeVisit) => dispatch(
          UpdateClientUserAction(user,
              meetBefore: meetBefore, homeVisit: homeVisit)),
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
