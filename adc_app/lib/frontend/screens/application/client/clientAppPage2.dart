import 'package:adc_app/backend/actions/updateApplicationAction.dart';

import '../../common.dart';
import '../../../../backend/util/inputValidation.dart';

class ClientAppPage2 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, List<EmergencyContact>) updateClient;
  final VoidCallback toClientAppPage3;
  final void Function(bool) cancelApplication;

  ClientAppPage2(this.currentUser, this.updateClient, this.toClientAppPage3,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage3 != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage2State();
  }
}

class ClientAppPage2State extends State<ClientAppPage2> {
  final GlobalKey<FormState> _c2formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, List<EmergencyContact>) updateClient;
  VoidCallback toClientAppPage3;
  void Function(bool) cancelApplication;

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
                          controller: _name1Ctrl,
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
                        controller: _relationship1Ctrl,
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
                        controller: _phone1Ctrl,
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
                        controller: _altPhone1Ctrl,
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
                        controller: _name2Ctrl,
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
                        controller: _relationship2Ctrl,
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
                        controller: _phone2Ctrl,
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
                          controller: _altPhone2Ctrl,
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

                                updateClient(currentUser, ecs);

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
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, List<EmergencyContact>) updateClient;
  VoidCallback toClientAppPage3;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage3,
      @required this.cancelApplication})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      toClientAppPage3: () =>
          dispatch(NavigateAction.pushNamed("/clientAppPage3")),
      updateClient: (Client user, List<EmergencyContact> contacts) =>
          dispatch(UpdateClientUserAction(user, emergencyContacts: contacts)),
      cancelApplication: (bool confirmed) {
        dispatch(NavigateAction.pop());
        if (confirmed) {
          dispatch(CancelApplicationAction());
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        }
      },
    );
  }
}
