import 'package:adc_app/backend/util/inputValidation.dart';
import 'common.dart';


// screen where users can change settings related to the TappableChipAttributes

class SettingsScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback toHome;
  final VoidCallback logout;
  final void Function(Doula, String, String, String, String, bool, bool, bool, String, int) updateDoulaAccount;
  final Future<void> Function(Doula) doulaToDB;
  final void Function(Client, String, String, String, bool) updateClientAccount;
  final Future<void> Function(Client) clientToDB;
  final void Function(Admin, String, String) updateAdminAccount;
  final Future<void> Function(Admin) adminToDB;

  SettingsScreen(this.currentUser, this.toHome, this.logout,
      this.updateDoulaAccount, this.doulaToDB,
      this.updateClientAccount, this.clientToDB,
      this.updateAdminAccount, this.adminToDB);
//      : assert(currentUser != null && toHome != null && logout != null);

  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<FormState> _settingsKey = GlobalKey<FormState>();
  void Function(Doula, String, String, String, String, bool, bool, bool, String, int) updateDoulaAccount;
  Future<void> Function(Doula) doulaToDB;
  void Function(Client, String, String, String, bool) updateClientAccount;
  Future<void> Function(Client) clientToDB;
  void Function(Admin, String, String) updateAdminAccount;
  Future<void> Function(Admin) adminToDB;

  VoidCallback toHome;

  User currentUser;

  TextEditingController firstNameCtrl;
  TextEditingController phoneNumCtrl;
  TextEditingController dateOfBirthCtrl;
  TextEditingController emailCtrl;
  TextEditingController bioCtrl;
  TextEditingController certProgramCtrl;
  TextEditingController birthsNeededCtrl;
  TextEditingController emergencyContactCtrl;
  TextEditingController newPasswordCtrl;

  //general
  String userName;
  String phone;
  String email;
  String dob;
  bool photoRelease = false;

  bool pushNotification = true;
  bool smsNotification = true;
  bool emailNotification = true;
  bool messagesNotification = true;


  //clients only
  bool matchWithDoulaNotification = true;
  bool statusReportNotification = true;
  List<EmergencyContact> emergencyContacts;

  //doulas only
  String bio = '';
  bool certified = false;
  bool certInProgress = false;
  String certProgram;
  int birthsNeeded;
  bool matchWithClientNotification = true;
  bool clientInLaborNotification = true;

  //admins only
  bool newAppNotification = true;

  @override
  void initState() {

    toHome = widget.toHome;
    currentUser = widget.currentUser;

    updateDoulaAccount = widget.updateDoulaAccount;
    doulaToDB = widget.doulaToDB;
    updateClientAccount = widget.updateClientAccount;
    clientToDB = widget.clientToDB;
    updateAdminAccount = widget.updateAdminAccount;
    adminToDB = widget.adminToDB;


    String userType = currentUser != null ? currentUser.userType : 'unlogged';

    if (currentUser != null) {
      userName = currentUser.name != null ? currentUser.name : '';
      phone = currentUser.phones != null ? currentUser.phones.toString().trim().substring(1,11) : '';
      email = currentUser.email != null ? currentUser.email : '';
    }

    if (userType == 'doula') {
      dob = (currentUser as Doula).bday;
      bio = (currentUser as Doula).bio;
      certified = (currentUser as Doula).certified;
      certInProgress = (currentUser as Doula).certInProgress;
      certProgram = (currentUser as Doula).certProgram;
      birthsNeeded = (currentUser as Doula).birthsNeeded != null ?
          (currentUser as Doula).birthsNeeded : 0;
      photoRelease = (currentUser as Doula).photoRelease != null ?
          (currentUser as Doula).photoRelease : false;
    }

    if (userType == 'client') {
      int contactSize = (currentUser as Client).emergencyContacts != null ?
      (currentUser as Client).emergencyContacts.length : 0 ;
      for(int i = 0; i < contactSize; i++) {
        emergencyContacts[i] = (currentUser as Client).emergencyContacts[i];
      }
      photoRelease = (currentUser as Client).photoRelease != null ?
      (currentUser as Client).photoRelease : false;
    }

    firstNameCtrl = new TextEditingController(text: userName);
    phoneNumCtrl = new TextEditingController(text: phone);
    dateOfBirthCtrl = new TextEditingController(text: dob);
    emailCtrl = new TextEditingController(text: email);
    bioCtrl = new TextEditingController(text: bio);
    certProgramCtrl = new TextEditingController(text: certProgram);
    birthsNeededCtrl = new TextEditingController(text: '0');

    super.initState();
  }

  @override
  void dispose() {
    //firstNameCtrl.dispose();
    super.dispose();
  }

  Form adminUser() {
    final adminCategoryExpansionTiles = List<Widget>();
    adminCategoryExpansionTiles.add(ExpansionTile(
      title: Text(
        'My Account',
        style: TextStyle(
          fontSize: 25,
        ),
      ),
      children: <Widget>[
      Text('Name',
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
        child: Text('Email Address',
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
      ]

    ));
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
            child: Text('Enter Current Password',
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
            child: Text('Enter New Password',
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
            child: Text('Confirm New Password',
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

        ]

    ));
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
              onChanged: (value){
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
              onChanged: (value){
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
              onChanged: (value){
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
              onChanged: (value){
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
              onChanged: (value){
                statusReportNotification = value;
              },
            ),
          ),
        ]

    ));
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

        ]

    ));
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
              side: BorderSide(color: themeColors['yellow'])),
          onPressed: () async {
            String adminName = firstNameCtrl.text.toString().trim();
            String adminEmail = emailCtrl.text.toString().trim();


            updateAdminAccount(currentUser, adminName,
                adminEmail);

            adminToDB(currentUser);
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
        child: ListView(
          children: adminCategoryExpansionTiles,
        ));
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
        Text('Name',
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
          child: Text('Phone Number',
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
          child: Text('Date of Birth',
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
          child: Text('Email Address',
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
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
          child: CheckboxListTile(
            value: photoRelease,
            title: Text("Photo Release Permission"),
            onChanged: (bool value) {
              setState(() { photoRelease = value; });
            },
          ),
        ),
      ]

    ));
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
            child: Text('Enter Current Password',
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
            child: Text('Enter New Password',
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
            child: Text('Confirm New Password',
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

        ]

    ));
    if (emergencyContacts == null) {
      clientCategoryExpansionTiles.add(ExpansionTile(
        title: Text ('Emergency Contacts',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ));
    } else {
      //TODO fix emergency contacts
      for (int i = 0; i < emergencyContacts.length; i++) {
        clientCategoryExpansionTiles.add(ExpansionTile(
          title: Text(
            emergencyContacts[i].toString(),
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ));

      }

    }
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
              onChanged: (value){
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
              onChanged: (value){
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
              onChanged: (value){
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
              onChanged: (value){
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
              onChanged: (value){
                statusReportNotification = value;
              },
            ),
          ),
        ]

    ));
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
              onChanged: (value){

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text('Link to Privacy Policy goes here'),

          ),

        ]

    ));
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
        ]

    ));
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
        ]

    ));
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
                  side: BorderSide(color: themeColors['yellow'])),
              onPressed: () async {

                String clientName = firstNameCtrl.text.toString().trim();
                String clientBday = dateOfBirthCtrl.text.toString().trim();
                String clientEmail = emailCtrl.text.toString().trim();


                updateClientAccount(currentUser, clientName,
                    clientBday, clientEmail, photoRelease);

                clientToDB(currentUser);
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
        child: ListView(
          children: clientCategoryExpansionTiles,
        ));
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
        Text('Name',
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
          child: Text('Phone Number',
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
          child: Text('Date of Birth',
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
          child: Text('Email Address',
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
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text('Bio',
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
              setState(() { photoRelease = value; });
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
            child: Text('Enter Current Password',
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
            child: Text('Enter New Password',
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
            child: Text('Confirm New Password',
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

        ]

    ));
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
              setState(() { certified = value; });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 2),
          child: CheckboxListTile(
            value: certInProgress,
            title: Text("Working towards certification?"),
            onChanged: (bool value) {
              setState(() { certInProgress = value; });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
          child: Text('Certification Program',
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
                Text(
                  'Births Needed for Certification:'
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '0'
                      ),
                      controller: birthsNeededCtrl,
                    ),
                  ),
                ),
              ]
          ),
        ),
      ]

    ));
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
              onChanged: (value){
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
            onChanged: (value){
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
            onChanged: (value){
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
            onChanged: (value){
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
            onChanged: (value){
              clientInLaborNotification = value;
            },
          ),
        ),
    ]

    ));
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
              onChanged: (value){

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
            child: Text('Link to Privacy Policy goes here'),

          ),

        ]

    ));
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
        ]

    ));
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
        ]

    ));
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
            print(bioCtrl.text.toString());
            String doulaBio = bioCtrl.text.toString();
            certProgram = certProgramCtrl.text.toString();
            print('certProgram: $certProgram');

            print('birthsNeededCtrl: $birthsNeededCtrl');
            birthsNeeded = int.parse(birthsNeededCtrl.text.toString().trim()) != null ?
              int.parse(birthsNeededCtrl.text.toString().trim()) : 0;
            print('birthsneeded: $birthsNeeded');
            updateDoulaAccount(currentUser, doulaName,
                doulaBday, doulaEmail, doulaBio, photoRelease, certified, certInProgress,
                certProgram, birthsNeeded);

            doulaToDB(currentUser);

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
          children:
            doulaCategoryExpansionTiles
        ),

    );
  }

  // settings page for user without a user type (someone who logged out before choosing user type)
//  Form newUser() {
//
//
//    return Form(
//        key: _settingsKey,
//        autovalidate: false,
//        child: ListView(
//          children: <Widget>[],
//        ));
//  }

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
        ]

    ));
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
        ]

    ));
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
        ]

    ));
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

    String userType = currentUser != null ? currentUser.userType : "null";

    switch (userType) {
      case "admin":
        {
          settingsForm = adminUser();
        }
        break;
      case "client":
        {
          settingsForm = clientUser();
        }
        break;
      case "doula":
        {
          settingsForm = doulaUser();
        }
        break;
//      case "none":
//        {
//          // user has created account but not chosen a user type
//          settingsForm = newUser();
//        }
        break;
      default:
        {
          // not logged in or new user without a type
          settingsForm = unlogged();
        }
        break;
    }

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
        builder: (BuildContext context, ViewModel vm) =>
            SettingsScreen(vm.currentUser, vm.toHome, vm.logout,
                vm.updateDoulaAccount, vm.doulaToDB,
                vm.updateClientAccount, vm.clientToDB,
                vm.updateAdminAccount, vm.adminToDB));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toHome;
  VoidCallback logout;
  void Function(Doula, String, String, String, String, bool, bool, bool, String, int) updateDoulaAccount;
  Future<void> Function(Doula) doulaToDB;
  void Function(Client, String, String, String, bool) updateClientAccount;
  Future<void> Function(Client) clientToDB;
  void Function(Admin, String, String) updateAdminAccount;
  Future<void> Function(Admin) adminToDB;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toHome,
      @required this.logout,
      @required this.updateDoulaAccount, this.doulaToDB,
      @required this.updateClientAccount, this.clientToDB,
      @required this.updateAdminAccount, this.adminToDB,
      })
      : super(equals: [currentUser]);

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
      updateDoulaAccount: (
        Doula user,
        String name,
        String bday,
        String email,
        String bio,
        bool photoRelease,
        bool certified,
        bool certInProgress,
        String certProgram,
        int birthsNeeded
      ) =>
          dispatch(UpdateDoulaUserAction(
            user,
            name: name,
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

      updateClientAccount: (
        Client user,
          String name,
          String bday,
          String email,
          bool photoRelease
      ) => dispatch(UpdateClientUserAction(
            user,
            name: name,
            bday: bday,
            email: email,
            photoRelease: photoRelease,
      )),
      clientToDB: (Client user) => dispatchFuture(UpdateClientUserDocument(user)),

      updateAdminAccount: (
        Admin user,
          String name,
          String email,
      ) => dispatch(UpdateAdminUserAction(
        user,
        name: name,
        email: email,
      )),
      adminToDB: (Admin user) => dispatchFuture(UpdateAdminUserDocument(user)),

    );
  }
}
