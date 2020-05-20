import 'package:adc_app/backend/actions/common.dart';
import 'package:adc_app/backend/util/inputValidation.dart';
import '../common.dart';

// screen where users can change settings related to the TappableChipAttributes

class ClientSettingsScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback toHome;
  final VoidCallback logout;

  final void Function(Client, String, List<Phone>, String, String, bool)
  updateClientAccount;
  final Future<void> Function(Client) clientToDB;

  ClientSettingsScreen(
      this.currentUser,
      this.toHome,
      this.logout,
      this.updateClientAccount,
      this.clientToDB);
//      : assert(currentUser != null && toHome != null && logout != null);

  @override
  State<StatefulWidget> createState() => ClientSettingsScreenState();
}

class ClientSettingsScreenState extends State<ClientSettingsScreen> {
  final GlobalKey<FormState> _settingsKey = GlobalKey<FormState>();

  void Function(Client, String, List<Phone>, String, String, bool)
  updateClientAccount;
  Future<void> Function(Client) clientToDB;


  VoidCallback toHome;

  User currentUser;

  TextEditingController firstNameCtrl;
  TextEditingController phoneNumCtrl;
  TextEditingController dateOfBirthCtrl;
  TextEditingController emailCtrl;
  TextEditingController emergencyContactNameCtrl;
  TextEditingController emergencyContactRelationCtrl;
  TextEditingController emergencyContactPhoneCtrl;
  TextEditingController emergencyContactNameCtrl2;
  TextEditingController emergencyContactRelationCtrl2;
  TextEditingController emergencyContactPhoneCtrl2;
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

  //clients only
  bool matchWithDoulaNotification = true;
  bool statusReportNotification = true;
  List<EmergencyContact> emergencyContacts;



  @override
  void initState() {
    toHome = widget.toHome;
    currentUser = widget.currentUser;

    updateClientAccount = widget.updateClientAccount;
    clientToDB = widget.clientToDB;


    String userType = currentUser != null ? currentUser.userType : 'unlogged';

    if (currentUser != null) {
      userName = currentUser.name != null ? currentUser.name : '';
      phone = currentUser.phones != null
          ? currentUser.phones.toString().trim().substring(1, 11)
          : '';
      email = currentUser.email != null ? currentUser.email : '';
    }



    if (userType == 'client') {
      dob = (currentUser as Client).bday;
      int contactSize = (currentUser as Client).emergencyContacts != null
          ? (currentUser as Client).emergencyContacts.length
          : 0;
      emergencyContacts = (currentUser as Client).emergencyContacts;
      for (int i = 0; i < contactSize; i++) {
        emergencyContacts[i] = (currentUser as Client).emergencyContacts[i];
      }
      photoRelease = (currentUser as Client).photoRelease != null
          ? (currentUser as Client).photoRelease
          : false;
    }

    firstNameCtrl = new TextEditingController(text: userName);
    phoneNumCtrl = new TextEditingController(text: phone);
    dateOfBirthCtrl = new TextEditingController(text: dob);
    emailCtrl = new TextEditingController(text: email);

    //clients
    emergencyContactNameCtrl = new TextEditingController(text:
    (emergencyContacts[0] != null ? emergencyContacts[0].name : '')
    );
    emergencyContactRelationCtrl = new TextEditingController(text:
    (emergencyContacts[0] != null ? emergencyContacts[0].relationship : '')
    );
    emergencyContactPhoneCtrl = new TextEditingController(text:
    (emergencyContacts[0] != null ? emergencyContacts[0].phones.toString().trim().substring(1, 11) : '')
    );
    emergencyContactNameCtrl2 = new TextEditingController(text:
    (emergencyContacts[1] != null ? emergencyContacts[1].name : '')
    );
    emergencyContactRelationCtrl2 = new TextEditingController(text:
    (emergencyContacts[1] != null ? emergencyContacts[1].relationship : '')
    );
    emergencyContactPhoneCtrl2 = new TextEditingController(text:
    (emergencyContacts[1] != null ? emergencyContacts[1].phones.toString().trim().substring(1, 11) : '')
    );


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

  Form clientUser() {
    final clientCategoryExpansionTiles = List<Widget>();
    clientCategoryExpansionTiles.add(ExpansionTile(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text(
              'Phone Number',
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
                hintText: '6785201876',
              ),
              controller: phoneNumCtrl,
              validator: phoneValidator,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text(
              'Date of Birth',
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
                hintText: '01/09/1997',
              ),
              controller: dateOfBirthCtrl,
              validator: phoneValidator,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: CheckboxListTile(
              value: photoRelease,
              title: Text("Photo Release Permission"),
              onChanged: (bool value) {
                setState(() {
                  photoRelease = value;
                });
              },
            ),
          ),
        ]));
    clientCategoryExpansionTiles.add(ExpansionTile(
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
                hintText: "********",
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
              controller: oldPasswordCtrl,
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
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
              validator: pwdValidator,
            ),
          ),
        ]));
    clientCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Email',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        children: <Widget>[
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
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
        ]));

//    if (emergencyContacts != null) {
//      for (int i = 0; i < emergencyContacts.length; i++) {
    clientCategoryExpansionTiles.add(ExpansionTile(
      title: Text(
        'Emergency Contacts',
        style: TextStyle(
          fontSize: 25,
        ),
      ),
      children: <Widget>[
        //Contact1
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text(
            'Emergency Contact 1',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text(
            'Name',
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
              hintText: 'Robert',
            ),
            controller: emergencyContactNameCtrl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text(
            'Relationship',
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
              hintText: 'Father',
            ),
            controller: emergencyContactRelationCtrl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text(
            'Phone',
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
              hintText: '6785201876',
            ),
            controller: emergencyContactPhoneCtrl,
            validator: phoneValidator,
          ),
        ),
        //Contact2
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text(
            'Emergency Contact 2',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text(
            'Name',
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
              hintText: 'Robert',
            ),
            controller: emergencyContactNameCtrl2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text(
            'Relationship',
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
              hintText: 'Father',
            ),
            controller: emergencyContactRelationCtrl2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text(
            'Phone',
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
              hintText: '6785201876',
            ),
            controller: emergencyContactPhoneCtrl2,
            validator: phoneValidator,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: themeColors['yellow'])
            ),
            onPressed: () async {
              toHome();
            },
            color: themeColors['yellow'],
            textColor: Colors.black,
            //padding: EdgeInsets.all(15.0),
            splashColor: themeColors['yellow'],
            child: Text(
              "Update Contacts",
              style: TextStyle(fontSize: 15.0),
            ),
            //onPressed: ,
          ),
        )

      ],
    ));
//      }
//    }
    clientCategoryExpansionTiles.add(ExpansionTile(
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
              value: matchWithDoulaNotification,
              title: Text('Matched with Doula'),
              onChanged: (value) {
                matchWithDoulaNotification = value;
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
    clientCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Privacy',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        //TODO what else to add to privacy
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: SwitchListTile(
              activeColor: themeColors['yellow'],
              value: true,
              title: Text('Make Account Private'),
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text('Link to Privacy Policy goes here'),
          ),
        ]));
    clientCategoryExpansionTiles.add(ExpansionTile(
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
    clientCategoryExpansionTiles.add(ExpansionTile(
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
    clientCategoryExpansionTiles.add(Padding(
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
    clientCategoryExpansionTiles.add(Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: themeColors['emoryBlue'])
          ),
          onPressed: () async {
            String clientName = firstNameCtrl.text.toString().trim();
            String clientBday = dateOfBirthCtrl.text.toString().trim();
            print('bday: ${dateOfBirthCtrl.text.toString().trim()}');
            String clientEmail = emailCtrl.text.toString().trim();
            List<Phone> phones = List();
            print('phone: ${phoneNumCtrl.text.toString().trim()}');
            phones.add(Phone(phoneNumCtrl.text.toString().trim(), true));

            if (clientEmail != currentUser.email) {
//              print('dialog box open');
//              confirmPasswordDialog(context);
              print(
                  'password: ${changeEmailPasswordCtrl.text.toString().trim()}');
              if (changeEmailPasswordCtrl.text.toString().trim() != '') {
                print(
                    'changeEmailPasswordCtrl: ${changeEmailPasswordCtrl.text.toString().trim()}');
                AuthResult result = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                    email: currentUser.email,
                    password:
                    '${changeEmailPasswordCtrl.text.toString().trim()}');
                FirebaseUser user = result.user;
                print('user: $user');
                String userId = user.uid;
                print('userId: $userId');
                if (userId.length > 0 && userId != null) {
                  user.updateEmail(clientEmail);
                  print('email was changed to: $clientEmail');
                } else {
                  print('email was not changed');
                }
              }
//
            }

            if (oldPasswordCtrl.text.toString().trim() != '') {
              print(
                  'oldPasswordCtrl: ${oldPasswordCtrl.text.toString().trim()}');
              AuthResult result = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                  email: currentUser.email,
                  password: '${oldPasswordCtrl.text.toString().trim()}');
              FirebaseUser user = result.user;
              print('user: $user');
              String userId = user.uid;
              print('userId: $userId');

              if (userId.length > 0 && userId != null) {
                if (newPasswordCtrl.text.toString() ==
                    confirmPasswordCtrl.text.toString()) {
                  user.updatePassword(newPasswordCtrl.text.toString());
                  print(
                      'password was changed to ${newPasswordCtrl.text.toString()}');
                }
              } else {
                //TODO add a pop up notification here
                print(
                    'password was NOT changed to ${newPasswordCtrl.text.toString()}');
              }
            }

            updateClientAccount(currentUser, clientName, phones, clientBday,
                clientEmail, photoRelease);

            clientToDB(currentUser);
            toHome();
          },
          color: themeColors['emoryBlue'],
          textColor: Colors.white,
          padding: EdgeInsets.all(15.0),
          splashColor: themeColors['emoryBlue'],
          child: Text(
            "Back to Home",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    ));

    return Form(
        key: _settingsKey,
        autovalidate: false,
        child: ListView(
          children: clientCategoryExpansionTiles,
        ));
  }


  @override
  Widget build(BuildContext context) {
    Form settingsForm;
    settingsForm = clientUser();
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        drawer: Menu(),
        body: Center(
          child: settingsForm,
        ));
  }
}

class ClientSettingsScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) => ClientSettingsScreen(
            vm.currentUser,
            vm.toHome,
            vm.logout,
            vm.updateClientAccount,
            vm.clientToDB));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toHome;
  VoidCallback logout;

  void Function(Client, String, List<Phone>, String, String, bool)
  updateClientAccount;
  Future<void> Function(Client) clientToDB;


  ViewModel.build({
    @required this.currentUser,
    @required this.toHome,
    @required this.logout,
    @required this.updateClientAccount,
    this.clientToDB,

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

      updateClientAccount: (Client user, String name, List<Phone> phones,
          String bday, String email, bool photoRelease) =>
          dispatch(UpdateClientUserAction(
            user,
            name: name,
            phones: phones,
            bday: bday,
            email: email,
            photoRelease: photoRelease,
          )),
      clientToDB: (Client user) =>
          dispatchFuture(UpdateClientUserDocument(user)),

    );
  }
}
