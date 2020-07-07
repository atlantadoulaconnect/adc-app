import 'package:adc_app/backend/actions/common.dart';
import 'package:adc_app/backend/util/inputValidation.dart';
import '../common.dart';

// screen where users can change settings related to the TappableChipAttributes

class DoulaSettingsScreen extends StatefulWidget {
  final Doula currentUser;
  final VoidCallback toHome;
  final VoidCallback logout;
  final VoidCallback toConfirmSettings;
  final void Function(Doula, String, List<Phone>, String, String, bool)
      updateDoulaAccount;
  final void Function(Doula, bool, bool, String, int) updateCertification;
  final void Function(Doula, String) updateEmail;
  final Future<void> Function() doulaToDB;

  DoulaSettingsScreen(
      this.currentUser,
      this.toHome,
      this.toConfirmSettings,
      this.logout,
      this.updateDoulaAccount,
      this.updateCertification,
      this.updateEmail,
      this.doulaToDB);

//      : assert(currentUser != null && toHome != null && logout != null);

  @override
  State<StatefulWidget> createState() => DoulaSettingsScreenState();
}

class DoulaSettingsScreenState extends State<DoulaSettingsScreen> {
  void Function(Doula, String, List<Phone>, String, String, bool)
      updateDoulaAccount;
  void Function(Doula, bool, bool, String, int) updateCertification;
  void Function(Doula, String) updateEmail;
  Future<void> Function() doulaToDB;

  VoidCallback toHome;
  VoidCallback toConfirmSettings;

  Doula currentUser;

  final GlobalKey<FormState> _accountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pwdKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _certKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _notificationsKey = GlobalKey<FormState>();

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
    toConfirmSettings = widget.toConfirmSettings;
    currentUser = widget.currentUser;

    updateDoulaAccount = widget.updateDoulaAccount;
    updateCertification = widget.updateCertification;
    updateEmail = widget.updateEmail;
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
      dob = currentUser.bday;
      bio = currentUser.bio;
      certified = currentUser.certified;
      certInProgress = currentUser.certInProgress;
      certProgram = currentUser.certProgram;
      birthsNeeded =
          currentUser.birthsNeeded != null ? currentUser.birthsNeeded : 0;
      photoRelease =
          currentUser.photoRelease != null ? currentUser.photoRelease : false;
    }

    //controllers
    firstNameCtrl = new TextEditingController(text: userName);
    phoneNumCtrl = new TextEditingController(text: phone);
    dateOfBirthCtrl = new TextEditingController(text: dob);
    emailCtrl = new TextEditingController(text: email);

    bioCtrl = new TextEditingController(text: bio);
    certProgramCtrl = new TextEditingController(text: certProgram);
    birthsNeededCtrl = new TextEditingController(text: birthsNeeded.toString());

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
                toHome();
                //Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
          ],
        );
      },
    );
  }

  updateAccountDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Your account was successfully updated"),
          actions: <Widget>[
            FlatButton(
              child: Text("Okay"),
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
          child: ListView(
            children: <Widget>[
              Form(
                  key: _accountKey,
                  autovalidate: false,
                  child: ExpansionTile(
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
                          validator: bdayValidator,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () async {
                            final form = _accountKey.currentState;
                            if (form.validate()) {
                              form.save();

                              List<Phone> phones = List();

                              phones.add(Phone(
                                  phoneNumCtrl.text.toString().trim(), true));
                              print('name before update: ${currentUser.name}');
                              currentUser.name =
                                  firstNameCtrl.text.toString().trim();
                              currentUser.phones = phones;
                              currentUser.bday =
                                  dateOfBirthCtrl.text.toString().trim();
                              currentUser.bio = bioCtrl.text.toString();
                              currentUser.photoRelease = photoRelease;

                              updateDoulaAccount(
                                  currentUser,
                                  firstNameCtrl.text.toString().trim(),
                                  phones,
                                  dateOfBirthCtrl.text.toString().trim(),
                                  bioCtrl.text.toString(),
                                  photoRelease);
                              print('name after update: ${currentUser.name}');

                              await doulaToDB();
                              updateAccountDialog(context);
                              print(
                                  'name after updated call: ${currentUser.name}');
                            }
                          },
                          color: themeColors['yellow'],
                          textColor: Colors.black,
                          //padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['yellow'],
                          child: Text(
                            "Update Account",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          //onPressed: ,
                        ),
                      )
                      //TODO add doula unavailable dates
                    ],
                  )),
              Form(
                key: _pwdKey,
                autovalidate: false,
                child: ExpansionTile(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () async {
                            final form = _pwdKey.currentState;
                            if (form.validate()) {
                              form.save();
                              if (oldPasswordCtrl.text.toString().trim() !=
                                  '') {
                                print(
                                    'oldPasswordCtrl: ${oldPasswordCtrl.text.toString().trim()}');
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
                            }
                          },
                          color: themeColors['yellow'],
                          textColor: Colors.black,
                          //padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['yellow'],
                          child: Text(
                            "Update Password",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          //onPressed: ,
                        ),
                      )
                    ]),
              ),
              Form(
                key: _emailKey,
                autovalidate: false,
                child: ExpansionTile(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () async {
                            String newDoulaEmail = emailCtrl.text.toString().trim();
                            String doulaPassword = changeEmailPasswordCtrl.text.toString().trim();
                            print('new email: $newDoulaEmail  pw: $doulaPassword');

                            AuthResult result = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: currentUser.email,
                                password: doulaPassword);
                            FirebaseUser user = result.user;
                            print('user: $user');
                            String userId = user.uid;
                            print('userId: $userId');

                            user.updateEmail(newDoulaEmail);
                            updateEmail(currentUser, newDoulaEmail);
                            await doulaToDB();
                            print("Email was changed to: ${emailCtrl.text.toString().trim()}");
                            updateAccountDialog(context);
                          },
                          color: themeColors['yellow'],
                          textColor: Colors.black,
                          //padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['yellow'],
                          child: Text(
                            "Update Email",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          //onPressed: ,
                        ),
                      )
                    ]),
              ),
              Form(
                key: _certKey,
                autovalidate: false,
                child: ExpansionTile(
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
                                        border: OutlineInputBorder(),
                                        hintText: '0'),
                                    controller: birthsNeededCtrl,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () async {
                            final form = _certKey.currentState;
                            if (form.validate()) {
                              form.save();
                              String programName =
                                  certProgramCtrl.text.toString().trim();
                              int numOfBirths = int.parse(
                                  birthsNeededCtrl.text.toString().trim());

                              currentUser.certProgram = programName;
                              currentUser.birthsNeeded = numOfBirths;
                              currentUser.certified = certified;
                              currentUser.certInProgress = certInProgress;

                              updateCertification(currentUser, certified,
                                  certInProgress, programName, numOfBirths);
                              await doulaToDB();
                              updateAccountDialog(context);
                            }
                          },
                          color: themeColors['yellow'],
                          textColor: Colors.black,
                          //padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['yellow'],
                          child: Text(
                            "Update Certification",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          //onPressed: ,
                        ),
                      )
                    ]),
              ),
              Form(
                key: _notificationsKey,
                autovalidate: false,
                child: ExpansionTile(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () async {
                            //TODO add notifications functionality
                            toHome();
                          },
                          color: themeColors['yellow'],
                          textColor: Colors.black,
                          //padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['yellow'],
                          child: Text(
                            "Update Notifications",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          //onPressed: ,
                        ),
                      ),
                    ]),
              ),
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
                  ]),
              ExpansionTile(
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
                  ]),
              ExpansionTile(
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
                  ]),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'Version Number 1',
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
                        side: BorderSide(color: themeColors['emoryBlue'])),
                    onPressed: () async {
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
              )
            ],
          ),
        ));
  }
}

class DoulaSettingsScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        debug: this,
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) => DoulaSettingsScreen(
            vm.currentUser,
            vm.toHome,
            vm.toConfirmSettings,
            vm.logout,
            vm.updateDoulaAccount,
            vm.updateCertification,
            vm.updateEmail,
            vm.doulaToDB));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  VoidCallback toHome;
  VoidCallback toConfirmSettings;
  VoidCallback logout;
  void Function(Doula, String, List<Phone>, String, String, bool)
      updateDoulaAccount;
  void Function(Doula, bool, bool, String, int) updateCertification;
  void Function(Doula, String) updateEmail;
  Future<void> Function() doulaToDB;

  ViewModel.build({
    @required this.currentUser,
    @required this.toHome,
    @required this.toConfirmSettings,
    @required this.logout,
    @required this.updateDoulaAccount,
    @required this.updateCertification,
    @required this.updateEmail,
    this.doulaToDB,
  }) : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser as Doula,
      toHome: () => dispatch(NavigateAction.pushNamed("/")),
      toConfirmSettings: () =>
          dispatch(NavigateAction.pushNamed("/confirmSettings")),
      logout: () {
        print("logging out from settings");
        dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        dispatch(LogoutUserAction());
      },
      updateDoulaAccount: (Doula user, String name, List<Phone> phones,
              String bday, String bio, bool photoRelease) =>
          dispatch(UpdateDoulaUserAction(
        user,
        name: name,
        phones: phones,
        bday: bday,
        bio: bio,
        photoRelease: photoRelease,
      )),
      updateCertification: (Doula user, bool certified, bool certInProgress,
              String certProgram, int birthsNeeded) =>
          dispatch(UpdateDoulaUserAction(user,
              certified: certified,
              certInProgress: certInProgress,
              certProgram: certProgram,
              birthsNeeded: birthsNeeded)),
      updateEmail: (Doula user, String email) =>
          dispatch(UpdateDoulaUserAction(
              user,
              email: email)),
      doulaToDB: () => dispatchFuture(UpdateDoulaUserDocument()),
    );
  }
}
