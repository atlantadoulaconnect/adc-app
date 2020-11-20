import 'dart:ffi';

import 'package:adc_app/backend/actions/common.dart';

import '../../common.dart';
import '../../../../backend/util/inputValidation.dart';

class ClientAppPage1 extends StatefulWidget {
  final Client currentUser;
  final void Function(String, String, List<Phone>) updateClient;
  final VoidCallback toClientAppPage2;
  final void Function(bool) cancelApplication;
  final void Function(String) completePage;

  ClientAppPage1(this.currentUser, this.updateClient, this.toClientAppPage2,
      this.cancelApplication, this.completePage)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage2 != null &&
            cancelApplication != null &&
            completePage != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage1State();
  }
}

class ClientAppPage1State extends State<ClientAppPage1> {
  final GlobalKey<FormState> _c1formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(String, String, List<Phone>) updateClient;
  VoidCallback toClientAppPage2;
  void Function(bool) cancelApplication;
  void Function(String) completePage;

  TextEditingController _firstNameCtrl;
  TextEditingController _lastInitCtrl;
  TextEditingController _bdayCtrl;
  TextEditingController _phoneCtrl;
  TextEditingController _altPhoneCtrl;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage2 = widget.toClientAppPage2;
    cancelApplication = widget.cancelApplication;
    completePage = widget.completePage;

    _firstNameCtrl = TextEditingController();
    _lastInitCtrl = TextEditingController();
    _bdayCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _altPhoneCtrl = TextEditingController();

    _firstNameCtrl
      ..text = currentUser.name != null ? getFirstName(currentUser.name) : null;

    _lastInitCtrl
      ..text =
          currentUser.name != null ? getLastInitial(currentUser.name) : null;

    _bdayCtrl..text = currentUser.bday;

    _phoneCtrl
      ..text = currentUser.phones != null
          ? (currentUser.phones.length > 0
              ? currentUser.phones[0].number
              : null)
          : null;

    _altPhoneCtrl
      ..text = currentUser.phones != null
          ? (currentUser.phones.length > 1
              ? currentUser.phones[1].number
              : null)
          : null;

    super.initState();
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastInitCtrl.dispose();
    _bdayCtrl.dispose();
    _phoneCtrl.dispose();
    _altPhoneCtrl.dispose();
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

  Future<bool> _onBackPressed() {
    final form = _c1formKey.currentState;
    form.save();

    String firstName = _firstNameCtrl.text.toString().trim();
    String lastInitial = _lastInitCtrl.text.toString().trim();
    String bday = _bdayCtrl.text.toString().trim();
    String primaryPhone = _phoneCtrl.text.toString().trim();
    String altPhone = _altPhoneCtrl.text.toString().trim();

    String nameInput;
    if (nameValidator(firstName) == null) {
      nameInput = "$firstName";
      if (singleLetterValidator(lastInitial) == null) {
        nameInput = "$nameInput $lastInitial.";
      }
    }

    List<Phone> phones = List();
    if (phoneValidator(primaryPhone) == null) {
      phones.add(Phone(primaryPhone, true));
    }
    if (phoneValidator(altPhone) == null) {
      phones.add(Phone(altPhone, false));
    }

    updateClient(nameInput, bdayValidator(bday) == null ? bday : null,
        phones.length > 0 ? phones : null);

    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(title: Text("Request a Doula")),
            drawer: Menu(),
            body: Center(
                child: Form(
              key: _c1formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                    child: Text('Personal Information',
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
                        value: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextFormField(
                              autocorrect: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                                ),
                                labelText: "First Name",
                                hintText: "Jane",
                              ),
                              controller: _firstNameCtrl,
                              validator: nameValidator,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Last Initial",
                              hintText: "D",
                            ),
                            controller: _lastInitCtrl,
                            validator: singleLetterValidator,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Birthday (MM/YYYY)',
                            prefixIcon: Icon(Icons.cake),
                            suffixIcon: Icon(Icons.calendar_today)),
                        controller: _bdayCtrl,
                        validator: bdayValidator,
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
                          labelText: 'Primary Phone',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        // if there's a phone list and that list is not empty then the first element is the initial value
                        controller: _phoneCtrl,
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
                        controller: _altPhoneCtrl,
                        validator: altPhoneValidator,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
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
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: themeColors['yellow'])),
                            onPressed: () {
                              final form = _c1formKey.currentState;
                              if (form.validate()) {
                                form.save();

                                String displayName =
                                    "${_firstNameCtrl.text.toString().trim()} ${_lastInitCtrl.text.toString().trim()}.";
                                String birthday =
                                    _bdayCtrl.text.toString().trim();
                                List<Phone> phones = List();
                                phones.add(Phone(
                                    _phoneCtrl.text.toString().trim(), true));
                                if (_altPhoneCtrl.text.isNotEmpty) {
                                  phones.add(Phone(
                                      _altPhoneCtrl.text.toString().trim(),
                                      false));
                                }

                                updateClient(displayName, birthday, phones);
                                completePage("clientAppPage1");
                                toClientAppPage2();
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
                        ]),
                  ),
                ],
              ),
            ))));
  }
}

class ClientAppPage1Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => ClientAppPage1(
          vm.currentUser,
          vm.updateClient,
          vm.toClientAppPage2,
          vm.cancelApplication,
          vm.completePage),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(String, String, List<Phone>) updateClient;
  VoidCallback toClientAppPage2;
  void Function(bool) cancelApplication;
  void Function(String) completePage;

  ViewModel.build({
    @required this.currentUser,
    @required this.updateClient,
    @required this.toClientAppPage2,
    @required this.cancelApplication,
    @required this.completePage,
  }) : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppPage2: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage2")),
        updateClient: (String name, String bday, List<Phone> phones) =>
            dispatch(
                UpdateClientUserAction(name: name, phones: phones, bday: bday)),
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
