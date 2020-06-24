import 'package:adc_app/backend/actions/common.dart';
import 'package:adc_app/backend/util/inputValidation.dart';
import '../common.dart';

// screen where users can change settings related to the TappableChipAttributes

class SettingsScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback toHome;
  final VoidCallback logout;


  SettingsScreen(
      this.currentUser,
      this.toHome,
      this.logout);
//      : assert(currentUser != null && toHome != null && logout != null);

  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<FormState> _settingsKey = GlobalKey<FormState>();

  VoidCallback toHome;

  User currentUser;

  TextEditingController firstNameCtrl;
  TextEditingController phoneNumCtrl;
  TextEditingController dateOfBirthCtrl;
  TextEditingController emailCtrl;
  TextEditingController oldPasswordCtrl;
  TextEditingController newPasswordCtrl;
  TextEditingController confirmPasswordCtrl;
  TextEditingController changeEmailPasswordCtrl;

  //general
  String userName;
  String phone;
  String email;
  String dob;
  bool photoRelease = false;
  bool passwordVisible = false;
  String password;
  String newPassword;
  String confirmPassword;

  bool pushNotification = true;
  bool smsNotification = true;
  bool emailNotification = true;
  bool messagesNotification = true;



  @override
  void initState() {
    toHome = widget.toHome;
    currentUser = widget.currentUser;


    String userType = currentUser != null ? currentUser.userType : 'unlogged';

    if (currentUser != null) {
      userName = currentUser.name != null ? currentUser.name : '';
      phone = currentUser.phones != null
          ? currentUser.phones.toString().trim().substring(1, 11)
          : '';
      email = currentUser.email != null ? currentUser.email : '';
    }


    firstNameCtrl = new TextEditingController(text: userName);
    phoneNumCtrl = new TextEditingController(text: phone);
    dateOfBirthCtrl = new TextEditingController(text: dob);
    emailCtrl = new TextEditingController(text: email);

    oldPasswordCtrl = new TextEditingController();
    newPasswordCtrl = new TextEditingController();
    confirmPasswordCtrl = new TextEditingController();
    changeEmailPasswordCtrl = new TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    //firstNameCtrl.dispose();
    super.dispose();
  }

  confirmPasswordDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Your Password"),
          content: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '*****',
            ),
            controller: oldPasswordCtrl,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Confirm"),
              onPressed: () {
                password = oldPasswordCtrl.text.toString().trim();
                //passwordForEmailChange(true);
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                password = '';
                //passwordForEmailChange(false);
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            )
          ],
        );
      },
    );
  }


  // settings page for user that is not logged in or user without type
  Form unlogged() {
    final unloggedCategoryExpansionTiles = List<Widget>();
    unloggedCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Send Feedback',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        //TODO what else to add to privacy
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text('Insert link here'),
          ),
        ]));
    unloggedCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        //TODO what else to add to privacy
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text('Insert link here'),
          ),
        ]));
    unloggedCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Terms of Service',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text('Insert link here'),
          ),
        ]));
    unloggedCategoryExpansionTiles.add(Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          'Version Number 1',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    ));
    unloggedCategoryExpansionTiles.add(Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: themeColors['yellow'])),
          onPressed: () async {
            // add functionality
          },
          color: themeColors['yellow'],
          textColor: Colors.black,
          padding: EdgeInsets.all(15.0),
          splashColor: themeColors['yellow'],
          child: Text(
            "Submit Changes",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    ));
    return Form(
        key: _settingsKey,
        autovalidate: false,
        child: ListView(
          children: unloggedCategoryExpansionTiles,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Form settingsForm;

    settingsForm = unlogged();


    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        drawer: Menu(),
        body: Center(
          child: settingsForm,
        ));
  }
}

class SettingsScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) => SettingsScreen(
            vm.currentUser,
            vm.toHome,
            vm.logout));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toHome;
  VoidCallback logout;


  ViewModel.build({
    @required this.currentUser,
    @required this.toHome,
    @required this.logout,

  }) : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      toHome: () => dispatch(NavigateAction.pushNamed("/")),
      logout: () {
        print("logging out from settings");
        dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        dispatch(LogoutUserAction());
      },

    );
  }
}