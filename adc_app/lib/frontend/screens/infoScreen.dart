import './common.dart';
import 'package:async_redux/async_redux.dart';

class InfoScreen extends StatelessWidget {
  InfoScreen();

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

class InfoScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return InfoScreen();
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  ViewModel.build();

  @override
  ViewModel fromStore() {}
}
