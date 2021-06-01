import '../../common.dart';
import '../../../../backend/util/inputValidation.dart';

class Dp1PersonalInfo extends StatefulWidget {
  final Doula currentUser;
  final void Function(String, String, List<Phone>) updateDoula;
  final VoidCallback toDp2ShortBio;
  final void Function(bool) cancelApplication;

  Dp1PersonalInfo(this.currentUser, this.updateDoula, this.toDp2ShortBio,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDp2ShortBio != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return Dp1PersonalInfoState();
  }
}

class Dp1PersonalInfoState extends State<Dp1PersonalInfo> {
  final GlobalKey<FormState> _d1formKey = GlobalKey<FormState>();
  Doula currentUser;
  void Function(String, String, List<Phone>) updateDoula;
  VoidCallback toDp2ShortBio;
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
    toDp2ShortBio = widget.toDp2ShortBio;
    cancelApplication = widget.cancelApplication;

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
    final form = _d1formKey.currentState;
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

    updateDoula(nameInput, bdayValidator(bday) == null ? bday : null,
        phones.length > 0 ? phones : null);

    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
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
                      autovalidateMode: AutovalidateMode.disabled,
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
                                  controller: _firstNameCtrl,
                                  validator: nameValidator,
                                ),
                              ),
                              Flexible(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Last Initial",
                                    hintText: "D",
                                  ),
                                  controller: _lastInitCtrl,
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
                            controller: _bdayCtrl,
                            validator: bdayValidator,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Phone", hintText: "4045553333"),
                            keyboardType: TextInputType.number,
                            controller: _phoneCtrl,
                            validator: phoneValidator,
                          ),
                          TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Alternate Phone",
                                  hintText: "6784447777"),
                              keyboardType: TextInputType.number,
                              controller: _altPhoneCtrl,
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
                                              _altPhoneCtrl.text
                                                  .toString()
                                                  .trim(),
                                              false));
                                        }

                                        updateDoula(
                                            displayName, birthday, phones);

                                        toDp2ShortBio();
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
            )));
  }
}

class Dp1PersonalInfoConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => Dp1PersonalInfo(
          vm.currentUser,
          vm.updateDoula,
          vm.toDp2ShortBio,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(String, String, List<Phone>) updateDoula;
  VoidCallback toDp2ShortBio;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDp2ShortBio,
      @required this.cancelApplication});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toDp2ShortBio: () => dispatch(NavigateAction.pushNamed("/dp2ShortBio")),
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
