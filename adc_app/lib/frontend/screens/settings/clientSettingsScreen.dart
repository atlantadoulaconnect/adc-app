import 'dart:ui';

import 'package:adc_app/backend/actions/common.dart';
import 'package:adc_app/backend/util/inputValidation.dart';
import '../common.dart';

// screen where users can change settings related to the TappableChipAttributes

class ClientSettingsScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback toHome;
  final VoidCallback logout;
  final VoidCallback toClientSettings;

  final void Function(Client, String, List<Phone>, String, bool)
      updateClientAccount;
  //user, birthLocation, birthType, DueDate, previousDeliveryTypes,
  //preterm, lowBirthWeight, multiples, epidural, cesarean
  final void Function(Client, String, String, String, List<String>, bool, bool,
      bool, bool, bool) updateBirthInformation;
  final void Function(Client, List<EmergencyContact>) updateEmergencyContacts;
  final Future<void> Function() clientToDB;

  ClientSettingsScreen(
      this.currentUser,
      this.toHome,
      this.logout,
      this.updateClientAccount,
      this.updateBirthInformation,
      this.updateEmergencyContacts,
      this.clientToDB,
      this.toClientSettings);
//      : assert(currentUser != null && toHome != null && logout != null);

  @override
  State<StatefulWidget> createState() => ClientSettingsScreenState();
}

class ClientSettingsScreenState extends State<ClientSettingsScreen> {
  final GlobalKey<FormState> _settingsKey = GlobalKey<FormState>();

  void Function(Client, String, List<Phone>, String, bool) updateClientAccount;
  void Function(Client, String, String, String, List<String>, bool, bool, bool,
      bool, bool) updateBirthInformation;
  void Function(Client, List<EmergencyContact>) updateEmergencyContacts;
  Future<void> Function() clientToDB;

  VoidCallback toHome;
  VoidCallback toClientSettings;

  User currentUser;

  final GlobalKey<FormState> _accountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pwdKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emgContactsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _birthKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _notificationsKey = GlobalKey<FormState>();

  TextEditingController firstNameCtrl;
  TextEditingController phoneNumCtrl;
  TextEditingController dateOfBirthCtrl;
  TextEditingController oldPasswordCtrl;

  TextEditingController newPasswordCtrl;
  TextEditingController confirmPasswordCtrl;
  TextEditingController changeEmailPasswordCtrl;
  TextEditingController emailCtrl;

  TextEditingController emergencyContactNameCtrl;
  TextEditingController emergencyContactRelationCtrl;
  TextEditingController emergencyContactPhoneCtrl;
  TextEditingController emergencyContactNameCtrl2;
  TextEditingController emergencyContactRelationCtrl2;
  TextEditingController emergencyContactPhoneCtrl2;

  TextEditingController birthLocationCtrl;
  TextEditingController birthTypeCtrl;
  TextEditingController dueDateCtrl;

  //TextEditingController deliveryTypesCtrl;
  bool previousVaginalBirth = false,
      previousCesarean = false,
      previousVbac = false;
  bool cesarean = false, epidural = false;
  bool homeVisit = false;
  int liveBirths;
  bool preterm = false, lowWeight = false;
  bool meetBefore = false;
  bool multiples = false;

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
  String birthLocation;
  String birthType;
  String dueDate;

  List<String> deliveryType;

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
    toClientSettings = widget.toClientSettings;
    currentUser = widget.currentUser;

    updateClientAccount = widget.updateClientAccount;
    updateBirthInformation = widget.updateBirthInformation;
    updateEmergencyContacts = widget.updateEmergencyContacts;
    clientToDB = widget.clientToDB;

    //String userType = currentUser != null ? currentUser.userType : 'unlogged';

    //if (currentUser != null) {
    userName = currentUser.name != null ? currentUser.name : '';
    phone = currentUser.phones != null
        ? currentUser.phones.toString().trim().substring(1, 11)
        : '';
    email = currentUser.email != null ? currentUser.email : '';
    //}

    //if (userType == 'client') {
    //ASSIGNING VALUES
    dob = (currentUser as Client).bday;
    int contactSize = (currentUser as Client).emergencyContacts != null
        ? (currentUser as Client).emergencyContacts.length
        : 0;
    emergencyContacts = (currentUser as Client).emergencyContacts;
    for (int i = 0; i < contactSize; i++) {
      emergencyContacts[i] = (currentUser as Client).emergencyContacts[i];
    }

    birthLocation = (currentUser as Client).birthLocation;
    birthType = (currentUser as Client).birthType;
    dueDate = (currentUser as Client).dueDate;

    int deliveryTypeSize = (currentUser as Client).deliveryTypes != null
        ? (currentUser as Client).deliveryTypes.length
        : 0;

    for (int i = 0; i < deliveryTypeSize; i++) {
      if ((currentUser as Client).deliveryTypes[i].toString() == 'vaginal') {
        previousVaginalBirth = true;
      }
      if ((currentUser as Client).deliveryTypes[i].toString() == 'vbac') {
        previousVbac = true;
      }
      if ((currentUser as Client).deliveryTypes[i].toString() == 'cesarean') {
        previousCesarean = true;
      }
      //emergencyContacts[i] = (currentUser as Client).emergencyContacts[i];
    }

    preterm = (currentUser as Client).preterm != null
        ? (currentUser as Client).preterm
        : false;
    //print('preterm: $preterm');
    lowWeight = (currentUser as Client).lowWeight != null
        ? (currentUser as Client).lowWeight
        : false;
    multiples = (currentUser as Client).multiples != null
        ? (currentUser as Client).multiples
        : false;
    cesarean = (currentUser as Client).cesarean != null
        ? (currentUser as Client).cesarean
        : false;
    epidural = (currentUser as Client).epidural != null
        ? (currentUser as Client).epidural
        : false;

//      deliveryType = (currentUser as Client).deliveryTypes;
//      print('deliveryType: ${deliveryType.toString}');
    photoRelease = (currentUser as Client).photoRelease != null
        ? (currentUser as Client).photoRelease
        : false;
    //}

    firstNameCtrl = new TextEditingController(text: userName);
    phoneNumCtrl = new TextEditingController(text: phone);
    dateOfBirthCtrl = new TextEditingController(text: dob);
    emailCtrl = new TextEditingController(text: email);

    //clients
    emergencyContactNameCtrl = new TextEditingController(
        text: (emergencyContacts[0] != null ? emergencyContacts[0].name : ''));
    emergencyContactRelationCtrl = new TextEditingController(
        text: (emergencyContacts[0] != null
            ? emergencyContacts[0].relationship
            : ''));
    emergencyContactPhoneCtrl = new TextEditingController(
        text: (emergencyContacts[0] != null
            ? emergencyContacts[0].phones.toString().trim().substring(1, 11)
            : ''));
    emergencyContactNameCtrl2 = new TextEditingController(
        text: (emergencyContacts[1] != null ? emergencyContacts[1].name : ''));
    emergencyContactRelationCtrl2 = new TextEditingController(
        text: (emergencyContacts[1] != null
            ? emergencyContacts[1].relationship
            : ''));
    emergencyContactPhoneCtrl2 = new TextEditingController(
        text: (emergencyContacts[1] != null
            ? emergencyContacts[1].phones.toString().trim().substring(1, 11)
            : ''));

    oldPasswordCtrl = new TextEditingController();
    newPasswordCtrl = new TextEditingController();
    confirmPasswordCtrl = new TextEditingController();
    changeEmailPasswordCtrl = new TextEditingController();

    birthLocationCtrl = new TextEditingController(text: birthLocation);
    birthTypeCtrl = new TextEditingController(text: birthType);
    dueDateCtrl = new TextEditingController(text: dueDate);

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: themeColors['yellow'])),
              onPressed: () async {
                String clientName = firstNameCtrl.text.toString().trim();
                print('clientName: $clientName');
                String clientBday = dateOfBirthCtrl.text.toString().trim();
                print('bday: ${dateOfBirthCtrl.text.toString().trim()}');
                List<Phone> phones = List();
                print('phone: ${phoneNumCtrl.text.toString().trim()}');
                phones.add(Phone(phoneNumCtrl.text.toString().trim(), true));

                updateClientAccount(
                    currentUser, clientName, phones, clientBday, photoRelease);
                print('currentUser.name before: ${currentUser.name}');
                setState(() {});
                await clientToDB();
                print('currentUser.name after: ${currentUser.name}');

                updateAccountDialog(context);

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: themeColors['yellow'])),
              onPressed: () async {
                if (oldPasswordCtrl.text.toString().trim() != '') {
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
                      user.updatePassword(newPasswordCtrl.text.toString());
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: themeColors['yellow'])),
              onPressed: () async {
                //TODO add contacts functionality
                toHome();
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
        ]));
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                side: BorderSide(color: themeColors['yellow'])),
            onPressed: () async {
              List<Phone> phones1 = new List<Phone>();
              List<Phone> phones2 = new List<Phone>();

              if (emergencyContactPhoneCtrl.text.isNotEmpty) {
                phones1.add(Phone(
                    emergencyContactPhoneCtrl.text.toString().trim(), true));
              }
              if (emergencyContactPhoneCtrl2.text.isNotEmpty) {
                phones2.add(Phone(
                    emergencyContactPhoneCtrl2.text.toString().trim(), true));
              }

              EmergencyContact ec1 = EmergencyContact(
                  emergencyContactNameCtrl.text.toString().trim(),
                  emergencyContactRelationCtrl.text.toString().trim(),
                  phones1);
              EmergencyContact ec2 = EmergencyContact(
                  emergencyContactNameCtrl2.text.toString().trim(),
                  emergencyContactRelationCtrl2.text.toString().trim(),
                  phones2);

              List<EmergencyContact> ecs = new List<EmergencyContact>();
              ecs.add(ec1);
              ecs.add(ec2);
              print("ec1: $ecs");
              updateEmergencyContacts(currentUser, ecs);
              setState(() {});
              await clientToDB();
              //toHome();
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
    clientCategoryExpansionTiles.add(ExpansionTile(
        title: Text(
          'Birth Information',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        children: <Widget>[
          Text(
            'Birth Location',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Grady',
              ),
              controller: birthLocationCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text(
              'Birth Type',
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
                hintText: '"Singleton", "Twins", "Triplets", "more"',
              ),
              controller: birthTypeCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text(
              'Due Date',
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
              controller: dueDateCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text(
              'Previous Delivery Types',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Vaginal Birth"),
                    Checkbox(
                      value: previousVaginalBirth,
                      onChanged: (bool value) {
                        setState(() {
                          previousVaginalBirth = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Cesaerean"),
                    Checkbox(
                      value: previousCesarean,
                      onChanged: (bool value) {
                        setState(() {
                          previousCesarean = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("VBAC"),
                    Checkbox(
                      value: previousVbac,
                      onChanged: (bool value) {
                        setState(() {
                          previousVbac = value;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Preterm"),
                    Checkbox(
                      value: preterm,
                      onChanged: (bool value) {
                        setState(() {
                          preterm = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Low Birth Weight"),
                    Checkbox(
                      value: lowWeight,
                      onChanged: (bool value) {
                        setState(() {
                          lowWeight = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Twins/Triplets"),
                    Checkbox(
                      value: multiples,
                      onChanged: (bool value) {
                        setState(() {
                          multiples = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text(
              'Current Birth Plan',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Epidural"),
                    Checkbox(
                      value: epidural,
                      onChanged: (bool value) {
                        setState(() {
                          epidural = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Cesarean (C-Section)"),
                    Checkbox(
                      value: cesarean,
                      onChanged: (bool value) {
                        setState(() {
                          cesarean = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: themeColors['yellow'])),
              onPressed: () async {
                String location = birthLocationCtrl.text.toString().trim();
                String type = birthTypeCtrl.text.toString().trim();
                String date = dueDateCtrl.text.toString().trim();

                List<String> deliveries = List();
                if (previousVaginalBirth) {
                  deliveries.add("vaginal");
                }
                if (previousCesarean) {
                  deliveries.add("cesarean");
                }
                if (previousVbac) {
                  deliveries.add("vbac");
                }

                updateBirthInformation(
                    currentUser,
                    location,
                    type,
                    date,
                    deliveries,
                    preterm,
                    lowWeight,
                    multiples,
                    epidural,
                    cesarean);
                setState(() {});
                await clientToDB();

                //toClientSettings;
              },
              color: themeColors['yellow'],
              textColor: Colors.black,
              //padding: EdgeInsets.all(15.0),
              splashColor: themeColors['yellow'],
              child: Text(
                "Update Birth Information",
                style: TextStyle(fontSize: 15.0),
              ),
              //onPressed: ,
            ),
          )
        ]));
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
          )
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
              side: BorderSide(color: themeColors['emoryBlue'])),
          onPressed: () async {
//            String clientName = firstNameCtrl.text.toString().trim();
//            String clientBday = dateOfBirthCtrl.text.toString().trim();
//            print('bday: ${dateOfBirthCtrl.text.toString().trim()}');
//
//            List<Phone> phones = List();
//            print('phone: ${phoneNumCtrl.text.toString().trim()}');
//            phones.add(Phone(phoneNumCtrl.text.toString().trim(), true));
            String clientEmail = emailCtrl.text.toString().trim();

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

//            updateClientAccount(currentUser, clientName, phones, clientBday,
//                clientEmail, photoRelease);
//
//            clientToDB(currentUser);
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
                              String clientName =
                                  firstNameCtrl.text.toString().trim();

                              String clientBday =
                                  dateOfBirthCtrl.text.toString().trim();

                              List<Phone> phones = List();

                              phones.add(Phone(
                                  phoneNumCtrl.text.toString().trim(), true));

                              updateClientAccount(currentUser, clientName,
                                  phones, clientBday, photoRelease);

                              await clientToDB();

                              updateAccountDialog(context);

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
                    ]),
              ),
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
                            //TODO add contacts functionality
                            toHome();
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
                key: _emgContactsKey,
                autovalidate: false,
                child: ExpansionTile(
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
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                            side: BorderSide(color: themeColors['yellow'])),
                        onPressed: () async {
                          final form = _emgContactsKey.currentState;
                          if (form.validate()) {
                            form.save();
                            List<Phone> phones1 = new List<Phone>();
                            List<Phone> phones2 = new List<Phone>();

                            if (emergencyContactPhoneCtrl.text.isNotEmpty) {
                              phones1.add(Phone(
                                  emergencyContactPhoneCtrl.text
                                      .toString()
                                      .trim(),
                                  true));
                            }
                            if (emergencyContactPhoneCtrl2.text.isNotEmpty) {
                              phones2.add(Phone(
                                  emergencyContactPhoneCtrl2.text
                                      .toString()
                                      .trim(),
                                  true));
                            }

                            EmergencyContact ec1 = EmergencyContact(
                                emergencyContactNameCtrl.text.toString().trim(),
                                emergencyContactRelationCtrl.text
                                    .toString()
                                    .trim(),
                                phones1);
                            EmergencyContact ec2 = EmergencyContact(
                                emergencyContactNameCtrl2.text
                                    .toString()
                                    .trim(),
                                emergencyContactRelationCtrl2.text
                                    .toString()
                                    .trim(),
                                phones2);

                            List<EmergencyContact> ecs =
                                new List<EmergencyContact>();
                            ecs.add(ec1);
                            ecs.add(ec2);
                            print("ec1: $ecs");
                            updateEmergencyContacts(currentUser, ecs);
                            setState(() {});
                            await clientToDB();
                          }
                          //toHome();
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
                ),
              ),
              Form(
                key: _birthKey,
                autovalidate: false,
                child: ExpansionTile(
                    title: Text(
                      'Birth Information',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    children: <Widget>[
                      Text(
                        'Planned Birth Location',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Grady',
                          ),
                          controller: birthLocationCtrl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
                        child: Text(
                          'Current Birth Type',
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
                            hintText:
                                '"Singleton", "Twins", "Triplets", "more"',
                          ),
                          controller: birthTypeCtrl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
                        child: Text(
                          'Due Date',
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
                            hintText: '01/09/2020',
                          ),
                          controller: dueDateCtrl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
                        child: Text(
                          'Previous Delivery Types',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Vaginal Birth"),
                                Checkbox(
                                  value: previousVaginalBirth,
                                  onChanged: (bool value) {
                                    setState(() {
                                      previousVaginalBirth = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Cesaerean"),
                                Checkbox(
                                  value: previousCesarean,
                                  onChanged: (bool value) {
                                    setState(() {
                                      previousCesarean = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("VBAC"),
                                Checkbox(
                                  value: previousVbac,
                                  onChanged: (bool value) {
                                    setState(() {
                                      previousVbac = value;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Preterm"),
                                Checkbox(
                                  value: preterm,
                                  onChanged: (bool value) {
                                    setState(() {
                                      preterm = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Low Birth Weight"),
                                Checkbox(
                                  value: lowWeight,
                                  onChanged: (bool value) {
                                    setState(() {
                                      lowWeight = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Twins/Triplets"),
                                Checkbox(
                                  value: multiples,
                                  onChanged: (bool value) {
                                    setState(() {
                                      multiples = value;
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
                        child: Text(
                          'Current Birth Plan',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Epidural"),
                                Checkbox(
                                  value: epidural,
                                  onChanged: (bool value) {
                                    setState(() {
                                      epidural = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Cesarean (C-Section)"),
                                Checkbox(
                                  value: cesarean,
                                  onChanged: (bool value) {
                                    setState(() {
                                      cesarean = value;
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () async {
                            final form = _birthKey.currentState;
                            if (form.validate()) {
                              form.save();
                              String location =
                                  birthLocationCtrl.text.toString().trim();
                              String type =
                                  birthTypeCtrl.text.toString().trim();
                              String date = dueDateCtrl.text.toString().trim();

                              List<String> deliveries = List();
                              if (previousVaginalBirth) {
                                deliveries.add("vaginal");
                              }
                              if (previousCesarean) {
                                deliveries.add("cesarean");
                              }
                              if (previousVbac) {
                                deliveries.add("vbac");
                              }

                              updateBirthInformation(
                                  currentUser,
                                  location,
                                  type,
                                  date,
                                  deliveries,
                                  preterm,
                                  lowWeight,
                                  multiples,
                                  epidural,
                                  cesarean);
                              setState(() {});
                              await clientToDB();

                              //toClientSettings;
                            }
                          },
                          color: themeColors['yellow'],
                          textColor: Colors.black,
                          //padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['yellow'],
                          child: Text(
                            "Update Birth Information",
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
                      )
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

                      String clientEmail = emailCtrl.text.toString().trim();

                      if (clientEmail != currentUser.email) {

                        print(
                            'password: ${changeEmailPasswordCtrl.text.toString().trim()}');
                        if (changeEmailPasswordCtrl.text.toString().trim() !=
                            '') {
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
                      }


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
              ),
            ],
          ),
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
              vm.updateBirthInformation,
              vm.updateEmergencyContacts,
              vm.clientToDB,
              vm.toClientSettings,
            ));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toHome;
  VoidCallback logout;
  VoidCallback toClientSettings;

  void Function(Client, String, List<Phone>, String, bool) updateClientAccount;
  void Function(Client, String, String, String, List<String>, bool, bool, bool,
      bool, bool) updateBirthInformation;
  void Function(Client, List<EmergencyContact>) updateEmergencyContacts;
  Future<void> Function() clientToDB;

  ViewModel.build({
    @required this.currentUser,
    @required this.toHome,
    @required this.logout,
    @required this.updateClientAccount,
    @required this.updateBirthInformation,
    @required this.updateEmergencyContacts,
    @required this.clientToDB,
    @required this.toClientSettings,
  }) : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      toHome: () => dispatch(NavigateAction.pushNamed("/")),
      toClientSettings: () =>
          dispatch(NavigateAction.pushNamed("/clientSettings")),
      logout: () {
        print("logging out from settings");
        dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        dispatch(LogoutUserAction());
      },
      updateClientAccount: (Client user, String name, List<Phone> phones,
              String bday, bool photoRelease) =>
          dispatch(UpdateClientUserAction(
        user,
        name: name,
        phones: phones,
        bday: bday,
        photoRelease: photoRelease,
      )),
      updateBirthInformation: (Client user,
              String birthLocation,
              String birthType,
              String dueDate,
              List<String> deliveryTypes,
              bool preterm,
              bool lowWeight,
              bool multiples,
              bool epidural,
              bool cesarean) =>
          dispatch(UpdateClientUserAction(
        user,
        birthLocation: birthLocation,
        birthType: birthType,
        dueDate: dueDate,
        deliveryTypes: deliveryTypes,
        preterm: preterm,
        lowWeight: lowWeight,
        multiples: multiples,
        epidural: epidural,
        cesarean: cesarean,
      )),
      updateEmergencyContacts:
          (Client user, List<EmergencyContact> emergencyContacts) =>
              dispatch(UpdateClientUserAction(
        user,
        emergencyContacts: emergencyContacts,
      )),
      clientToDB: () => dispatchFuture(UpdateClientUserDocument()),
    );
  }
}
