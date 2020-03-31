import '../../common.dart';
import '../../../../backend/util/inputValidation.dart';

class ClientAppPage1 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, String, String, List<Phone>) updateClient;
  final VoidCallback toClientAppPage2;

  ClientAppPage1(this.currentUser, this.updateClient, this.toClientAppPage2)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage2 != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage1State();
  }
}

class ClientAppPage1State extends State<ClientAppPage1> {
  final GlobalKey<FormState> _c1formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, String, String, List<Phone>) updateClient;
  VoidCallback toClientAppPage2;

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
        appBar: AppBar(title: Text("Request a Doula")),
        drawer: Menu(),
        body: Center(
            child: Form(
          key: _c1formKey,
          autovalidate: false,
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
                      padding: EdgeInsets.only(
                        right: 10.0,
                      ),
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
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.phone),
                    ),
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
                            side: BorderSide(color: themeColors['mediumBlue'])),
                        onPressed: () {
                          // inputted information is lost when previous is pressed
                          // this should take them home
                          // TODO nav pop until client-specific home
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
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: themeColors['yellow'])),
                        onPressed: () {
                          // dialog to confirm cancellation
                          // if yes, dispatch CancelApplication
                          // navigate to home
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
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: themeColors['yellow'])),
                        onPressed: () {
                          final form = _c1formKey.currentState;
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

                            updateClient(
                                currentUser, displayName, birthday, phones);

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
        )));
  }
}

class ClientAppPage1Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          ClientAppPage1(vm.currentUser, vm.updateClient, vm.toClientAppPage2),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, String, String, List<Phone>) updateClient;
  VoidCallback toClientAppPage2;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage2})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppPage2: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage2")),
        updateClient:
            (Client user, String name, String bday, List<Phone> phones) =>
                dispatch(UpdateClientUserAction(user,
                    name: name, phones: phones, bday: bday)));
  }
}
