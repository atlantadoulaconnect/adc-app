import 'package:adc_app/frontend/screens/common.dart';

class DoulaAppPage3 extends StatefulWidget {
  final Doula currentUser;
  final void Function(Doula, bool, bool, String, int) updateDoula;
  final VoidCallback toDoulaAppPage4;

  DoulaAppPage3(this.currentUser, this.updateDoula, this.toDoulaAppPage4)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDoulaAppPage4 != null);

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

  TextEditingController _birthsNeeded;

  List<bool> selectedCert = [false, true];
  List<bool> selectedProgress = [true, false];
  String dropdownValue = "";

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDoulaAppPage4 = widget.toDoulaAppPage4;
    _birthsNeeded = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Doula Application'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
                'Certification Status',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['emoryBlue'],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Container(
                width: 250,
                child: LinearProgressIndicator(
                  backgroundColor: themeColors['skyBlue'],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                  value: 0.6,
                ),
              ),
              Text(
                'Are you a certified doula?',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              ToggleButtons(
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
              Text(
                'Are you working towards becoming a \ncertified doula?',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              ToggleButtons(
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
              Row(
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
                          items: <String>['', 'DONA', 'CAPPA', 'ICEA', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
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
              Container(
                width: 205.0,
                child: TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText:
                        'Number of documented births needed until you are certified',
                  ),
                  controller: _birthsNeeded,
                ),
              ),
              Row(children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: themeColors['mediumBlue'])),
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
                RaisedButton(
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
                    updateDoula(
                        currentUser, isCertified, inProgress, program, births);

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
              ]),
            ])));
  }
}

class DoulaAppPage3Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          DoulaAppPage3(vm.currentUser, vm.updateDoula, vm.toDoulaAppPage4),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(Doula, bool, bool, String, int) updateDoula;
  VoidCallback toDoulaAppPage4;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppPage4});

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
            dispatch(NavigateAction.pushNamed("/doulaAppPage4")));
  }
}
