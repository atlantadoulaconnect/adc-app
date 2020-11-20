import 'package:adc_app/backend/actions/common.dart';

import '../../common.dart';

class ClientAppPage4 extends StatefulWidget {
  final Client currentUser;
  final void Function(int, bool, bool, List<String>, bool) updateClient;
  final VoidCallback toClientAppPage5;
  final void Function(bool) cancelApplication;

  ClientAppPage4(this.currentUser, this.updateClient, this.toClientAppPage5,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage5 != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage4State();
  }
}

class ClientAppPage4State extends State<ClientAppPage4> {
  final GlobalKey<FormState> _c4formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(int, bool, bool, List<String>, bool) updateClient;
  VoidCallback toClientAppPage5;
  void Function(bool) cancelApplication;

  List<DropdownMenuItem<String>> birthCount;
  List<String> counts = ["0", "1", "2", "3", "4"];
  String selectedBirthCount;

  int pretermValue;
  int previousTwinsOrTriplets;
  int lowBirthWeightValue = 1;
  bool vaginalBirth = false, cesarean = false, vbac = false;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage5 = widget.toClientAppPage5;
    cancelApplication = widget.cancelApplication;

    print(
        "PREV BIRTHS. initState(). currentUser preterm: ${currentUser.preterm}");

    loadData();
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
    selectedBirthCount =
        currentUser.liveBirths != null ? counts[currentUser.liveBirths] : null;
    pretermValue = currentUser.preterm == null || !currentUser.preterm ? 2 : 1;
    lowBirthWeightValue =
        currentUser.lowWeight == null || !currentUser.lowWeight ? 2 : 1;

    previousTwinsOrTriplets =
        currentUser.multiples != null && currentUser.multiples ? 1 : 2;

    if (currentUser.deliveryTypes != null &&
        currentUser.deliveryTypes.isNotEmpty) {
      vaginalBirth = currentUser.deliveryTypes.contains("vaginal");
      cesarean = currentUser.deliveryTypes.contains("cesarean");
      vbac = currentUser.deliveryTypes.contains("vbac");
    }
  }

  void loadData() {
    birthCount = [];
    birthCount.add(new DropdownMenuItem(
      child: new Text('0'),
      value: '0',
    ));
    birthCount.add(new DropdownMenuItem(
      child: new Text('1'),
      value: '1',
    ));
    birthCount.add(new DropdownMenuItem(
      child: new Text('2'),
      value: '2',
    ));
    birthCount.add(new DropdownMenuItem(
      child: new Text('3'),
      value: '3',
    ));
    birthCount.add(new DropdownMenuItem(
      child: new Text('4'),
      value: '4',
    ));
  }

  void saveValidInputs() {
    final form = _c4formKey.currentState;
    form.save();

    List<String> deliveries = List();
    if (vaginalBirth) {
      deliveries.add("vaginal");
    }
    if (cesarean) {
      deliveries.add("cesarean");
    }
    if (vbac) {
      deliveries.add("vbac");
    }

    int births = selectedBirthCount == null ? 0 : int.parse(selectedBirthCount);

    if (births == 0) {
      print("NO BIRTHS");
      updateClient(births, null, null, null, null);
    } else {
      updateClient(
          births,
          pretermValue == 1,
          lowBirthWeightValue == 1,
          (deliveries.isEmpty ? null : deliveries),
          previousTwinsOrTriplets == 1);
    }
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
                  key: _c4formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Previous Birth Details',
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
                            value: 0.6,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Number of previous live births:',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // drop down menu for births
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              value: selectedBirthCount,
                              items: birthCount,
                              hint: new Text('Previous Births'),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  selectedBirthCount = value;
                                });
                              },
                            ),
                          )),

                      Visibility(
                        visible: int.parse(selectedBirthCount) > 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Were any of your previous life births: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      //preterm
                      Visibility(
                        visible: int.parse(selectedBirthCount) > 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 8, 0),
                          child: Text(
                            'Preterm (< 37 weeks of pregnancy): ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: int.parse(selectedBirthCount) > 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                            child: Row(children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: pretermValue,
                                onChanged: (T) {
                                  setState(() {
                                    pretermValue = T;
                                  });
                                },
                              ),
                              Text('Yes'),
                              Radio(
                                value: 2,
                                groupValue: pretermValue,
                                onChanged: (T) {
                                  setState(() {
                                    pretermValue = T;
                                  });
                                },
                              ),
                              Text('No'),
                            ]),
                          )),

                      //low birth weight
                      Visibility(
                        visible: int.parse(selectedBirthCount) > 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 8, 0),
                          child: Text(
                            'Low Birth Weight (< 5 lbs. 8 oz. or 2,500g):',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: int.parse(selectedBirthCount) > 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                            child: Row(children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: lowBirthWeightValue,
                                onChanged: (T) {
                                  setState(() {
                                    lowBirthWeightValue = T;
                                  });
                                },
                              ),
                              Text('Yes'),
                              Radio(
                                value: 2,
                                groupValue: lowBirthWeightValue,
                                onChanged: (T) {
                                  setState(() {
                                    lowBirthWeightValue = T;
                                  });
                                },
                              ),
                              Text('No'),
                            ]),
                          )),

                      //Previous Birth Types
                      Visibility(
                        visible: int.parse(selectedBirthCount) > 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Previous Birth Types (check all that apply): ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      Visibility(
                        visible: int.parse(selectedBirthCount) > 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Vaginal Birth"),
                                  Checkbox(
                                    value: vaginalBirth,
                                    onChanged: (bool value) {
                                      setState(() {
                                        vaginalBirth = value;
                                      });
                                    },
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Cesaerean"),
                                  Checkbox(
                                    value: cesarean,
                                    onChanged: (bool value) {
                                      setState(() {
                                        cesarean = value;
                                      });
                                    },
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("VBAC"),
                                  Checkbox(
                                    value: vbac,
                                    onChanged: (bool value) {
                                      setState(() {
                                        vbac = value;
                                      });
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      //previous twins or triplets
//                      Padding(
//                        padding: const EdgeInsets.all(1.0),
//                        child: Text(
//                          'Please select how you previously gave birth',
//                          style: TextStyle(
//                            fontSize: 16,
//                            color: themeColors["red"],
//                          ),
//                          textAlign: TextAlign.center,
//                        ),
//                      ),
                      Visibility(
                        visible: int.parse(selectedBirthCount) > 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'Have you previously had twins or triplets? ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: int.parse(selectedBirthCount) > 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                            child: Row(children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: previousTwinsOrTriplets,
                                onChanged: (T) {
                                  setState(() {
                                    previousTwinsOrTriplets = T;
                                  });
                                },
                              ),
                              Text('Yes'),
                              Radio(
                                value: 2,
                                groupValue: previousTwinsOrTriplets,
                                onChanged: (T) {
                                  setState(() {
                                    previousTwinsOrTriplets = T;
                                  });
                                },
                              ),
                              Text('No'),
                            ]),
                          )),
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
                                final form = _c4formKey.currentState;
                                if (form.validate()) {
                                  form.save();

                                  List<String> deliveries = List();
                                  if (vaginalBirth) {
                                    deliveries.add("vaginal");
                                  }
                                  if (cesarean) {
                                    deliveries.add("cesarean");
                                  }
                                  if (vbac) {
                                    deliveries.add("vbac");
                                  }

                                  int births = int.parse(selectedBirthCount);

                                  if (births == 0) {
                                    updateClient(
                                        births, null, null, null, null);
                                  } else {
                                    updateClient(
                                        births,
                                        pretermValue == 1,
                                        lowBirthWeightValue == 1,
                                        deliveries,
                                        previousTwinsOrTriplets == 1);
                                  }

                                  toClientAppPage5();
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
                    ],
                  )),
            )));
  }
}

class ClientAppPage4Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => ClientAppPage4(
          vm.currentUser,
          vm.updateClient,
          vm.toClientAppPage5,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(int, bool, bool, List<String>, bool) updateClient;
  VoidCallback toClientAppPage5;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage5,
      @required this.cancelApplication})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      toClientAppPage5: () =>
          dispatch(NavigateAction.pushNamed("/clientAppPage5")),
      updateClient: (int liveBirths, bool preterm, bool lowWeight,
              List<String> deliveryTypes, bool multiples) =>
          dispatch(UpdateClientUserAction(
              liveBirths: liveBirths,
              preterm: preterm,
              lowWeight: lowWeight,
              deliveryTypes: deliveryTypes,
              multiples: multiples)),
      cancelApplication: (bool confirmed) {
        dispatch(NavigateAction.pop());
        if (confirmed) {
          dispatch(CancelApplicationAction());
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        }
      },
      //completePage: (String pageName) => dispatch(CompletePageAction(pageName))
    );
  }
}
