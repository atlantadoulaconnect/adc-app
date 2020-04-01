import 'package:adc_app/backend/util/inputValidation.dart';
import 'common.dart';


// screen where users can change settings related to the TappableChipAttributes

class SettingsScreen extends StatefulWidget {
  final User currentUser;
  final VoidCallback toUserProfile;
  final VoidCallback logout;

  SettingsScreen(this.currentUser, this.toUserProfile, this.logout);
//      : assert(currentUser != null && toUserProfile != null && logout != null);

  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<FormState> _settingsKey = GlobalKey<FormState>();
  User currentUser;

  TextEditingController firstNameCtrl;
  TextEditingController phoneNumCtrl;
  TextEditingController dateOfBirthCtrl;
  TextEditingController emailCtrl;
  TextEditingController bioCtrl;
  TextEditingController certProgramCtrl;



  //general
  String userName;
  String phone;
  String email;
  String dob;


  //clients only
  String emergencyContacts = '';

  //doulas only
  String bio = '';
  bool certified = false;
  bool certInProgress = false;
  String certProgram;





  @override
  void initState() {

    currentUser = widget.currentUser;
    String userType = currentUser.userType;

    userName = currentUser.name != null ? currentUser.name : '';
    phone = currentUser.phones != null ? currentUser.phones.toString().substring(1,9) : '';
    email = currentUser.email != null ? currentUser.email : '';

    if (userType == 'doula') {
      dob = (currentUser as Doula).bday;
      bio = (currentUser as Doula).bio;
      certified = (currentUser as Doula).certified;
      certInProgress = (currentUser as Doula).certInProgress;
      certProgram = (currentUser as Doula).certProgram;
    }



    String availabity;

    //admins only

    firstNameCtrl = new TextEditingController(text: userName);
    phoneNumCtrl = new TextEditingController(text: phone);
    dateOfBirthCtrl = new TextEditingController(text: dob);
    emailCtrl = new TextEditingController(text: email);
    bioCtrl = new TextEditingController(text: bio);
    certProgramCtrl = new TextEditingController(text: certProgram);
    super.initState();
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    super.dispose();
  }

  Form adminUser() {
    return Form(
        key: _settingsKey,
        autovalidate: false,
        child: ListView(
          children: <Widget>[],
        ));
  }

  Form clientUser() {
    return Form(
        key: _settingsKey,
        autovalidate: false,
        child: ListView(
          children: <Widget>[],
        ));
  }

  Form doulaUser() {
    return Form(
        key: _settingsKey,
        autovalidate: false,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'My Account',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['emoryBlue'],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 2),
              child: Text('Name',
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Certification',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['emoryBlue'],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
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
          ],
        ));
  }

  // settings page for user without a user type (someone who logged out before choosing user type)
  Form newUser() {
    return Form(
        key: _settingsKey,
        autovalidate: false,
        child: ListView(
          children: <Widget>[],
        ));
  }

  // settings page for user that is not logged in
  Form unlogged() {
    return Form(
        key: _settingsKey,
        autovalidate: false,
        child: ListView(
          children: <Widget>[],
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
      case "none":
        {
          // user has created account but not chosen a user type
          settingsForm = newUser();
        }
        break;
      default:
        {
          // not logged in
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
            SettingsScreen(vm.currentUser, vm.toUserProfile, vm.logout));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toUserProfile;
  VoidCallback logout;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toUserProfile,
      @required this.logout})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toUserProfile: () => dispatch(NavigateAction.pushNamed("/myProfile")),
        logout: () {
          print("logging out from settings");
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          dispatch(LogoutUserAction());
        });
  }
}
