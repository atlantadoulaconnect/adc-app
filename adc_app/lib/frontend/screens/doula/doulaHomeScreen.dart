import '../common.dart';

class DoulaHomeScreen extends StatelessWidget {
  final Doula currentUser;
  final Future<void> Function() logout;
  final VoidCallback toHome;

  DoulaHomeScreen(this.currentUser, this.logout, this.toHome);

  @override
  Widget build(BuildContext context) {
    // TODO: sprint 1 'your request has been submitted. you will be notified when ADC has finished their review'
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
              ),
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("LOG OUT"),
              onPressed: () async {
                logout();
                toHome();
              },
            ),
          ],
        )));
  }
}

class DoulaHomeScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          DoulaHomeScreen(vm.currentUser, vm.logout, vm.toHome),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  Future<void> Function() logout;
  VoidCallback toHome;

  ViewModel.build(
      {@required this.currentUser,
      @required this.logout,
      @required this.toHome})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        logout: () => dispatchFuture(LogoutUserAction()),
        toHome: () => dispatch(NavigateAction.pushNamed("/")));
  }
}
