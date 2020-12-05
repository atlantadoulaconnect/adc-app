import '../common.dart';

class RequestSentScreen extends StatelessWidget {
  final User currentUser;
  final VoidCallback toHome;

  RequestSentScreen(this.currentUser, this.toHome)
      : assert(currentUser != null && toHome != null);

  @override
  Widget build(BuildContext context) {
    String message = currentUser.userType == "client"
        ? "Your request for a doula has been sent!"
        : "Your application to become a volunteer doula for Atlanta Doula Connect has been sent!";

    return Scaffold(
        appBar: AppBar(title: Text("Application Sent")),
        drawer: Menu(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['yellow'])),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                  // TODO: Reset Navigator stack
                },
                color: themeColors['yellow'],
                textColor: Colors.black,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['yellow'],
                child: Text(
                  "RETURN HOME",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Spacer(),
            ],
          ),
        ));
  }
}

class RequestSentScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) {
          return RequestSentScreen(vm.currentUser, vm.toHome);
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toHome;

  ViewModel.build({@required this.currentUser, @required this.toHome})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toHome: () => dispatch(NavigateAction.pushNamedAndRemoveAll("/home")));
  }
}
