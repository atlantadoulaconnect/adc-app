import 'common.dart';
import 'package:async_redux/async_redux.dart';

// returns menu based on the current user's user type
// If no user is logged in then it will return the New User menu

class CurrentMenu extends StatelessWidget {
  final User currentUser;
  final VoidCallback toHome;
  final VoidCallback toSignup;
  final VoidCallback toLogin;
  final VoidCallback toInfo;
  final VoidCallback toDoulas;
  final VoidCallback toClients;
  final VoidCallback logout;
  final VoidCallback toAdminHome;
  final VoidCallback toClientHome;
  final VoidCallback toDoulaHome;
  final VoidCallback toSettings;
  final VoidCallback toClientSettings;
  final VoidCallback toDoulaSettings;
  final VoidCallback toAdminSettings;
  final VoidCallback toClientApplication;
  final VoidCallback toDoulaApplication;
  final VoidCallback toAppType;

  CurrentMenu(
      {this.currentUser,
      this.toHome,
      this.toSignup,
      this.toLogin,
      this.toInfo,
      this.toDoulas,
      this.toClients,
      this.logout,
      this.toAdminHome,
      this.toClientHome,
      this.toDoulaHome,
      this.toSettings,
      this.toClientSettings,
      this.toDoulaSettings,
      this.toAdminSettings,
      this.toClientApplication,
      this.toDoulaApplication,
      this.toAppType});

  @override
  Widget build(BuildContext context) {
    Drawer userMenu;

    String currentUserType;
    if (currentUser == null) {
      // user not logged in
      currentUserType = "null";
    } else if (currentUser.userType == null) {
      currentUserType = "none";
    } else {
      currentUserType = currentUser.userType;
    }

    switch (currentUserType) {
      case "admin":
        {
          userMenu = adminMenu();
        }
        break;
      case "client":
        {
          userMenu = clientMenu();
        }
        break;
      case "doula":
        {
          userMenu = doulaMenu();
        }
        break;
      case "none":
        {
          userMenu = noTypeMenu();
        }
        break;
      default:
        {
          userMenu = unloggedMenu();
        }
        break;
    }

    return userMenu;
  }

  Drawer adminMenu() {
    return Drawer(
        child: Container(
            color: themeColors["mediumBlue"],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: themeColors['yellow'],
                    ),
                    child: Text("Welcome, Admin")),
                ListTile(
                  leading: Icon(
                    IconData(59322, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toAdminHome,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59637, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('All Doulas',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toDoulas,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59722, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('All Clients',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toClients,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59938, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59354, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('About Atlanta Doula Connect',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toInfo,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59846, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Settings',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toAdminSettings,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59407, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Feedback',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    // logout();
                    //toHome();
                  },
                ),
                ListTile(
                  leading: Icon(
                    IconData(59464, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Log Out',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    logout();
                    //toHome();
                  },
                ),
              ],
            )));
  }

  Drawer clientMenu() {
    print("client menu");
    return Drawer(
        child: Container(
            color: themeColors["mediumBlue"],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: themeColors['yellow'],
                    ),
                    child: Text("Welcome, Client")),
                ListTile(
                  leading: Icon(
                    IconData(59322, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toClientHome,
                ),
                Visibility(
                  visible: (currentUser.status == null ||
                          currentUser.status == "incomplete") &&
                      !(currentUser as Client).completedApplication(),
                  child: ListTile(
                    leading: Icon(
                      IconData(58810, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ),
                    title: Text('Continue Application',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onTap: () {
                      toClientApplication();
                      //toHome();
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59938, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently Asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59354, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('About Atlanta Doula Connect',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toInfo,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59846, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Settings',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: (currentUser as Client).completedApplication() == true
                      ? toClientSettings
                      : toSettings,
                ),
                ListTile(
                  leading: Icon(
                    IconData(57443, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Feedback',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    // logout();
                    //toHome();
                  },
                ),
                ListTile(
                  leading: Icon(
                    IconData(59464, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Log Out',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    logout();
                    //toHome();
                  },
                ),
              ],
            )));
  }

  Drawer doulaMenu() {
    print("init user status: ${currentUser.status}");
    return Drawer(
        child: Container(
            color: themeColors["mediumBlue"],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: themeColors['yellow'],
                    ),
                    child: Text("Welcome, Doula")),
                ListTile(
                  leading: Icon(
                    IconData(59322, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toDoulaHome,
                ),
                Visibility(
                  visible: (currentUser.status == null ||
                          currentUser.status == "incomplete") &&
                      !(currentUser as Doula).completedApplication(),
                  child: ListTile(
                    leading: Icon(
                      IconData(58810, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ),
                    title: Text('Continue Application',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onTap: () {
                      toDoulaApplication();
                      //toHome();
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59938, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59354, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('About Atlanta Doula Connect',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toInfo,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59846, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Settings',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: (currentUser as Doula).status != 'incomplete'
                      ? toDoulaSettings
                      : toSettings,
                ),
                ListTile(
                  leading: Icon(
                    IconData(57443, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Feedback',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    // logout();
                    //toHome();
                  },
                ),
                ListTile(
                  leading: Icon(
                    IconData(59464, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Log Out',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    logout();
                    //toHome();
                  },
                ),
              ],
            )));
  }

  Drawer noTypeMenu() {
    print("no type menu");
    return Drawer(
        child: Container(
            color: themeColors["mediumBlue"],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: themeColors['yellow'],
                    ),
                    child: Text("Welcome")),
                ListTile(
                  leading: Icon(
                    IconData(59322, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toHome,
                ),
                ListTile(
                  leading: Icon(
                    IconData(58810, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Start Application',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    toAppType();
                    //toHome();
                  },
                ),
                ListTile(
                  leading: Icon(
                    IconData(59938, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59354, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('About Atlanta Doula Connect',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toInfo,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59846, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Settings',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toSettings,
                ),
                ListTile(
                  leading: Icon(
                    IconData(57443, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Feedback',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    // logout();
                    //toHome();
                  },
                ),
                ListTile(
                  leading: Icon(
                    IconData(59464, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Log Out',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    logout();
                    //toHome();
                  },
                ),
              ],
            )));
  }

  Drawer unloggedMenu() {
    print("unlogged menu");
    return Drawer(
        child: Container(
            color: themeColors["mediumBlue"],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: themeColors['yellow'],
                    ),
                    child: Text("Welcome")),
                ListTile(
                  leading: Icon(
                    IconData(59322, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    toHome();
                  },
                ),
                ListTile(
                  leading: Icon(
                    IconData(59938, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59354, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('About Atlanta Doula Connect',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toInfo,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59651, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Signup',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toSignup,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59846, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Settings',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toSettings,
                ),
                ListTile(
                  leading: Icon(
                    IconData(57443, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Feedback',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    // logout();
                    //toHome();
                  },
                ),
                ListTile(
                  leading: Icon(
                    IconData(59463, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Log In',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toLogin,
                ),
              ],
            )));
  }
}

// connector class that's called by all the screens
class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) {
          return CurrentMenu(
            currentUser: vm.currentUser,
            toHome: vm.toHome,
            toSignup: vm.toSignup,
            toLogin: vm.toLogin,
            toInfo: vm.toInfo,
            toDoulas: vm.toDoulas,
            toClients: vm.toClients,
            logout: vm.logout,
            toAdminHome: vm.toAdminHome,
            toClientHome: vm.toClientHome,
            toDoulaHome: vm.toDoulaHome,
            toSettings: vm.toSettings,
            toClientSettings: vm.toClientSettings,
            toDoulaSettings: vm.toDoulaSettings,
            toAdminSettings: vm.toAdminSettings,
            toClientApplication: vm.toClientApplication,
            toDoulaApplication: vm.toDoulaApplication,
            toAppType: vm.toAppType,
          );
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toHome;
  VoidCallback toSignup;
  VoidCallback toLogin;
  VoidCallback toInfo;
  VoidCallback toDoulas;
  VoidCallback toClients;
  VoidCallback logout;
  VoidCallback toAdminHome;
  VoidCallback toClientHome;
  VoidCallback toDoulaHome;
  VoidCallback toSettings;
  VoidCallback toClientSettings;
  VoidCallback toDoulaSettings;
  VoidCallback toAdminSettings;
  VoidCallback toClientApplication;
  VoidCallback toDoulaApplication;
  VoidCallback toAppType;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toHome,
      @required this.toSignup,
      @required this.toLogin,
      @required this.toInfo,
      @required this.toDoulas,
      @required this.toClients,
      @required this.logout,
      @required this.toAdminHome,
      @required this.toClientHome,
      @required this.toDoulaHome,
      @required this.toSettings,
      @required this.toClientSettings,
      @required this.toDoulaSettings,
      @required this.toAdminSettings,
      @required this.toClientApplication,
      @required this.toDoulaApplication,
      @required this.toAppType})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toHome: () {
          dispatch(NavigateAction.pushNamed("/"));
        },
        toSignup: () => dispatch(NavigateAction.pushNamed("/signup")),
        toLogin: () => dispatch(NavigateAction.pushNamed("/login")),
        toInfo: () => dispatch(NavigateAction.pushNamed("/info")),
        toDoulas: () => dispatch(NavigateAction.pushNamed("/registeredDoulas")),
        toClients: () =>
            dispatch(NavigateAction.pushNamed("/registeredClients")),
        logout: () {
          dispatch(LogoutUserAction());
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        },
        toAdminHome: () => dispatch(NavigateAction.pushNamed("/adminHome")),
        toClientHome: () => dispatch(NavigateAction.pushNamed("/clientHome")),
        toDoulaHome: () => dispatch(NavigateAction.pushNamed("/doulaHome")),
        toSettings: () => dispatch(NavigateAction.pushNamed("/settings")),
        toClientSettings: () =>
            dispatch(NavigateAction.pushNamed("/clientSettings")),
        toDoulaSettings: () =>
            dispatch(NavigateAction.pushNamed("/doulaSettings")),
        toAdminSettings: () =>
            dispatch(NavigateAction.pushNamed("/adminSettings")),
        toClientApplication: () =>
            dispatch(NavigateAction.pushNamed("/cp1PersonalInfo")),
        toDoulaApplication: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppPage1")),
        toAppType: () => dispatch(NavigateAction.pushNamed("/appType")));
  }
}
