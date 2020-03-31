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

  @override
  void initState() {
    currentUser = widget.currentUser;
    super.initState();
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
          children: <Widget>[],
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
