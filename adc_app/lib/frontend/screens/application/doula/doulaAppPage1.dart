import '../../common.dart';
import '../../../../backend/util/inputValidation.dart';

class DoulaAppPage1 extends StatefulWidget {
  final Doula currentUser;
  final void Function(Doula, String, String, List<Phone>) updateDoula;
  final VoidCallback toDoulaAppPage2;

  DoulaAppPage1(this.currentUser, this.updateDoula, this.toDoulaAppPage2)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDoulaAppPage2 != null);

  @override
  State<StatefulWidget> createState() {
    return DoulaAppPage1State();
  }
}

class DoulaAppPage1State extends State<DoulaAppPage1> {
  final GlobalKey<FormState> _d1formKey = GlobalKey<FormState>();
  Doula currentUser;
  void Function(Doula, String, String, List<Phone>) updateDoula;
  VoidCallback toDoulaAppPage2;

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
                    valueColor:
                        AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
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
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: themeColors['mediumBlue'])),
                            onPressed: () {
                              // inputted information is lost when previous is pressed
                              // this should take them home
                              // TODO nav pop until doula-specific home
                              Navigator.pushNamed(context, '/home');
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
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: themeColors['yellow'])),
                            onPressed: () {
                              final form = _d1formKey.currentState;
                              if (form.validate()) {
                                form.save();

                                String displayName =
                                    "${_firstNameCtrl.text.toString().trim()} ${_lastInitCtrl.text.toString().trim()}.";
                                String birthday = _bdayCtrl.text.toString().trim();
                                List<Phone> phones = List();
                                phones.add(
                                    Phone(_phoneCtrl.text.toString().trim(), true));
                                if (_altPhoneCtrl.text.isNotEmpty) {
                                  phones.add(Phone(
                                      _altPhoneCtrl.text.toString().trim(), false));
                                }

                                updateDoula(
                                    currentUser, displayName, birthday, phones);

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
      builder: (BuildContext context, ViewModel vm) =>
          DoulaAppPage1(vm.currentUser, vm.updateDoula, vm.toDoulaAppPage2),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(Doula, String, String, List<Phone>) updateDoula;
  VoidCallback toDoulaAppPage2;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppPage2});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toDoulaAppPage2: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppPage2")),
        updateDoula: (
          Doula user,
          String name,
          String bday,
          List<Phone> phones,
        ) =>
            dispatch(UpdateDoulaUserAction(
              user,
              name: name,
              phones: phones,
              bday: bday,
            ))
    );
  }
}
