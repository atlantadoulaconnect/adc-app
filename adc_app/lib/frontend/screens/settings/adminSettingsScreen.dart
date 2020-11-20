import 'package:adc_app/backend/actions/common.dart';
import 'package:adc_app/backend/util/inputValidation.dart';
import '../common.dart';

// screen where users can change settings related to the TappableChipAttributes

class AdminSettingsScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback logout;

  final void Function(String, String) updateAdminAccount;
  final Future<void> Function(Admin) adminToDB;

  AdminSettingsScreen(
      this.currentUser, this.logout, this.updateAdminAccount, this.adminToDB);

  @override
  State<StatefulWidget> createState() => AdminSettingsScreenState();
}

class AdminSettingsScreenState extends State<AdminSettingsScreen> {
  final GlobalKey<FormState> _settingsKey = GlobalKey<FormState>();
  void Function(String, String) updateAdminAccount;
  Future<void> Function(Admin) adminToDB;

  User currentUser;

  TextEditingController nameCtrl;
  TextEditingController emailCtrl;

  TextEditingController oldPasswordCtrl;
  TextEditingController newPasswordCtrl;
  TextEditingController confirmPasswordCtrl;
  TextEditingController changeEmailPasswordCtrl;

  //general
  String userName;
  String email;
  String dob;
  bool photoRelease = false;
  bool passwordVisible = false;
  String password;
  String newPassword;
  String confirmPassword;

  bool pushNotification = true;
  bool smsNotification = true;
  bool messagesNotification = true;

  bool statusReportNotification = true; //TODO remove this
  bool newAppNotification = true;

  @override
  void initState() {
    currentUser = widget.currentUser;

    updateAdminAccount = widget.updateAdminAccount;
    adminToDB = widget.adminToDB;

    String userType = currentUser != null ? currentUser.userType : 'unlogged';

    if (currentUser != null) {
      userName = currentUser.name != null ? currentUser.name : '';
      email = currentUser.email != null ? currentUser.email : '';
    }

    nameCtrl = new TextEditingController(text: userName);
    emailCtrl = new TextEditingController(text: email);

    oldPasswordCtrl = new TextEditingController();
    newPasswordCtrl = new TextEditingController();
    confirmPasswordCtrl = new TextEditingController();
    changeEmailPasswordCtrl = new TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    //nameCtrl.dispose();
    super.dispose();
  }

  passwordWasChanged(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Your password was successfully changed"),
          actions: <Widget>[
            FlatButton(
              child: Text("Go back"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        drawer: Menu(),
        body: Center(
            child: Form(
                key: _settingsKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: ListView(children: <Widget>[
                  ExpansionTile(
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
                              hintText: 'Administrators',
                            ),
                            controller: nameCtrl,
                            validator: nameValidator,
                          ),
                        ),
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
                              hintText: "********",
                              suffixIcon: IconButton(
                                icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: passwordVisible
                                        ? themeColors["black"]
                                        : themeColors["coolGray5"]),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !passwordVisible,
                            controller: changeEmailPasswordCtrl,
                            //validator: ,
                          ),
                        ),
                      ]),
                  ExpansionTile(
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: passwordVisible
                                        ? themeColors["black"]
                                        : themeColors["coolGray5"]),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !passwordVisible,
                            controller: newPasswordCtrl,
                            validator: pwdValidator,
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: passwordVisible
                                        ? themeColors["black"]
                                        : themeColors["coolGray5"]),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !passwordVisible,
                            controller: confirmPasswordCtrl,
                            validator: (val) {
                              if (val != newPasswordCtrl.text)
                                return "Passwords do not match.";
                              return null;
                            },
                          ),
                        ),
                      ]),
                  ExpansionTile(
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
                      ]),
                  ExpansionTile(
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
                      ]),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: themeColors['mediumBlue'])),
                        onPressed: () async {
                          final form = _settingsKey.currentState;
                          if (form.validate()) {
                            form.save();

                            String adminName = nameCtrl.text.toString().trim();
                            String adminEmail =
                                emailCtrl.text.toString().trim();

                            updateAdminAccount(adminName, adminEmail);
                            setState(() {});

                            if (newPasswordCtrl.text
                                .toString()
                                .trim()
                                .isNotEmpty) {
                              print('Changing Admin password');
                              AuthResult result = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: currentUser.email,
                                      password:
                                          '${oldPasswordCtrl.text.toString().trim()}');
                              FirebaseUser user = result.user;
                              print('user: $user');
                              String userId = user.uid;
                              print('userId: $userId');

                              if (userId.length > 0 && userId != null) {
                                if (newPasswordCtrl.text.toString() ==
                                    confirmPasswordCtrl.text.toString()) {
                                  user.updatePassword(
                                      newPasswordCtrl.text.toString());
                                  passwordWasChanged(context);
                                  print(
                                      'password was changed to ${newPasswordCtrl.text.toString()}');
                                }
                              } else {
                                //TODO add a pop up notification here
                                print(
                                    'password was NOT changed to ${newPasswordCtrl.text.toString()}');
                              }
                            }

                            await adminToDB(currentUser);
                          }
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
                  ),
                ]))));
  }
}

class AdminSettingsScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) => AdminSettingsScreen(
            vm.currentUser, vm.logout, vm.updateAdminAccount, vm.adminToDB));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback logout;
  void Function(String, String) updateAdminAccount;
  Future<void> Function(Admin) adminToDB;

  ViewModel.build({
    @required this.currentUser,
    @required this.logout,
    @required this.updateAdminAccount,
    this.adminToDB,
  }) : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
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
