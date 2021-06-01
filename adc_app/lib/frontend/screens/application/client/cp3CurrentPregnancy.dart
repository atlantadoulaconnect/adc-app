import 'package:adc_app/backend/actions/common.dart';

import '../../common.dart';

class Cp3CurrentPregnancy extends StatefulWidget {
  final Client currentUser;
  final void Function(String, String, String, bool, bool) updateClient;
  final VoidCallback toCp4PreviousBirth;
  final void Function(bool) cancelApplication;

  Cp3CurrentPregnancy(this.currentUser, this.updateClient,
      this.toCp4PreviousBirth, this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toCp4PreviousBirth != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return Cp3CurrentPregnancyState();
  }
}

class Cp3CurrentPregnancyState extends State<Cp3CurrentPregnancy> {
  final GlobalKey<FormState> _c3formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(String, String, String, bool, bool) updateClient;
  VoidCallback toCp4PreviousBirth;
  void Function(bool) cancelApplication;

  TextEditingController _dueDateCtrl;
  TextEditingController otherLocCtrl;

  //drop down list
  List<DropdownMenuItem<String>> birthType;
  List<String> birthTypes = ["singleton", "twins", "triplets", "more"];
  String selectedBirthType;

  List<DropdownMenuItem<String>> birthLocation;
  List<String> locations = [
    "Grady",
    "Emory Decatur",
    "Northside",
    "A Birthing Center",
    "At Home",
    "No plans",
    "Other"
  ];

  String selectedBirthLocation;
  int epiduralValue;
  int cSectionValue;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toCp4PreviousBirth = widget.toCp4PreviousBirth;

    _dueDateCtrl = TextEditingController();
    _dueDateCtrl..text = currentUser.dueDate;

    otherLocCtrl = TextEditingController();

    loadData();
    initialPlaceholders();

    super.initState();
  }

  void saveValidInputs() {
    final form = _c3formKey.currentState;
    form.save();

    String dueDate = _dueDateCtrl.text.toString().trim();

    updateClient(
        (dueDate.isEmpty ? null : dueDate),
        selectedBirthLocation == locations[6]
            ? otherLocCtrl.text.toString().trim()
            : selectedBirthLocation,
        selectedBirthType,
        epiduralValue == 1,
        cSectionValue == 1);
  }

  Future<bool> _onBackPressed() {
    saveValidInputs();
    return Future<bool>.value(true);
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
    switch (currentUser.birthType) {
      case "singleton":
        {
          selectedBirthType = birthTypes[0];
        }
        break;
      case "twins":
        {
          selectedBirthType = birthTypes[1];
        }
        break;
      case "triplets":
        {
          selectedBirthType = birthTypes[2];
        }
        break;
      case "more":
        {
          selectedBirthType = birthTypes[3];
        }
        break;
      default:
        {
          selectedBirthType = null;
        }
    }

    switch (currentUser.birthLocation) {
      case "Grady":
        {
          selectedBirthLocation = locations[0];
        }
        break;
      case "Emory Decatur":
        {
          selectedBirthLocation = locations[1];
        }
        break;
      case "Northside":
        {
          selectedBirthLocation = locations[2];
        }
        break;
      case "A Birthing Center":
        {
          selectedBirthLocation = locations[3];
        }
        break;
      case "At Home":
        {
          selectedBirthLocation = locations[4];
        }
        break;
      case "No plans":
        {
          selectedBirthLocation = locations[5];
        }
        break;
      case "Other":
        {
          selectedBirthLocation = locations[6];
        }
        break;
      default:
        {
          if (currentUser.birthLocation != null) {
            // location doesn't match the dropdowns, was a custom input
            selectedBirthLocation = locations[6];
            otherLocCtrl..text = currentUser.birthLocation;
          } else {
            selectedBirthLocation = null;
          }
        }
        break;
    }

    epiduralValue =
        currentUser.epidural == null || currentUser.epidural ? 1 : 2;
    cSectionValue =
        currentUser.cesarean == null || currentUser.cesarean ? 1 : 2;
  }

  void loadData() {
    birthType = [];
    birthType.add(new DropdownMenuItem(
      child: new Text('Singleton'),
      value: birthTypes[0],
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('Twins'),
      value: birthTypes[1],
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('Triplets'),
      value: birthTypes[2],
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('4 or More'),
      value: birthTypes[3],
    ));

    birthLocation = [];
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Grady'),
      value: locations[0],
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Emory Decatur'),
      value: locations[1],
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Northside'),
      value: locations[2],
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('A Birthing Center'),
      value: locations[3],
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('At Home'),
      value: locations[4],
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('No plans'),
      value: locations[5],
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Other (please specify below)'),
      value: locations[6],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Request a Doula"),
            ),
            body: Center(
                child: Form(
                    key: _c3formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: ListView(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Current Pregnancy Details',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: themeColors['emoryBlue'],
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      // progress bar
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 250,
                              child: LinearProgressIndicator(
                                  backgroundColor: themeColors['skyBlue'],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      themeColors['mediumBlue']),
                                  value: 0.4))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 300.0,
                          child: TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Due Date (MM/DD/YYYY)',
                                prefixIcon: Icon(Icons.cake),
                                suffixIcon: Icon(Icons.calendar_today)),
                            controller: _dueDateCtrl,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your due date.";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Select your planned birth location:',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // drop down menu for birth location
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              value: selectedBirthLocation,
                              items: birthLocation,
                              hint: new Text('Birth Location'),
                              isExpanded: true,
                              onChanged: (value) {
                                selectedBirthLocation = value;
                                setState(() {
                                  selectedBirthLocation = value;
                                });
                              },
                            ),
                          )),
                      Visibility(
                        visible: selectedBirthLocation == locations[6],
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
                              controller: otherLocCtrl,
                              validator: nameValidator,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Select your birth type:',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // drop down menu for birth type
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              value: selectedBirthType,
                              items: birthType,
                              hint: new Text('Birth Type'),
                              isExpanded: true,
                              onChanged: (value) {
                                selectedBirthType = value;
                                setState(() {
//                          if (selectedBirthCount == '0') {
//
//                          }
                                });
                              },
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Are you planning on having an epidural?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: epiduralValue,
                              onChanged: (T) {
                                setState(() {
                                  epiduralValue = T;
                                });
                              },
                            ),
                            Text('Yes'),
                            Radio(
                              value: 2,
                              groupValue: epiduralValue,
                              onChanged: (T) {
                                setState(() {
                                  epiduralValue = T;
                                });
                              },
                            ),
                            Text('No'),
                          ]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Are you expecting to have a cesarean section (C-Section)?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: cSectionValue,
                              onChanged: (T) {
                                setState(() {
                                  cSectionValue = T;
                                });
                              },
                            ),
                            Text('Yes'),
                            Radio(
                              value: 2,
                              groupValue: cSectionValue,
                              onChanged: (T) {
                                setState(() {
                                  cSectionValue = T;
                                });
                              },
                            ),
                            Text('No'),
                          ]),
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
                                final form = _c3formKey.currentState;
                                if (form.validate()) {
                                  form.save();

                                  updateClient(
                                      _dueDateCtrl.text.toString().trim(),
                                      selectedBirthLocation == locations[6]
                                          ? otherLocCtrl.text.toString().trim()
                                          : selectedBirthLocation,
                                      selectedBirthType,
                                      epiduralValue == 1,
                                      cSectionValue == 1);

                                  toCp4PreviousBirth();
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
                          ])
                    ])))));
  }
}

class Cp3CurrentPregnancyConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => Cp3CurrentPregnancy(
          vm.currentUser,
          vm.updateClient,
          vm.toCp4PreviousBirth,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(String, String, String, bool, bool) updateClient;
  VoidCallback toCp4PreviousBirth;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toCp4PreviousBirth,
      @required this.cancelApplication})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      toCp4PreviousBirth: () =>
          dispatch(NavigateAction.pushNamed("/cp4PreviousBirth")),
      updateClient: (String dueDate, String birthLocation, String birthType,
              bool epidural, bool cesarean) =>
          dispatch(UpdateClientUserAction(
              dueDate: dueDate,
              birthLocation: birthLocation,
              birthType: birthType,
              epidural: epidural,
              cesarean: cesarean)),
      cancelApplication: (bool confirmed) {
        dispatch(NavigateAction.pop());
        if (confirmed) {
          dispatch(CancelApplicationAction());
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        }
      },
      //completePage: (String pageName) =>dispatch(CompletePageAction(pageName))
    );
  }
}