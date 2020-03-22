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
          child: Center(),
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
      {@required currentUser, @required application, @required toPage})
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
