import '../common.dart';

class MessagesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class MessagesScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>();
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel.build();

  @override
  ViewModel fromStore() {}
}
