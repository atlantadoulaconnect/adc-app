import '../../common.dart';
import 'package:async_redux/async_redux.dart';

class DoulaSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Apply as a Doula")),
        drawer: Menu(),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[Text("Sign Up")])));
  }
}
