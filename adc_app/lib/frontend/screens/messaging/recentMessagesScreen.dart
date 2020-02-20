import '../common.dart';

class RecentMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class RecentMessagesScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>();
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  ViewModel.build();

  @override
  ViewModel fromStore() {
    return ViewModel.build();
  }
}
