import 'common.dart';

// Profile screen of ANOTHER user

class UserProfileScreen extends StatefulWidget {
  final User profileUser;

  // determines what part of another user's profile they can view/interact with
  // if profileUser.userid == currentUser.userid then user is viewing their own
  // profile and can edit it
  final User currentUser;

  UserProfileScreen(this.profileUser, this.currentUser)
      : assert(profileUser != null && currentUser != null);

  @override
  State<StatefulWidget> createState() {
    return UserProfileScreenState();
  }
}

class UserProfileScreenState extends State<UserProfileScreen> {
  User profileUser;
  User currentUser;

  @override
  void initState() {
    profileUser = widget.profileUser;
    currentUser = widget.currentUser;
    super.initState();
  }

  ListView adminUser() {}

  ListView clientUser() {}

  ListView doulaUser() {}

  // does a user get a profile when they haven't chosen a user type yet?

  @override
  Widget build(BuildContext context) {
    ListView listview;

    String userType = currentUser != null ? currentUser.userType : "null";

    switch (userType) {
      case "admin":
        {
          listview = adminUser();
        }
        break;
      case "client":
        {
          listview = clientUser();
        }
        break;
      case "doula":
        {
          listview = doulaUser();
        }
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(12.0), child: listview),
      ),
    );
  }
}

class UserProfileScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) =>
            UserProfileScreen(vm.profileUser, vm.currentUser));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User profileUser;
  User currentUser;

  ViewModel.build({@required this.profileUser, @required this.currentUser})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        profileUser: state.profileUser, currentUser: state.currentUser);
  }
}
