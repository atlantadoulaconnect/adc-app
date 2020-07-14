import '../common.dart';

class AppTypeScreen extends StatelessWidget {
  final User currentUser;
  final void Function(String, String) updateClient;
  final void Function(String, String) updateDoula;
  final VoidCallback toClientApp;
  final VoidCallback toDoulaApp;

  AppTypeScreen(this.currentUser, this.updateClient, this.updateDoula,
      this.toClientApp, this.toDoulaApp)
      : assert(currentUser != null &&
            updateClient != null &&
            updateDoula != null &&
            toClientApp != null &&
            toDoulaApp != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Application")),
        drawer: Menu(),
        body: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Center(
                child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Atlanta Doula Connect",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 70, 8, 8),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        side: BorderSide(color: themeColors['mediumBlue']),
                      ),
                      color: themeColors['mediumBlue'],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['mediumBlue'],
                      child: Text(
                        "Request a Doula",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        // replace current User with a Client in AppState
                        updateClient(currentUser.userid, currentUser.email);
                        toClientApp();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          side: BorderSide(color: themeColors['lightBlue'])),
                      color: themeColors['lightBlue'],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['lightBlue'],
                      child: Text(
                        "Apply as a Doula",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        updateDoula(currentUser.userid, currentUser.email);
                        toDoulaApp();
                      }),
                ),
              ],
            ))));
  }
}

class AppTypeScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) {
          return AppTypeScreen(vm.currentUser, vm.updateClient, vm.updateDoula,
              vm.toClientApp, vm.toDoulaApp);
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  void Function(String, String) updateClient;
  void Function(String, String) updateDoula;
  VoidCallback toClientApp;
  VoidCallback toDoulaApp;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toClientApp,
      @required this.toDoulaApp,
      @required this.updateClient,
      @required this.updateDoula})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientApp: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage1")),
        toDoulaApp: () => dispatch(NavigateAction.pushNamed("/doulaAppPage1")),
        updateClient: (String id, String email) {
          dispatch(CreateUserFromApp(
              userid: id,
              email: email,
              userType: "client",
              userStatus: "incomplete"));
        },
        updateDoula: (String id, String email) {
          dispatch(CreateUserFromApp(
              userType: "doula",
              userStatus: "incomplete",
              userid: id,
              email: email));
        });
  }
}
