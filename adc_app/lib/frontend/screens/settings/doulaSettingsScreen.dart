import 'package:adc_app/backend/actions/common.dart';
import 'package:adc_app/backend/util/inputValidation.dart';
import '../common.dart';

// screen where users can change settings related to the TappableChipAttributes

class DoulaSettingsScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback toHome;
  final VoidCallback logout;
  final void Function(Doula, String, List<Phone>, String, String, String, bool,
      bool, bool, String, int) updateDoulaAccount;
  final Future<void> Function(Doula) doulaToDB;


  DoulaSettingsScreen(
      this.currentUser,
      this.toHome,
      this.logout,
      this.updateDoulaAccount,
      this.doulaToDB);
//      : assert(currentUser != null && toHome != null && logout != null);

  @override
  State<StatefulWidget> createState() => DoulaSettingsScreenState();
}

class DoulaSettingsScreenState extends State<DoulaSettingsScreen> {
  final GlobalKey<FormState> _settingsKey = GlobalKey<FormState>();
  void Function(Doula, String, List<Phone>, String, String, String, bool, bool,
      bool, String, int) updateDoulaAccount;
  Future<void> Function(Doula) doulaToDB;


  VoidCallback toHome;

  User currentUser;

  TextEditingController firstNameCtrl;
  TextEditingController phoneNumCtrl;
  TextEditingController dateOfBirthCtrl;
  TextEditingController emailCtrl;
  TextEditingController bioCtrl;
  TextEditingController certProgramCtrl;
  TextEditingController birthsNeededCtrl;
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



  //doulas only
  String bio = '';
  bool certified = false;
  bool certInProgress = false;
  String certProgram;
  int birthsNeeded;
  bool matchWithClientNotification = true;
  bool clientInLaborNotification = true;



  @override
  void initState() {
    toHome = widget.toHome;
    currentUser = widget.currentUser;

    updateDoulaAccount = widget.updateDoulaAccount;
    doulaToDB = widget.doulaToDB;

    String userType = currentUser != null ? currentUser.userType : 'unlogged';

    if (currentUser != null) {
      userName = currentUser.name != null ? currentUser.name : '';
      phone = currentUser.phones != null
          ? currentUser.phones.toString().trim().substring(1, 11)
          : '';
      email = currentUser.email != null ? currentUser.email : '';
    }

    if (userType == 'doula') {
      dob = (currentUser as Doula).bday;
      bio = (currentUser as Doula).bio;
      certified = (currentUser as Doula).certified;
      certInProgress = (currentUser as Doula).certInProgress;
      certProgram = (currentUser as Doula).certProgram;
      birthsNeeded = (currentUser as Doula).birthsNeeded != null
          ? (currentUser as Doula).birthsNeeded
          : 0;
      photoRelease = (currentUser as Doula).photoRelease != null
          ? (currentUser as Doula).photoRelease
          : false;
    }


    //controllers
    firstNameCtrl = new TextEditingController(text: userName);
    phoneNumCtrl = new TextEditingController(text: phone);
    dateOfBirthCtrl = new TextEditingController(text: dob);
    emailCtrl = new TextEditingController(text: email);

    bioCtrl = new TextEditingController(text: bio);
    certProgramCtrl = new TextEditingController(text: certProgram);
    birthsNeededCtrl = new TextEditingController(text: '0');

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

  Form doulaUser() {
    final doulaCategoryExpansionTiles = List<Widget>();
    doulaCategoryExpansionTiles.add(ExpansionTile(
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
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text(
            'Bio',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
          child: TextField(
            minLines: 5,
            maxLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Write a few sentences about yourself',
            ),
            controller: bioCtrl,
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
        //TODO add doula unavailable dates
      ],
    ));
    doulaCategoryExpansionTiles.add(ExpansionTile(
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
    doulaCategoryExpansionTiles.add(ExpansionTile(
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
    doulaCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Certification',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: CheckboxListTile(
              value: certified,
              title: Text("Are you certified?"),
              onChanged: (bool value) {
                setState(() {
                  certified = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: CheckboxListTile(
              value: certInProgress,
              title: Text("Working towards certification?"),
              onChanged: (bool value) {
                setState(() {
                  certInProgress = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text(
              'Certification Program',
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
                hintText: 'DONA, CAPPA, ICEA, Other',
              ),
              controller: certProgramCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Births Needed for Certification:'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: '0'),
                        controller: birthsNeededCtrl,
                      ),
                    ),
                  ),
                ]),
          ),
        ]));
    doulaCategoryExpansionTiles.add(ExpansionTile(
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
              value: matchWithClientNotification,
              title: Text('Matched with Client'),
              onChanged: (value) {
                matchWithClientNotification = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
            child: SwitchListTile(
              activeColor: themeColors['yellow'],
              value: clientInLaborNotification,
              title: Text('Client going into labor'),
              onChanged: (value) {
                clientInLaborNotification = value;
              },
            ),
          ),
        ]));
    doulaCategoryExpansionTiles.add(ExpansionTile(
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
    doulaCategoryExpansionTiles.add(ExpansionTile(
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
    doulaCategoryExpansionTiles.add(ExpansionTile(
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
    doulaCategoryExpansionTiles.add(Padding(
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
    doulaCategoryExpansionTiles.add(Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: themeColors['yellow'])),
          onPressed: () async {
            String doulaName = "${firstNameCtrl.text.toString().trim()}";
            String doulaBday = dateOfBirthCtrl.text.toString().trim();
            String doulaEmail = emailCtrl.text.toString().trim();
            String doulaBio = bioCtrl.text.toString();
            certProgram = certProgramCtrl.text.toString();
            List<Phone> phones = List();
            //print('phone: ${phoneNumCtrl.text.toString().trim()}');
            phones.add(Phone(phoneNumCtrl.text.toString().trim(), true));

            birthsNeeded =
            int.parse(birthsNeededCtrl.text.toString().trim()) != null
                ? int.parse(birthsNeededCtrl.text.toString().trim())
                : 0;

            print('doulaEmail: $doulaEmail');
            print('currentUser.email: ${currentUser.email}');

            if (doulaEmail != currentUser.email) {
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
                  user.updateEmail(doulaEmail);
                  print('email was changed to: $doulaEmail');
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
            updateDoulaAccount(
                currentUser,
                doulaName,
                phones,
                doulaBday,
                doulaEmail,
                doulaBio,
                photoRelease,
                certified,
                certInProgress,
                certProgram,
                birthsNeeded);
            doulaToDB(currentUser);
            toHome();
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
      child: ListView(children: doulaCategoryExpansionTiles),
    );
  }


  @override
  Widget build(BuildContext context) {
    Form settingsForm;
    settingsForm = doulaUser();

    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        drawer: Menu(),
        body: Center(
          child: settingsForm,
        ));
  }
}

class DoulaSettingsScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) => DoulaSettingsScreen(
            vm.currentUser,
            vm.toHome,
            vm.logout,
            vm.updateDoulaAccount,
            vm.doulaToDB));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toHome;
  VoidCallback logout;
  void Function(Doula, String, List<Phone>, String, String, String, bool, bool,
      bool, String, int) updateDoulaAccount;
  Future<void> Function(Doula) doulaToDB;


  ViewModel.build({
    @required this.currentUser,
    @required this.toHome,
    @required this.logout,
    @required this.updateDoulaAccount,
    this.doulaToDB,

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
      updateDoulaAccount: (Doula user,
          String name,
          List<Phone> phones,
          String bday,
          String email,
          String bio,
          bool photoRelease,
          bool certified,
          bool certInProgress,
          String certProgram,
          int birthsNeeded) =>
          dispatch(UpdateDoulaUserAction(
            user,
            name: name,
            phones: phones,
            bday: bday,
            email: email,
            bio: bio,
            photoRelease: photoRelease,
            certified: certified,
            certInProgress: certInProgress,
            certProgram: certProgram,
            birthsNeeded: birthsNeeded,
          )),
      doulaToDB: (Doula user) => dispatchFuture(UpdateDoulaUserDocument(user)),

    );
  }
}
