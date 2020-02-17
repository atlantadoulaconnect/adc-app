import './common.dart';
import 'package:async_redux/async_redux.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Log In")),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                children: <Widget>[Text("Welcome to Atlanta Doula Connect")])));
  }
}
