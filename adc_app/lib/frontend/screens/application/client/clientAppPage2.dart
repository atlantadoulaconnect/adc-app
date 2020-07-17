import '../../common.dart';
import '../../../../backend/util/inputValidation.dart';

class ClientAppPage2 extends StatefulWidget {
  final Client currentUser;
  final void Function(List<EmergencyContact>) updateClient;
  final VoidCallback toClientAppPage3;
  final void Function(bool) cancelApplication;
  final void Function(String) completePage;

  ClientAppPage2(this.currentUser, this.updateClient, this.toClientAppPage3,
      this.cancelApplication, this.completePage)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage3 != null &&
            cancelApplication != null &&
            completePage != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage2State();
  }
}

class ClientAppPage2State extends State<ClientAppPage2> {
  final GlobalKey<FormState> _c2formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(List<EmergencyContact>) updateClient;
  VoidCallback toClientAppPage3;
  void Function(bool) cancelApplication;
  void Function(String) completePage;

  TextEditingController _name1Ctrl;
  TextEditingController _relationship1Ctrl;
  TextEditingController _phone1Ctrl;
  TextEditingController _altPhone1Ctrl;

  TextEditingController _name2Ctrl;
  TextEditingController _relationship2Ctrl;
  TextEditingController _phone2Ctrl;
  TextEditingController _altPhone2Ctrl;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage3 = widget.toClientAppPage3;
    cancelApplication = widget.cancelApplication;
    completePage = widget.completePage;

    _name1Ctrl = TextEditingController();
    _relationship1Ctrl = TextEditingController();
    _phone1Ctrl = TextEditingController();
    _altPhone1Ctrl = TextEditingController();

    _name2Ctrl = TextEditingController();
    _relationship2Ctrl = TextEditingController();
    _phone2Ctrl = TextEditingController();
    _altPhone2Ctrl = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _name1Ctrl.dispose();
    _relationship1Ctrl.dispose();
    _phone1Ctrl.dispose();
    _altPhone1Ctrl.dispose();

    _name2Ctrl.dispose();
    _relationship2Ctrl.dispose();
    _phone2Ctrl.dispose();
    _altPhone2Ctrl.dispose();

    super.dispose();
  }

  // index: index of List<EmergencyContacts>
  // value: type of placeholder (name, relationship)
  dynamic emgContactsPlaceholder(int index, String value) {
    if (currentUser.emergencyContacts != null &&
        currentUser.emergencyContacts.length > index) {
      // emergency contact exists for this index
      switch (value) {
        case "name":
          {
            return currentUser.emergencyContacts[index].name;
          }
          break;
        case "relationship":
          {
            return currentUser.emergencyContacts[index].relationship;
          }
          break;
        default:
          {
            // only other option is phone with format phoneX where x = index in list
            List<Phone> phones = currentUser.emergencyContacts[index].phones;
            int phoneIndex = int.parse(value.substring(value.length - 1));
            if (phones != null && phones.length > phoneIndex) {
              return currentUser
                  .emergencyContacts[index].phones[phoneIndex].number;
            }
            return null;
          }
          break;
      }
    }
    return null;
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

  //void saveValidInputs {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Request a Doula")),
        drawer: Menu(),
        body: Center(
            child: Form(
                key: _c2formKey,
                autovalidate: false,
                child: ListView(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Emergency Contacts',
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
                        value: 0.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Emergency Contact 1',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                          autocorrect: false,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name of First Contact',
                            prefixIcon: Icon(Icons.person),
                          ),
                          controller: _name1Ctrl
                            ..text = emgContactsPlaceholder(0, "name"),
                          validator: nameValidator),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        autocorrect: false,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Relationship',
                          prefixIcon: Icon(Icons.people),
                        ),
                        controller: _relationship1Ctrl
                          ..text = emgContactsPlaceholder(0, "relationship"),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please enter how this contact is related to you.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        controller: _phone1Ctrl
                          ..text = emgContactsPlaceholder(0, "phone0"),
                        validator: phoneValidator,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone 2 (Optional)',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        controller: _altPhone1Ctrl
                          ..text = emgContactsPlaceholder(0, "phone1"),
                        validator: altPhoneValidator,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Emergency Contact 2',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        autocorrect: false,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name of Second Contact',
                          prefixIcon: Icon(Icons.person),
                        ),
                        controller: _name2Ctrl
                          ..text = emgContactsPlaceholder(1, "name"),
                        validator: nameValidator,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        autocorrect: false,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Relationship',
                          prefixIcon: Icon(Icons.people),
                        ),
                        controller: _relationship2Ctrl
                          ..text = emgContactsPlaceholder(1, "relationship"),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please enter how this contact is related to you.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        controller: _phone2Ctrl
                          ..text = emgContactsPlaceholder(1, "phone0"),
                        validator: phoneValidator,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone 2 (Optional)',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          controller: _altPhone2Ctrl
                            ..text = emgContactsPlaceholder(1, "phone1"),
                          validator: altPhoneValidator),
                    ),
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
                            // save only the valid inputs
                            final form = _c2formKey.currentState;
                            form.save();

                            // EC1 controllers
                            String ec1Name = _name1Ctrl.text.toString().trim();
                            String ec1Rel =
                                _relationship1Ctrl.text.toString().trim();
                            String ec1Phone1 =
                                _phone1Ctrl.text.toString().trim();
                            String ec1Phone2 =
                                _altPhone1Ctrl.text.toString().trim();

                            List<EmergencyContact> ecs = List();
                            List<Phone> ec1Phones = List();

                            // validate phone entries as "not empty" and "legit US numbers"
                            if (ec1Phone1.isNotEmpty &&
                                phoneValidator(ec1Phone1) == null) {
                              ec1Phones.add(Phone(ec1Phone1, true));
                            }

                            if (ec1Phone2.isNotEmpty &&
                                phoneValidator(ec1Phone2) == null) {
                              ec1Phones.add(Phone(ec1Phone2, false));
                            }

                            // save values for EC 1
                            EmergencyContact ec1 = EmergencyContact.empty();
                            // null value from validator means input is legit
                            ec1.name =
                                nameValidator(ec1Name) == null ? ec1Name : null;
                            ec1.relationship = ec1Rel.isEmpty ? null : ec1Rel;
                            ec1.phones =
                                ec1Phones.length > 0 ? ec1Phones : null;

                            ecs.add(ec1);

                            // EC2 controllers

                            String ec2Name = _name2Ctrl.text.toString().trim();
                            String ec2Rel =
                                _relationship2Ctrl.text.toString().trim();
                            String ec2Phone1 =
                                _phone2Ctrl.text.toString().trim();
                            String ec2Phone2 =
                                _altPhone2Ctrl.text.toString().trim();

                            List<Phone> ec2Phones = List();

                            // validate phone entries as "not empty" and "legit US numbers"
                            if (ec2Phone1.isNotEmpty &&
                                phoneValidator(ec2Phone1) == null) {
                              ec2Phones.add(Phone(ec2Phone1, true));
                            }

                            if (ec2Phone2.isNotEmpty &&
                                phoneValidator(ec2Phone2) == null) {
                              ec2Phones.add(Phone(ec2Phone2, false));
                            }

                            // save values for EC 2
                            EmergencyContact ec2 = EmergencyContact.empty();

                            ec2.name =
                                nameValidator(ec2Name) == null ? ec2Name : null;
                            ec2.relationship = ec2Rel.isEmpty ? null : ec2Rel;
                            ec2.phones =
                                ec2Phones.length > 0 ? ec2Phones : null;

                            ecs.add(ec2);

                            // change currentUser in appstate
                            updateClient(ecs);

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
                            color: themeColors['yellow'],
                            textColor: Colors.black,
                            padding: EdgeInsets.all(15.0),
                            splashColor: themeColors['yellow'],
                            child: Text(
                              "NEXT",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            onPressed: () {
                              final form = _c2formKey.currentState;
                              if (form.validate()) {
                                form.save();

                                List<Phone> ec1Phones = List();
                                ec1Phones.add(Phone(
                                    _phone1Ctrl.text.toString().trim(), true));
                                if (_altPhone1Ctrl.text.isNotEmpty) {
                                  ec1Phones.add(Phone(
                                      _altPhone1Ctrl.text.toString().trim(),
                                      false));
                                }

                                List<Phone> ec2Phones = List();
                                ec2Phones.add(Phone(
                                    _phone2Ctrl.text.toString().trim(), true));
                                if (_altPhone2Ctrl.text.isNotEmpty) {
                                  ec2Phones.add(Phone(
                                      _altPhone2Ctrl.text.toString().trim(),
                                      false));
                                }

                                EmergencyContact ec1 = EmergencyContact(
                                    _name1Ctrl.text.toString().trim(),
                                    _relationship1Ctrl.text.toString().trim(),
                                    ec1Phones);
                                EmergencyContact ec2 = EmergencyContact(
                                    _name2Ctrl.text.toString().trim(),
                                    _relationship2Ctrl.text.toString().trim(),
                                    ec2Phones);

                                List<EmergencyContact> ecs = List();
                                ecs.add(ec1);
                                ecs.add(ec2);

                                updateClient(ecs);
                                completePage("clientAppPage2");
                                toClientAppPage3();
                              }
                            }),
                      ]),
                ]))));
  }
}

class ClientAppPage2Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => ClientAppPage2(
          vm.currentUser,
          vm.updateClient,
          vm.toClientAppPage3,
          vm.cancelApplication,
          vm.completePage),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(List<EmergencyContact>) updateClient;
  VoidCallback toClientAppPage3;
  void Function(bool) cancelApplication;
  void Function(String) completePage;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage3,
      @required this.cancelApplication,
      @required this.completePage})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppPage3: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage3")),
        updateClient: (List<EmergencyContact> contacts) =>
            dispatch(UpdateClientUserAction(emergencyContacts: contacts)),
        cancelApplication: (bool confirmed) {
          dispatch(NavigateAction.pop());
          if (confirmed) {
            dispatch(CancelApplicationAction());
            dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          }
        },
        completePage: (String pageName) =>
            dispatch(CompletePageAction(pageName)));
  }
}
