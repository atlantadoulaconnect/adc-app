import '../common.dart';

class ClientProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class ClientProfileScreenState extends State<ClientProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ClientProfileScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser; // doula won't be able to add/remove doulas
  Client currentProfile;

  // making/removing match
  // Client, Her Doula, "primary" or "backup"
  Future<void> Function(Client, Doula, String) addDoula;
  Future<void> Function(Client, Doula, String) removeDoula;

  ViewModel.build(
      {@required this.currentProfile,
      @required this.addDoula,
      @required this.removeDoula})
      : super(equals: [currentProfile]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        //currentProfile: state.currentProfile,
        );
  }
}
