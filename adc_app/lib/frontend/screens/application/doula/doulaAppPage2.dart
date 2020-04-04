import 'package:adc_app/frontend/screens/common.dart';

class DoulaAppPage2 extends StatefulWidget {
  final Doula currentUser;
  final void Function(Doula, String) updateDoula;
  final VoidCallback toDoulaAppPage3;
  final void Function(bool) cancelApplication;

  DoulaAppPage2(this.currentUser, this.updateDoula, this.toDoulaAppPage3,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDoulaAppPage3 != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return DoulaAppPage2State();
  }
}

class DoulaAppPage2State extends State<DoulaAppPage2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Doula currentUser;
  void Function(Doula, String) updateDoula;
  VoidCallback toDoulaAppPage3;
  void Function(bool) cancelApplication;

  TextEditingController _bioCtrl;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDoulaAppPage3 = widget.toDoulaAppPage3;
    cancelApplication = widget.cancelApplication;

    _bioCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _bioCtrl.dispose();
    super.dispose();
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
        appBar: AppBar(title: Text("Doula Application")),
        body: Container(
            child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Short Bio',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['emoryBlue'],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 250,
                child: LinearProgressIndicator(
                  backgroundColor: themeColors['skyBlue'],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                  value: 0.4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please enter a brief description that your \nclients will be able to see',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300.0,
                height: 250.0,
                child: TextField(
                  // TODO validate this user input, show error message
                  minLines: 12,
                  maxLines: 12,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  controller: _bioCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                        'What do you want your clients \nto know about you?',
                  ),
                ),
              ),
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
                            side: BorderSide(color: themeColors['mediumBlue'])),
                        onPressed: () {
                          // inputted information is lost when previous is pressed
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
                            side: BorderSide(color: themeColors['yellow'])),
                        onPressed: () {
                          // dialog to confirm cancellation
                          confirmCancelDialog(context);
                        },
                        color: themeColors['yellow'],
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        splashColor: themeColors['yellow'],
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
                          updateDoula(
                              currentUser, _bioCtrl.text.toString().trim());
                          toDoulaAppPage3();
                        },
                        color: themeColors['yellow'],
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        splashColor: themeColors['yellow'],
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: themeColors['black'],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        )));
  }
}

class DoulaAppPage2Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) => DoulaAppPage2(
            vm.currentUser,
            vm.updateDoula,
            vm.toDoulaAppPage3,
            vm.cancelApplication));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(Doula, String) updateDoula;
  VoidCallback toDoulaAppPage3;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppPage3,
      @required this.cancelApplication});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toDoulaAppPage3: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppPage3")),
        updateDoula: (Doula user, String bio) =>
            dispatch(UpdateDoulaUserAction(user, bio: bio)),
        cancelApplication: (bool confirmed) {
          dispatch(NavigateAction.pop());
          if (confirmed) {
            dispatch(CancelApplicationAction());
            dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          }
        });
  }
}
