import 'package:adc_app/backend/actions/common.dart';
import 'package:adc_app/backend/util/inputValidation.dart';
import '../common.dart';

// screen where users can change settings related to the TappableChipAttributes

class AdminSettingsScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback toHome;
  final VoidCallback logout;

  final void Function(String, String) updateAdminAccount;
  final Future<void> Function(Admin) adminToDB;

  AdminSettingsScreen(this.currentUser, this.toHome, this.logout,
      this.updateAdminAccount, this.adminToDB);
//      : assert(currentUser != null && toHome != null && logout != null);

  @override
  State<StatefulWidget> createState() => AdminSettingsScreenState();
}

class AdminSettingsScreenState extends State<AdminSettingsScreen> {
  final GlobalKey<FormState> _settingsKey = GlobalKey<FormState>();
  void Function(String, String) updateAdminAccount;
  Future<void> Function(Admin) adminToDB;

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

  bool statusReportNotification = true; //TODO remove this
  bool newAppNotification = true;

  @override
  void initState() {
    toHome = widget.toHome;
    currentUser = widget.currentUser;

    updateAdminAccount = widget.updateAdminAccount;
    adminToDB = widget.adminToDB;

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

  //TODO add admin backend functionality
  Form adminUser() {
    print('new admin settings');
    final adminCategoryExpansionTiles = List<Widget>();
    adminCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'My Account',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        children: <Widget>[
          Text(
            'Name',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Jane D.',
              ),
              controller: firstNameCtrl,
              validator: nameValidator,
            ),
          ),
//      Padding(
//        padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
//        child: Text('Phone Number',
//          style: TextStyle(
//            fontSize: 14,
//          ),
//        ),
//      ),
//      Padding(
//        padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
//        child: TextFormField(
//          decoration: InputDecoration(
//            border: OutlineInputBorder(),
//            hintText: '6785201876',
//          ),
//          controller: phoneNumCtrl,
//          validator: phoneValidator,
//        ),
//      ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text(
              'Email Address',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'example@gmail.com',
              ),
              controller: emailCtrl,
              validator: emailValidator,
            ),
          ),
        ]));
    adminCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Password',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Enter Current Password',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 2, 8, 0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //hintText: 'Jane D.',
              ),
              controller: newPasswordCtrl,
              //validator: ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Enter New Password',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 2, 8, 0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //hintText: 'Jane D.',
              ),
              //controller: firstNameCtrl,
              //validator: ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Confirm New Password',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 2, 8, 0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //hintText: 'Jane D.',
              ),
              //controller: firstNameCtrl,
              //validator: ,
            ),
          ),
        ]));
//    adminCategoryExpansionTiles.add(ExpansionTile(
//        title: Text(
//          'Availability',
//          style: TextStyle(
//            fontSize: 25,
//          ),
//        ),
//        //TODO what else to add to privacy
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
//            child: Text('I am NOT avaliable on: ${(currentUser as Doula).availableDates}'),
//
//          ),
//
//        ]
//
//    ));
    adminCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: SwitchListTile(
              activeColor: themeColors['yellow'],
              value: pushNotification,
              title: Text('Push Notifications'),
              onChanged: (value) {
                pushNotification = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: SwitchListTile(
              activeColor: themeColors['yellow'],
              value: smsNotification,
              title: Text('SMS Notifications'),
              onChanged: (value) {
                smsNotification = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: SwitchListTile(
              activeColor: themeColors['yellow'],
              value: emailNotification,
              title: Text('Email Notifications'),
              onChanged: (value) {
                emailNotification = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: SwitchListTile(
              activeColor: themeColors['yellow'],
              value: newAppNotification,
              title: Text('New Application'),
              onChanged: (value) {
                newAppNotification = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: SwitchListTile(
              activeColor: themeColors['yellow'],
              value: statusReportNotification,
              title: Text('Status Report Reminders'),
              onChanged: (value) {
                statusReportNotification = value;
              },
            ),
          ),
        ]));
    adminCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Privacy',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        //TODO what else to add to privacy
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text('Link to Privacy Policy goes here'),
          ),
        ]));
    adminCategoryExpansionTiles.add(Padding(
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
    adminCategoryExpansionTiles.add(Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: themeColors['mediumBlue'])),
          onPressed: () async {
            String adminName = firstNameCtrl.text.toString().trim();
            String adminEmail = emailCtrl.text.toString().trim();

            updateAdminAccount(adminName, adminEmail);
            setState(() {});
            await adminToDB(currentUser);
            toHome();
          },
          color: themeColors['mediumBlue'],
          textColor: Colors.white,
          padding: EdgeInsets.all(15.0),
          splashColor: themeColors['mediumBlue'],
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
          children: adminCategoryExpansionTiles,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Form settingsForm;

    settingsForm = adminUser();

    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        drawer: Menu(),
        body: Center(
          child: settingsForm,
        ));
  }
}

class AdminSettingsScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) => AdminSettingsScreen(
            vm.currentUser,
            vm.toHome,
            vm.logout,
            vm.updateAdminAccount,
            vm.adminToDB));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toHome;
  VoidCallback logout;
  void Function(String, String) updateAdminAccount;
  Future<void> Function(Admin) adminToDB;

  ViewModel.build({
    @required this.currentUser,
    @required this.toHome,
    @required this.logout,
    @required this.updateAdminAccount,
    this.adminToDB,
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
      updateAdminAccount: (
        String name,
        String email,
      ) =>
          dispatch(UpdateAdminUserAction(
        name: name,
        email: email,
      )),
      adminToDB: (Admin user) => dispatchFuture(UpdateAdminUserDocument(user)),
    );
  }
}
