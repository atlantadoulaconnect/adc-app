import '../common.dart';

class ApplicationStatusScreen extends StatelessWidget {
  final User currentUser;
  final ApplicationState application;
  final void Function(String) toPage;

  ApplicationStatusScreen(this.currentUser, this.application, this.toPage)
      : assert(currentUser != null && application != null && toPage != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Continue Application")),
        drawer: Menu(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                // for testing
                child: Text("Current user's type: ${currentUser.userType}"),
              ),
              Visibility(
                visible: currentUser.userType == null,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: themeColors['yellow'])),
                    onPressed: () {
                      // test to client page 1
                      toPage("/appType");
                    },
                    color: themeColors['lightBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['lightBlue'],
                    child: Text(
                      "Choose Application Type",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

class ApplicationStatusScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return ApplicationStatusScreen(
            vm.currentUser, vm.application, vm.toPage);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  ApplicationState application;
  void Function(String) toPage; // user gets taken to selected page

  ViewModel.build(
      {@required this.currentUser,
      @required this.application,
      @required this.toPage})
      : super(equals: [application]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        application: state.formState,
        toPage: (String pageName) =>
            dispatch(NavigateAction.pushNamed(pageName)));
  }
}
