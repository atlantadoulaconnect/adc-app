import 'package:adc_app/backend/actions/common.dart';
import 'package:adc_app/frontend/screens/common.dart';

class Dp3Certification extends StatefulWidget {
  final Doula currentUser;
  final void Function(bool, bool, String, int) updateDoula;
  final VoidCallback toDp4Availability;
  final void Function(bool) cancelApplication;

  Dp3Certification(this.currentUser, this.updateDoula, this.toDp4Availability,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDp4Availability != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return Dp3CertificationState();
  }
}

class Dp3CertificationState extends State<Dp3Certification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Doula currentUser;
  void Function(bool, bool, String, int) updateDoula;
  VoidCallback toDp4Availability;
  void Function(bool) cancelApplication;

  TextEditingController _birthsNeeded;
  TextEditingController _otherProgCtrl;

  List<bool> selectedCert;
  List<bool> selectedProgress;

  List<DropdownMenuItem<String>> certProgram;
  List<String> certPrograms = ["DONA", "CAPPA", "ICEA", "Other"];
  String selectedProgram;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDp4Availability = widget.toDp4Availability;
    cancelApplication = widget.cancelApplication;

    _birthsNeeded = TextEditingController();
    _birthsNeeded
      ..text = currentUser.birthsNeeded != null
          ? "${currentUser.birthsNeeded}"
          : null;

    _otherProgCtrl = TextEditingController();

    initialPlaceholders();

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

  void initialPlaceholders() {
    // toggle buttons
    if (currentUser.certified == null) {
      selectedCert = [false, true];
    } else {
      selectedCert = currentUser.certified ? [true, false] : [false, true];
    }

    if (currentUser.certInProgress == null) {
      selectedProgress = [false, true];
    } else {
      selectedProgress =
          currentUser.certInProgress ? [true, false] : [false, true];
    }

    certProgram = [];
    certProgram.add(new DropdownMenuItem(
      child: new Text('DONA'),
      value: certPrograms[0],
    ));
    certProgram.add(new DropdownMenuItem(
      child: new Text('CAPPA'),
      value: certPrograms[1],
    ));
    certProgram.add(new DropdownMenuItem(
      child: new Text('ICEA'),
      value: certPrograms[2],
    ));
    certProgram.add(new DropdownMenuItem(
      child: new Text('Other'),
      value: certPrograms[3],
    ));

    if (currentUser.certInProgress != null && currentUser.certInProgress) {
      switch (currentUser.certProgram) {
        case "DONA":
          {
            selectedProgram = certPrograms[0];
          }
          break;
        case "CAPPA":
          {
            selectedProgram = certPrograms[1];
          }
          break;
        case "ICEA":
          {
            selectedProgram = certPrograms[2];
          }
          break;
        case "Other":
          {
            selectedProgram = certPrograms[3];
          }
          break;
        default:
          {
            if (currentUser.certProgram != null) {
              selectedProgram = certPrograms[3];
              _otherProgCtrl
                ..text = currentUser.certProgram == "none"
                    ? null
                    : currentUser.certProgram;
            } else {
              selectedProgram = null;
            }
          }
      }
    } else {
      selectedProgram = null;
    }
  }

  void saveValidInputs() {
    final form = _formKey.currentState;
    form.save();

    bool isCertified = selectedCert[0] == true;
    bool inProgress = selectedProgress[0] == true;
    String program;
    String selBirths = _birthsNeeded.text.toString().trim();
    int births;

    if (inProgress) {
      if (selectedProgram == certPrograms[3]) {
        // if other then set program as input from 'other' text box if that's not empty
        String otherProgram = _otherProgCtrl.text.toString().trim();
        program = otherProgram.isEmpty ? "none" : otherProgram;
      } else {
        program = selectedProgram == "" ? "none" : selectedProgram;
      }
      births = int.parse(selBirths.isEmpty ? "0" : selBirths);
    }

    updateDoula(isCertified, inProgress, program, births);
  }

  Future<bool> _onBackPressed() {
    saveValidInputs();
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    print(
        "selected program: ${selectedProgram == null}\ncertProgram: ${certProgram.length}");
    for (DropdownMenuItem d in certProgram) {
      print("${d.value}");
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Doula Application'),
          ),
          body: Center(
              child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
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
                            'Are you enrolled in a certification program?',
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
                        Visibility(
                          visible: selectedProgress[0],
                          child: Padding(
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
                                        child: DropdownButton(
                                          value: selectedProgram,
                                          items: certProgram,
                                          isExpanded: true,
                                          onChanged: (value) {
                                            selectedProgram = value;
                                            setState(() {});
                                          },
                                        )),
                                  ),
                                ]),
                          ),
                        ),
                        Visibility(
                          visible: selectedProgress[0] &&
                              selectedProgram == certPrograms[3],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 200.0,
                              child: TextFormField(
                                autocorrect: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'If other, please specify',
                                ),
                                controller: _otherProgCtrl,
                                validator: nameValidator,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: selectedProgress[0],
                          child: Padding(
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
                        ),
                        Visibility(
                          visible: selectedProgress[0],
                          child: Padding(
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
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
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
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
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
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: themeColors['yellow'])),
                                    onPressed: () {
                                      final form = _formKey.currentState;
                                      if (form.validate()) {
                                        form.save();

                                        bool isCertified =
                                            selectedCert[0] == true;
                                        bool inProgress =
                                            selectedProgress[0] == true;
                                        String program;
                                        String selBirths = _birthsNeeded.text
                                            .toString()
                                            .trim();
                                        int births;

                                        if (inProgress) {
                                          if (selectedProgram ==
                                              certPrograms[3]) {
                                            program = _otherProgCtrl.text
                                                .toString()
                                                .trim();
                                          } else {
                                            program = selectedProgram == ""
                                                ? "none"
                                                : selectedProgram;
                                          }

                                          births = int.parse(selBirths.isEmpty
                                              ? "0"
                                              : selBirths);
                                        }

                                        updateDoula(isCertified, inProgress,
                                            program, births);

                                        toDp4Availability();
                                      }
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
                      ])))),
    );
  }
}

class Dp3CertificationConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => Dp3Certification(
          vm.currentUser,
          vm.updateDoula,
          vm.toDp4Availability,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(bool, bool, String, int) updateDoula;
  VoidCallback toDp4Availability;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDp4Availability,
      @required this.cancelApplication});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        updateDoula: (bool certified, bool inProgress, String program,
                int birthsNeeded) =>
            dispatch(UpdateDoulaUserAction(
                certified: certified,
                certInProgress: inProgress,
                certProgram: program,
                birthsNeeded: birthsNeeded)),
        toDp4Availability: () =>
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
