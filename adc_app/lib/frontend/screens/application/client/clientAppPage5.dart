import '../../common.dart';

class ClientAppPage5 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, bool, bool) updateClient;
  final VoidCallback toClientAppPage6;

  ClientAppPage5(this.currentUser, this.updateClient, this.toClientAppPage6)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage6 != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage5State();
  }
}

class ClientAppPage5State extends State<ClientAppPage5> {
  final GlobalKey<FormState> _c5formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, bool, bool) updateClient;
  VoidCallback toClientAppPage6;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage6 = widget.toClientAppPage6;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ClientAppPage5Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          ClientAppPage5(vm.currentUser, vm.updateClient, vm.toClientAppPage6),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, bool, bool) updateClient;
  VoidCallback toClientAppPage6;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage6})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppPage6: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage6")),
        updateClient: (Client user, bool meetBefore, bool homeVisit) =>
            dispatch(UpdateClientUserAction(user,
                meetBefore: meetBefore, homeVisit: homeVisit)));
  }
}
