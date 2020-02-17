import './common.dart';
import 'package:async_redux/async_redux.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("About Atlanta Doula Connect")),
        drawer: Menu(),
        body: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Center(
            child: Column(
              children: <Widget>[Text("Info about ADC page")],
            ),
          ),
        ));
  }
}
