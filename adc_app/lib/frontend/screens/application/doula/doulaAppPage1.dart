import '../../common.dart';
import '../../../../backend/util/inputValidation.dart';

class DoulaAppPage1 extends StatefulWidget {
  final Doula currentUser;
  final void Function(String, String, List<Phone>) updateDoula;
  final VoidCallback toDoulaAppPage2;
  final void Function(bool) cancelApplication;

  DoulaAppPage1(this.currentUser, this.updateDoula, this.toDoulaAppPage2,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDoulaAppPage2 != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return DoulaAppPage1State();
  }
}

class DoulaAppPage1State extends State<DoulaAppPage1> {
  final GlobalKey<FormState> _d1formKey = GlobalKey<FormState>();
  Doula currentUser;
  void Function(String, String, List<Phone>) updateDoula;
  VoidCallback toDoulaAppPage2;
  void Function(bool) cancelApplication;

  TextEditingController _firstNameCtrl;
  TextEditingController _lastInitCtrl;
  TextEditingController _bdayCtrl;
  TextEditingController _phoneCtrl;
  TextEditingController _altPhoneCtrl;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDoulaAppPage2 = widget.toDoulaAppPage2;
    cancelApplication = widget.cancelApplication;

    _firstNameCtrl = TextEditingController();
    _lastInitCtrl = TextEditingController();
    _bdayCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _altPhoneCtrl = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Doula Application"),
        ),
        body: Container(
          child: ListView(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Personal Information',
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
                    value: 0.2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _d1formKey,
                  autovalidate: false,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "First Name",
                                hintText: "Jane",
                              ),
                              controller: _firstNameCtrl
                                ..text = currentUser.name != null
                                    ? getFirstName(currentUser.name)
                                    : null,
                              validator: nameValidator,
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Last Initial",
                                hintText: "D",
                              ),
                              controller: _lastInitCtrl
                                ..text = currentUser.name != null
                                    ? getLastInitial(currentUser.name)
                                    : null,
                              validator: singleLetterValidator,
                            ),
                          )
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Birthday",
                          hintText: "(MM/YYYY)",
                        ),
                        keyboardType: TextInputType.datetime,
                        controller: _bdayCtrl..text = currentUser.bday,
                        validator: bdayValidator,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Phone", hintText: "4045553333"),
                        keyboardType: TextInputType.number,
                        controller: _phoneCtrl
                          ..text = currentUser.phones != null
                              ? (currentUser.phones.length > 0
                                  ? currentUser.phones[0].number
                                  : null)
                              : null,
                        validator: phoneValidator,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: "Alternate Phone",
                              hintText: "6784447777"),
                          keyboardType: TextInputType.number,
                          controller: _altPhoneCtrl
                            ..text = currentUser.phones != null
                                ? (currentUser.phones.length > 1
                                    ? currentUser.phones[1].number
                                    : null)
                                : null,
                          validator: (val) {
                            if (val.isNotEmpty) {
                              return phoneValidator(val);
                            }
                            return null;
                          }),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
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
                                  final form = _d1formKey.currentState;
                                  if (form.validate()) {
                                    form.save();

                                    String displayName =
                                        "${_firstNameCtrl.text.toString().trim()} ${_lastInitCtrl.text.toString().trim()}.";
                                    String birthday =
                                        _bdayCtrl.text.toString().trim();
                                    List<Phone> phones = List();
                                    phones.add(Phone(
                                        _phoneCtrl.text.toString().trim(),
                                        true));
                                    if (_altPhoneCtrl.text.isNotEmpty) {
                                      phones.add(Phone(
                                          _altPhoneCtrl.text.toString().trim(),
                                          false));
                                    }

                                    updateDoula(displayName, birthday, phones);

                                    toDoulaAppPage2();
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class DoulaAppPage1Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => DoulaAppPage1(
          vm.currentUser,
          vm.updateDoula,
          vm.toDoulaAppPage2,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(String, String, List<Phone>) updateDoula;
  VoidCallback toDoulaAppPage2;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppPage2,
      @required this.cancelApplication});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toDoulaAppPage2: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppPage2")),
        updateDoula: (
          String name,
          String bday,
          List<Phone> phones,
        ) =>
            dispatch(UpdateDoulaUserAction(
              name: name,
              phones: phones,
              bday: bday,
            )),
        cancelApplication: (bool confirmed) {
          dispatch(NavigateAction.pop());
          if (confirmed) {
            dispatch(CancelApplicationAction());
            dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          }
        });
  }
}
