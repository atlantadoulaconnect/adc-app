import 'common.dart';
import 'package:async_redux/async_redux.dart';

// returns menu based on the current user's user type
// If no user is logged in then it will return the New User menu

class CurrentMenu extends StatelessWidget {
  final String userType;
  final VoidCallback toHome;
  final VoidCallback toSignup;
  final VoidCallback toLogin;
  final VoidCallback toInfo;

  CurrentMenu(
      {this.userType, this.toHome, this.toSignup, this.toLogin, this.toInfo})
      : assert(userType != null);

  @override
  Widget build(BuildContext context) {
    Drawer userMenu;
    switch (userType) {
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
      default:
        {
          userMenu = newUserMenu();
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
                  onTap: () => toHome,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59679, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Request a Doula',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    IconData(59485, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Apply as a Doula',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {},
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

  Drawer clientMenu() {
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
                  onTap: () => toHome,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59679, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Request a Doula',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    IconData(59485, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Apply as a Doula',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {},
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

  Drawer doulaMenu() {
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
                  onTap: () => toHome,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59679, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Request a Doula',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    IconData(59485, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Apply as a Doula',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {},
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

  Drawer newUserMenu() {
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
                  onTap: () => toHome,
                ),
                ListTile(
                  leading: Icon(
                    IconData(59679, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Request a Doula',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    IconData(59485, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  title: Text('Apply as a Doula',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onTap: () {},
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
            userType: vm.userType,
          );
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  String userType;

  VoidCallback toHome;
  VoidCallback toSignup;
  VoidCallback toLogin;
  VoidCallback toInfo;

  ViewModel.build(
      {@required this.userType,
      this.toHome,
      this.toSignup,
      this.toLogin,
      this.toInfo})
      : super(equals: [userType]);

  @override
  ViewModel fromStore() {
    String currentUserType;
    if (state.currentUser == null) {
      currentUserType = "none";
    } else {
      currentUserType = state.currentUser.userType;
    }
    return ViewModel.build(
        userType: currentUserType,
        toHome: () => dispatch(NavigateAction.pushNamed("/")),
        toSignup: () => dispatch(NavigateAction.pushNamed("/signup")),
        toLogin: () => dispatch(NavigateAction.pushNamed("/toLogin")),
        toInfo: () => dispatch(NavigateAction.pushNamed("/toInfo")));
  }
}
