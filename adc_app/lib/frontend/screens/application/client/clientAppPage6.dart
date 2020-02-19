import '../../common.dart';

class ClientAppPage6 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, bool) updateClient;
  final VoidCallback toClientAppConfirmation;

  ClientAppPage6(
      this.currentUser, this.updateClient, this.toClientAppConfirmation)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppConfirmation != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage6State();
  }
}

class ClientAppPage6State extends State<ClientAppPage6> {
  final GlobalKey<FormState> _c6formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, bool) updateClient;
  VoidCallback toClientAppConfirmation;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppConfirmation = widget.toClientAppConfirmation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ClientAppPage6Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => ClientAppPage6(
          vm.currentUser, vm.updateClient, vm.toClientAppConfirmation),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, bool) updateClient;
  VoidCallback toClientAppConfirmation;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppConfirmation})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppConfirmation: () =>
            dispatch(NavigateAction.pushNamed("/clientAppConfirmation")),
        updateClient: (Client user, bool photoRelease) =>
            dispatch(UpdateClientUserAction(user, photoRelease: photoRelease)));
  }
}
