import '../common.dart';

class TextBankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class TextBankScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>();
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  ViewModel.build();

  @override
  ViewModel fromStore() {}
}
