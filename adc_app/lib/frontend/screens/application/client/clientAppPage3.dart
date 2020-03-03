import '../../common.dart';

class ClientAppPage3 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, String, String, String, bool, bool) updateClient;
  final VoidCallback toClientAppPage4;

  ClientAppPage3(this.currentUser, this.updateClient, this.toClientAppPage4)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage4 != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage3State();
  }
}

class ClientAppPage3State extends State<ClientAppPage3> {
  final GlobalKey<FormState> _c3formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, String, String, String, bool, bool) updateClient;
  VoidCallback toClientAppPage4;

  TextEditingController _dueDateCtrl;
  TextEditingController _birthLocCtrl;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage4 = widget.toClientAppPage4;
    _dueDateCtrl = TextEditingController();
    _birthLocCtrl = TextEditingController();
    super.initState();
  }

  //drop down list
  List<DropdownMenuItem<String>> birthType = [];
  String selectedBirthType;

  List<DropdownMenuItem<String>> birthLocation = [];
  String selectedBirthLocation;
  int epiduralValue = 1;
  int cSectionValue = 1;

  void loadData() {
    birthType = [];
    birthType.add(new DropdownMenuItem(
      child: new Text('Singleton'),
      value: 'singleton',
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('Twins'),
      value: 'twins',
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('Triplets'),
      value: 'triplets',
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('4 or More'),
      value: 'more',
    ));

    birthLocation = [];
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Grady'),
      value: 'Grady',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Emory Decatur'),
      value: 'Emory Decatur',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Northside'),
      value: 'Northside',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('A Birthing Center'),
      value: 'A Birthing Center',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('At Home'),
      value: 'At Home',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('No plans'),
      value: 'No plans',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Other (please specify below)'),
      value: 'other',
    ));
  }

  @override
  Widget build(BuildContext context) {
    birthType = [];
    birthLocation = [];
    loadData();

    return Scaffold(
        appBar: AppBar(
          title: Text("Request a Doula"),
        ),
        body: Center(
            child: Form(
                key: _c3formKey,
                autovalidate: false,
                child: ListView(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Current Pregnancy Details',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['emoryBlue'],
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center
                    ),
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
                            setState(() {});
                          },
                        ),
                      )),
                  //if other, please specify
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200.0,
                      child: TextField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'If other, please specify',
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
                      'Are you expecting to have a caesarean section (C-Section)?',
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
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () {
                            final form = _c3formKey.currentState;
                            if (form.validate()) {
                              form.save();

                              // TODO capture and check input from dropdowns. Error messages if nothing is chosen
                              // TODO check other text controller if 'other' is chosen from dropdown

                              updateClient(
                                  currentUser,
                                  _dueDateCtrl.text.toString().trim(),
                                  selectedBirthLocation,
                                  selectedBirthType,
                                  epiduralValue == 1,
                                  cSectionValue == 1);
                            }

                            toClientAppPage4();
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
                ]))));
  }
}

class ClientAppPage3Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          ClientAppPage3(vm.currentUser, vm.updateClient, vm.toClientAppPage4),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, String, String, String, bool, bool) updateClient;
  VoidCallback toClientAppPage4;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage4})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppPage4: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage4")),
        updateClient: (Client user, String dueDate, String birthLocation,
                String birthType, bool epidural, bool cesarean) =>
            dispatch(UpdateClientUserAction(user,
                dueDate: dueDate,
                birthLocation: birthLocation,
                birthType: birthType,
                epidural: epidural,
                cesarean: cesarean)));
  }
}
