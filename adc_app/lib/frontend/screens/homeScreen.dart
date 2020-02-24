import './common.dart';
import 'package:async_redux/async_redux.dart';

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
          return HomeScreen(
              toSignup: vm.toSignup, toLogin: vm.toLogin, toInfo: vm.toInfo);
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  VoidCallback toSignup;
  VoidCallback toLogin;
  VoidCallback toInfo;

  ViewModel.build(
      {@required this.toSignup, @required this.toLogin, @required this.toInfo})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      toSignup: () => dispatch(NavigateAction.pushNamed("/signup")),
      toLogin: () => dispatch(NavigateAction.pushNamed("/login")),
      toInfo: () => dispatch(NavigateAction.pushNamed("/info")),
    );
  }
}
