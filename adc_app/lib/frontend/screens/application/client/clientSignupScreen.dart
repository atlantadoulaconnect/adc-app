import '../../common.dart';
import 'package:async_redux/async_redux.dart';

class ClientSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Request a Doula")),
        //drawer: NewUserMenu(),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[Text("Sign Up")])));
  }
}

class ClientSignupScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  @override
  BaseModel fromStore() {
    // TODO: implement fromStore
    return null;
  }
}
