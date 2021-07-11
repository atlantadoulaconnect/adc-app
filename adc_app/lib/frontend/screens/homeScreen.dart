import 'package:adc_app/frontend/screens/application/appTypeScreen.dart';

import './common.dart';
import 'package:async_redux/async_redux.dart';
import './admin/adminHomeScreen.dart';
import './client/clientHomeScreen.dart';
import './doula/doulaHomeScreen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback toSignup;
  final VoidCallback toLogin;
  final VoidCallback toInfo;

  HomeScreen({this.toSignup, this.toLogin, this.toInfo})
      : assert(toSignup != null && toLogin != null && toInfo != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: Menu(),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Center(
          child: Column(children: <Widget>[
            NotificationHandler(),
            Spacer(flex: 1),
            Text("Atlanta Doula Connect",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                )),
            Spacer(flex: 1),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: themeColors['lightBlue'])),
              onPressed: toSignup,
              color: themeColors['lightBlue'],
              textColor: Colors.white,
              padding: EdgeInsets.all(15.0),
              splashColor: themeColors['lightBlue'],
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Spacer(flex: 1),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: themeColors['yellow'])),
              onPressed: toLogin,
              color: themeColors['yellow'],
              textColor: Colors.black,
              padding: EdgeInsets.all(15.0),
              splashColor: themeColors['yellow'],
              child: Text(
                "Log In",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Spacer(flex: 1),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: themeColors['mediumBlue'])),
              onPressed: toInfo,
              color: themeColors['mediumBlue'],
              textColor: Colors.white,
              padding: EdgeInsets.all(15.0),
              splashColor: themeColors['mediumBlue'],
              child: Text(
                "Learn More",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Spacer(),
          ]))),
    );
  }
}

class HomeScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) {
          String currentUserType;
          if (vm.currentUser == null) {
            // user not logged in
            currentUserType = "null";
          } else if (vm.currentUser.userType == null) {
            currentUserType = "none";
          } else {
            currentUserType = vm.currentUser.userType;
          }

          switch (currentUserType) {
            case "admin":
              {
                return AdminHomeScreen(
                    vm.currentUser,
                    vm.logout,
                    vm.toRegisteredDoulas,
                    vm.toRegisteredClients,
                    vm.toHome,
                    vm.toPendingApps,
                    vm.toUnmatchedClients);
              }
              break;
            case "client":
              {
                return ClientHomeScreen(vm.currentUser, vm.logout, vm.toHome,
                     vm.toInfo, vm.toProfile, vm.setProfileUser);
              }
              break;
            case "doula":
              {
                return DoulaHomeScreen(vm.currentUser, vm.logout, vm.toHome,
                     vm.toInfo, vm.toProfile, vm.setProfileUser);
              }
              break;
            case "none":
              {
                return AppTypeScreen(vm.currentUser, vm.updateClient,
                    vm.updateDoula, vm.toClientApp, vm.toDoulaApp);
              }
            default:
              {
                return HomeScreen(
                    toSignup: vm.toSignup,
                    toLogin: vm.toLogin,
                    toInfo: vm.toInfo);
              }
              break;
          }
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toSignup;
  VoidCallback toLogin;
  VoidCallback toInfo;
  Future<void> Function() logout;
  VoidCallback toRegisteredDoulas;
  VoidCallback toPendingApps;
  VoidCallback toUnmatchedClients;
  VoidCallback toRegisteredClients;
  VoidCallback toHome;
  void Function(Client) updateClient;
  void Function(Doula) updateDoula;
  VoidCallback toClientApp;
  VoidCallback toDoulaApp;
  VoidCallback toProfile;
  Future<void> Function(String, String) setProfileUser;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toSignup,
      @required this.toLogin,
      @required this.toInfo,
      @required this.logout,
      @required this.toRegisteredDoulas,
      @required this.toRegisteredClients,
      @required this.toHome,
      @required this.toPendingApps,
      @required this.toUnmatchedClients,
      @required this.toClientApp,
      @required this.toDoulaApp,
      @required this.updateClient,
      @required this.updateDoula,
      @required this.setProfileUser,
      @required this.toProfile})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toSignup: () => dispatch(NavigateAction.pushNamed("/signup")),
        toLogin: () => dispatch(NavigateAction.pushNamed("/login")),
        toInfo: () => dispatch(NavigateAction.pushNamed("/info")),
        logout: () => dispatchFuture(LogoutUserAction()),
        toRegisteredDoulas: () =>
            dispatch(NavigateAction.pushNamed("/registeredDoulas")),
        toRegisteredClients: () =>
            dispatch(NavigateAction.pushNamed("/registeredClients")),
        toHome: () => dispatch(NavigateAction.pushNamed("/")),
        toPendingApps: () => dispatch(NavigateAction.pushNamed("/pendingApps")),
        toUnmatchedClients: () => dispatch(NavigateAction.pushNamed("/unmatchedClients")),
        toClientApp: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage1")),
        toDoulaApp: () => dispatch(NavigateAction.pushNamed("/doulaAppPage1")),
        updateClient: (Client user) => dispatch(UpdateClientUserAction(user)),
        updateDoula: (Doula user) => dispatch(UpdateDoulaUserAction(user)),
        toProfile: () => dispatch(NavigateAction.pushNamed("/userProfile")),
        setProfileUser: (String userid, String userType) =>
            dispatchFuture(SetProfileUser(userid, userType)),
    );
  }
}
