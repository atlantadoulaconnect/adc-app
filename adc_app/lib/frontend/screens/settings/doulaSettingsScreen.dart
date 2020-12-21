import 'package:adc_app/backend/actions/common.dart';
import 'package:adc_app/backend/util/inputValidation.dart';
import '../common.dart';
import 'package:table_calendar/table_calendar.dart';

// screen where users can change settings related to the TappableChipAttributes

class DoulaSettingsScreen extends StatefulWidget {
  final Doula currentUser;
  final VoidCallback logout;
  final VoidCallback toConfirmSettings;
  final void Function(String, List<Phone>, String, String, bool)
      updateDoulaAccount;
  final void Function(bool, bool, String, int) updateCertification;
  final void Function(List<String>) updateDoulaAvailability;
  final void Function(String) updateEmail;
  final Future<void> Function() doulaToDB;

  DoulaSettingsScreen(
      this.currentUser,
      this.toConfirmSettings,
      this.logout,
      this.updateDoulaAccount,
      this.updateCertification,
      this.updateDoulaAvailability,
      this.updateEmail,
      this.doulaToDB);

  @override
  State<StatefulWidget> createState() => DoulaSettingsScreenState();
}

class DoulaSettingsScreenState extends State<DoulaSettingsScreen> {
  void Function(String, List<Phone>, String, String, bool) updateDoulaAccount;
  void Function(bool, bool, String, int) updateCertification;
  void Function(List<String>) updateDoulaAvailability;
  Future<void> Function() doulaToDB;
  void Function(String) updateEmail;

  VoidCallback toConfirmSettings;

  Doula currentUser;

  final CalendarController calendarController = new CalendarController();
  List<DateTime> unavailableDates;

  final GlobalKey<FormState> _accountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pwdKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _certKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _availabilityKey = GlobalKey<FormState>();
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
    toConfirmSettings = widget.toConfirmSettings;
    currentUser = widget.currentUser;

    updateDoulaAccount = widget.updateDoulaAccount;
    updateCertification = widget.updateCertification;
    updateDoulaAvailability = widget.updateDoulaAvailability;
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

      unavailableDates = List<DateTime>();
      if (currentUser.availableDates != null) {
        // formats dates
        for (String s in currentUser.availableDates) {
          s = s.replaceAll('-', '');
          if (s.length == 7) {
            s = s.substring(0, 6) + '0' + s.substring(6);
          }

          DateTime temp = DateTime.parse(s);
          temp = temp.add(Duration(hours: 8));
          unavailableDates.add(temp.toUtc());
        }
      }
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
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
          ],
        );
      },
    );
  }

  updateAccountDialog(BuildContext context, String code) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(code),
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
    TableCalendar myCal = TableCalendar(
      calendarController: calendarController,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      calendarStyle: CalendarStyle(),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      startDay: DateTime.now(),
      onDaySelected: (date, events, holidays) {
        setState(() {
          if (unavailableDates.contains(date.toUtc())) {
            unavailableDates.remove(date);
          } else {
            unavailableDates.add(date.toUtc());
          }
        });
      },
      builders: CalendarBuilders(
        dayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
            ),
            decoration: BoxDecoration(
              color: unavailableDates.contains(date.toUtc())
                  ? themeColors["gold"]
                  : themeColors["lightGrey"],
              shape: BoxShape.circle,
            ),
          );
        },
        outsideDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["coolGray5"]),
            ),
          );
        },
        outsideHolidayDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["coolGray5"]),
            ),
          );
        },
        outsideWeekendDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["coolGray5"]),
            ),
          );
        },
        unavailableDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["coolGray5"]),
            ),
          );
        },
        weekendDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["black"]),
            ),
            decoration: BoxDecoration(
              color: unavailableDates.contains(date.toUtc())
                  ? themeColors["gold"]
                  : themeColors["lightGrey"],
              shape: BoxShape.circle,
            ),
          );
        },
        todayDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(
                  color: themeColors["mediumBlue"],
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
              color: unavailableDates.contains(date.toUtc())
                  ? themeColors["gold"]
                  : themeColors["lightGrey"],
              shape: BoxShape.circle,
            ),
          );
        },
        selectedDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(
                color: themeColors["black"],
              ),
            ),
            decoration: BoxDecoration(
              color: unavailableDates.contains(date.toUtc())
                  ? themeColors["gold"]
                  : themeColors["lightGrey"],
              shape: BoxShape.circle,
              border: Border.all(color: themeColors["mediumBlue"], width: 2.0),
            ),
          );
        },
      ),
    );

    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        drawer: Menu(),
        body: Center(
          child: ListView(
            children: <Widget>[
              Form(
                  key: _accountKey,
                  autovalidateMode: AutovalidateMode.disabled,
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
                                  firstNameCtrl.text.toString().trim(),
                                  phones,
                                  dateOfBirthCtrl.text.toString().trim(),
                                  bioCtrl.text.toString(),
                                  photoRelease);
                              print('name after update: ${currentUser.name}');

                              await doulaToDB();
                              updateAccountDialog(context,
                                  'Your account was updated successfully');
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
                autovalidateMode: AutovalidateMode.disabled,
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
                autovalidateMode: AutovalidateMode.disabled,
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
                            final form = _emailKey.currentState;
                            form.save();
                            String newDoulaEmail =
                                emailCtrl.text.toString().trim();

                            if (form.validate() &&
                                newDoulaEmail != currentUser.email) {
                              // form validation and sanity check
                              String doulaPassword = changeEmailPasswordCtrl
                                  .text
                                  .toString()
                                  .trim();
                              print(
                                  'new email: $newDoulaEmail  pw: $doulaPassword');

                              try {
                                AuthResult result = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: currentUser.email,
                                        password: doulaPassword);
                                FirebaseUser user = result.user;
                                print('user: $user');
                                String userId = user.uid;
                                print('userId: $userId');

                                user.updateEmail(newDoulaEmail);
                                updateEmail(newDoulaEmail);
                                await doulaToDB();
                                print(
                                    "Email was changed to: ${emailCtrl.text.toString().trim()}");
                                updateAccountDialog(context,
                                    'Your account was updated successfully!');
                              } on Exception catch (e) {
                                print('its coming here: $e');
                                String error = e.toString();
                                updateAccountDialog(
                                    context,
                                    error.substring(error.indexOf(',') + 1,
                                        error.lastIndexOf(',')));
                              }
                            }
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
                autovalidateMode: AutovalidateMode.disabled,
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

                              try {
                                updateCertification(certified, certInProgress,
                                    programName, numOfBirths);
                                await doulaToDB();
                                updateAccountDialog(context,
                                    'Your account was updated successfully');
                              } on Exception catch (e) {
                                String error = e.toString();
                                updateAccountDialog(
                                    context,
                                    error.substring(error.indexOf(',') + 1,
                                        error.lastIndexOf(',')));
                              }
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
                key: _availabilityKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: ExpansionTile(
                    title: Text(
                      'Availability',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 8, 8, 2),
                        child: Text(
                          'Please select the dates when you \nare NOT available:',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 350,
                            width: 320,
                            color: themeColors["lightGrey"],
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: myCal,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              side: BorderSide(color: themeColors['yellow'])),
                          onPressed: () async {
                            final form = _availabilityKey.currentState;
                            if (form.validate()) {
                              form.save();
                              unavailableDates.sort();
                              List<String> unavailableDatesAsString =
                                  new List<String>();
                              for (DateTime d in unavailableDates) {
                                unavailableDatesAsString
                                    .add(formatDateYYYYMMDD(d));
                              }
                              currentUser.availableDates =
                                  unavailableDatesAsString;

                              updateDoulaAvailability(unavailableDatesAsString);

                              await doulaToDB();
                              updateAccountDialog(context,
                                  "Your account was updated successfully");
                            }
                          },
                          color: themeColors['yellow'],
                          textColor: Colors.black,
                          //padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['yellow'],
                          child: Text(
                            "Update Availability",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          //onPressed: ,
                        ),
                      )
                    ]),
              ),
              Form(
                key: _notificationsKey,
                autovalidateMode: AutovalidateMode.disabled,
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
                          title: Text('Client is in Labor'),
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
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
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
            vm.toConfirmSettings,
            vm.logout,
            vm.updateDoulaAccount,
            vm.updateCertification,
            vm.updateDoulaAvailability,
            vm.updateEmail,
            vm.doulaToDB));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  VoidCallback toConfirmSettings;
  VoidCallback logout;
  void Function(String, List<Phone>, String, String, bool) updateDoulaAccount;
  void Function(bool, bool, String, int) updateCertification;
  void Function(List<String>) updateDoulaAvailability;
  void Function(String) updateEmail;
  Future<void> Function() doulaToDB;

  ViewModel.build({
    @required this.currentUser,
    @required this.toConfirmSettings,
    @required this.logout,
    @required this.updateDoulaAccount,
    @required this.updateCertification,
    @required this.updateDoulaAvailability,
    @required this.updateEmail,
    this.doulaToDB,
  }) : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser as Doula,
      toConfirmSettings: () =>
          dispatch(NavigateAction.pushNamed("/confirmSettings")),
      logout: () {
        print("logging out from settings");
        dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        dispatch(LogoutUserAction());
      },
      updateDoulaAccount: (String name, List<Phone> phones, String bday,
              String bio, bool photoRelease) =>
          dispatch(UpdateDoulaUserAction(
        name: name,
        phones: phones,
        bday: bday,
        bio: bio,
        photoRelease: photoRelease,
      )),
      updateCertification: (bool certified, bool certInProgress,
              String certProgram, int birthsNeeded) =>
          dispatch(UpdateDoulaUserAction(
              certified: certified,
              certInProgress: certInProgress,
              certProgram: certProgram,
              birthsNeeded: birthsNeeded)),
      updateDoulaAvailability: (List<String> availableDates) =>
          dispatch(UpdateDoulaUserAction(availableDates: availableDates)),
      updateEmail: (String email) =>
          dispatch(UpdateDoulaUserAction(email: email)),
      doulaToDB: () => dispatchFuture(UpdateDoulaUserDocument()),
    );
  }
}
