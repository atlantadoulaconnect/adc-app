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
                  side: BorderSide(color: themeColors['gold'])),
              onPressed: toInfo,
              color: themeColors['gold'],
              textColor: Colors.black,
              padding: EdgeInsets.all(15.0),
              splashColor: themeColors['gold'],
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
                    vm.toPendingApps,
                    vm.toHome);
              }
              break;
            case "client":
              {
                return ClientHomeScreen(vm.currentUser, vm.logout, vm.toHome,
                    vm.toRecentMessages, vm.toInfo);
              }
              break;
            case "doula":
              {
                return DoulaHomeScreen(vm.currentUser, vm.logout, vm.toHome,
                    vm.toRecentMessages, vm.toInfo);
              }
              break;
            // todo user screen for user that logged out before choosing usertype
          }
          return HomeScreen(
              toSignup: vm.toSignup, toLogin: vm.toLogin, toInfo: vm.toInfo);
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
  VoidCallback toRegisteredClients;
  VoidCallback toHome;
  VoidCallback toRecentMessages;

  ViewModel.build({
    @required this.currentUser,
    @required this.toSignup,
    @required this.toLogin,
    @required this.toInfo,
    @required this.logout,
    @required this.toRegisteredDoulas,
    @required this.toRegisteredClients,
    @required this.toHome,
    @required this.toPendingApps,
    @required this.toRecentMessages,
  }) : super(equals: [currentUser]);

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
      toRecentMessages: () =>
          dispatch(NavigateAction.pushNamed("/recentMessages")),
    );
  }
}
