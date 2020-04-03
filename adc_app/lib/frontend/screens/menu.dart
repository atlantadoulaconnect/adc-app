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
  final VoidCallback toRecentMessages;
  final VoidCallback toDoulas;
  final VoidCallback logout;
  final VoidCallback toAdminHome;
  final VoidCallback toClientHome;
  final VoidCallback toDoulaHome;
  final VoidCallback toSettings;
  final VoidCallback toStatusScreen;

  CurrentMenu(
      {this.currentUser,
      this.toHome,
      this.toSignup,
      this.toLogin,
      this.toInfo,
      this.toRecentMessages,
      this.toDoulas,
      this.logout,
      this.toAdminHome,
      this.toClientHome,
      this.toDoulaHome,
      this.toSettings,
      this.toStatusScreen});

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

    print("Menu got user type: $currentUserType");

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
                    IconData(59530, fontFamily: 'MaterialIcons'),
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
                    IconData(57545, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Messages',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toRecentMessages,
                ),
                ListTile(
                  leading: Icon(
                    IconData(57545, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Doulas',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toDoulas,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59448, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59534, fontFamily: 'MaterialIcons'),
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
                    IconData(59576, fontFamily: 'MaterialIcons'),
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
                    IconData(59513, fontFamily: 'MaterialIcons'),
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
                    IconData(59530, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toClientHome,
                ),
                ListTile(
                  leading: Icon(
                    IconData(57545, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Messages',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toRecentMessages,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59448, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59534, fontFamily: 'MaterialIcons'),
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
                    IconData(59576, fontFamily: 'MaterialIcons'),
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
                    IconData(59513, fontFamily: 'MaterialIcons'),
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
                ListTile(
                  leading: Icon(
                    IconData(59448, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Applications',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () => toStatusScreen,
                ),
              ],
            )));
  }

  Drawer doulaMenu() {
    print("doula menu");
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
                    IconData(59530, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toDoulaHome,
                ),
                ListTile(
                  leading: Icon(
                    IconData(57545, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Messages',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toRecentMessages,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59448, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59534, fontFamily: 'MaterialIcons'),
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
                    IconData(59576, fontFamily: 'MaterialIcons'),
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
                    IconData(59513, fontFamily: 'MaterialIcons'),
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
                    IconData(59530, fontFamily: 'MaterialIcons'),
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
                    IconData(57545, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Messages',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: toRecentMessages,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59448, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59534, fontFamily: 'MaterialIcons'),
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
                    IconData(59576, fontFamily: 'MaterialIcons'),
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
                    IconData(59513, fontFamily: 'MaterialIcons'),
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
                ListTile(
                  leading: Icon(
                    IconData(59448, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Applications',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {
                    print("to app status screen pressed menu");
                    toStatusScreen();
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
                    IconData(59530, fontFamily: 'MaterialIcons'),
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
                    IconData(59448, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Frequently asked Questions',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    IconData(59534, fontFamily: 'MaterialIcons'),
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
                    IconData(59485, fontFamily: 'MaterialIcons'),
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
                    IconData(59576, fontFamily: 'MaterialIcons'),
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
                    IconData(59513, fontFamily: 'MaterialIcons'),
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
            toRecentMessages: vm.toRecentMessages,
            toDoulas: vm.toDoulas,
            logout: vm.logout,
            toAdminHome: vm.toAdminHome,
            toClientHome: vm.toClientHome,
            toDoulaHome: vm.toDoulaHome,
            toSettings: vm.toSettings,
            toStatusScreen: vm.toStatusScreen,
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
  VoidCallback toRecentMessages;
  VoidCallback toDoulas;
  VoidCallback logout;
  VoidCallback toAdminHome;
  VoidCallback toClientHome;
  VoidCallback toDoulaHome;
  VoidCallback toSettings;
  VoidCallback toStatusScreen;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toHome,
      @required this.toSignup,
      @required this.toLogin,
      @required this.toInfo,
      @required this.toRecentMessages,
      @required this.toDoulas,
      @required this.logout,
      @required this.toAdminHome,
      @required this.toClientHome,
      @required this.toDoulaHome,
      @required this.toSettings,
      @required this.toStatusScreen})
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
        toRecentMessages: () =>
            dispatch(NavigateAction.pushNamed("/recentMessages")),
        toDoulas: () => dispatch(NavigateAction.pushNamed("/registeredDoulas")),
        logout: () {
          print("logging out from menu");
          dispatch(LogoutUserAction());
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        },
        toAdminHome: () => dispatch(NavigateAction.pushNamed("/adminHome")),
        toClientHome: () => dispatch(NavigateAction.pushNamed("/clientHome")),
        toDoulaHome: () => dispatch(NavigateAction.pushNamed("/doulaHome")),
        toSettings: () => dispatch(NavigateAction.pushNamed("/settings")),
        toStatusScreen: () => dispatch(NavigateAction.pushNamed("/status")));
  }
}
