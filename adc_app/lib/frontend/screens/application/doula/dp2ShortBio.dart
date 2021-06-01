import 'package:adc_app/frontend/screens/common.dart';

class Dp2ShortBio extends StatefulWidget {
  final Doula currentUser;
  final void Function(String) updateDoula;
  final VoidCallback toDp3Certification;
  final void Function(bool) cancelApplication;

  Dp2ShortBio(this.currentUser, this.updateDoula, this.toDp3Certification,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDp3Certification != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return Dp2ShortBioState();
  }
}

class Dp2ShortBioState extends State<Dp2ShortBio> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Doula currentUser;
  void Function(String) updateDoula;
  VoidCallback toDp3Certification;
  void Function(bool) cancelApplication;

  TextEditingController _bioCtrl;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDp3Certification = widget.toDp3Certification;
    cancelApplication = widget.cancelApplication;

    _bioCtrl = TextEditingController();
    _bioCtrl..text = currentUser.bio;

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

  void saveValidInputs() {
    final form = _formKey.currentState;
    form.save();

    String bio = _bioCtrl.text.toString().trim();

    updateDoula(bio.isEmpty ? null : bio);
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                          themeColors['mediumBlue']),
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
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
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
                    )),
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
                                side: BorderSide(
                                    color: themeColors['mediumBlue'])),
                            onPressed: () {
                              saveValidInputs();

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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: themeColors['yellow'])),
                            onPressed: () {
                              final form = _formKey.currentState;
                              form.save();

                              updateDoula(_bioCtrl.text.toString().trim());
                              toDp3Certification();
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
            ))));
  }
}

class Dp2ShortBioConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) => Dp2ShortBio(
            vm.currentUser,
            vm.updateDoula,
            vm.toDp3Certification,
            vm.cancelApplication));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(String) updateDoula;
  VoidCallback toDp3Certification;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDp3Certification,
      @required this.cancelApplication});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toDp3Certification: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppPage3")),
        updateDoula: (String bio) => dispatch(UpdateDoulaUserAction(bio: bio)),
        cancelApplication: (bool confirmed) {
          dispatch(NavigateAction.pop());
          if (confirmed) {
            dispatch(CancelApplicationAction());
            dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          }
        });
  }
}
