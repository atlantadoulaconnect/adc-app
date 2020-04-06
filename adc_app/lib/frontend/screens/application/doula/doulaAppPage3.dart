import 'package:adc_app/frontend/screens/common.dart';

class DoulaAppPage3 extends StatefulWidget {
  final Doula currentUser;
  final void Function(Doula, bool, bool, String, int) updateDoula;
  final VoidCallback toDoulaAppPage4;
  final void Function(bool) cancelApplication;

  DoulaAppPage3(this.currentUser, this.updateDoula, this.toDoulaAppPage4,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDoulaAppPage4 != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return DoulaAppPage3State();
  }
}

class DoulaAppPage3State extends State<DoulaAppPage3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Doula currentUser;
  void Function(Doula, bool, bool, String, int) updateDoula;
  VoidCallback toDoulaAppPage4;
  void Function(bool) cancelApplication;

  TextEditingController _birthsNeeded;

  List<bool> selectedCert = [false, true];
  List<bool> selectedProgress = [true, false];
  String dropdownValue = "";

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDoulaAppPage4 = widget.toDoulaAppPage4;
    cancelApplication = widget.cancelApplication;

    _birthsNeeded = TextEditingController();

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Certification Status',
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
                    value: 0.6,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Are you a certified doula?',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ToggleButtons(
                    children: <Widget>[
                      Text(
                        "Yes",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "No",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                    borderRadius: new BorderRadius.circular(10.0),
                    constraints: BoxConstraints(
                      minWidth: 100,
                      minHeight: 40,
                    ),
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < selectedCert.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            selectedCert[buttonIndex] = true;
                          } else {
                            selectedCert[buttonIndex] = false;
                          }
                        }
                      });
                    },
                    isSelected: selectedCert,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Are you working towards becoming a certified doula?',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ToggleButtons(
                    children: <Widget>[
                      Text(
                        "Yes",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "No",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                    borderRadius: new BorderRadius.circular(10.0),
                    constraints: BoxConstraints(
                      minWidth: 100,
                      minHeight: 40,
                    ),
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < selectedProgress.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            selectedProgress[buttonIndex] = true;
                          } else {
                            selectedProgress[buttonIndex] = false;
                          }
                        }
                      });
                    },
                    isSelected: selectedProgress,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Certification Program:',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: 80,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            underline: Container(
                              height: 2,
                              color: themeColors['emoryBlue'],
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>[
                              '',
                              'DONA',
                              'CAPPA',
                              'ICEA',
                              'Other'
                            ].map<DropdownMenuItem<String>>((String value) {
                              // TODO if Other is selected then an  option to type that program
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Number of documented births needed until you are certified:',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 205.0,
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: _birthsNeeded,
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
                              side:
                                  BorderSide(color: themeColors['mediumBlue'])),
                          onPressed: () {
                            // info won't be saved
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
                            // TODO input validation and error message
                            bool isCertified = selectedCert[0] == true;
                            bool inProgress = selectedProgress[0] == true;
                            String program =
                                dropdownValue == "" ? "none" : dropdownValue;
                            int births =
                                int.parse(_birthsNeeded.text.toString().trim());
                            updateDoula(currentUser, isCertified, inProgress,
                                program, births);

                            toDoulaAppPage4();
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
            ])));
  }
}

class DoulaAppPage3Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => DoulaAppPage3(
          vm.currentUser,
          vm.updateDoula,
          vm.toDoulaAppPage4,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(Doula, bool, bool, String, int) updateDoula;
  VoidCallback toDoulaAppPage4;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppPage4,
      @required this.cancelApplication});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        updateDoula: (Doula user, bool certified, bool inProgress,
                String program, int birthsNeeded) =>
            dispatch(UpdateDoulaUserAction(user,
                certified: certified,
                certInProgress: inProgress,
                certProgram: program,
                birthsNeeded: birthsNeeded)),
        toDoulaAppPage4: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppPage4")),
        cancelApplication: (bool confirmed) {
          dispatch(NavigateAction.pop());
          if (confirmed) {
            dispatch(CancelApplicationAction());
            dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          }
        });
  }
}
