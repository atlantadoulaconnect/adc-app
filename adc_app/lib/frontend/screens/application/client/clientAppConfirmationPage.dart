import '../../common.dart';

class ClientAppConfirmationPage extends StatelessWidget {
  final Client currentUser;
  final VoidCallback toRequestSent;
  final Future<void> Function(Client) userToDB;

  ClientAppConfirmationPage(this.currentUser, this.toRequestSent, this.userToDB)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            userToDB != null &&
            toRequestSent != null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ClientAppConfirmationPageConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return ClientAppConfirmationPage(
            vm.currentUser, vm.toRequestSent, vm.userToDB);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  VoidCallback toRequestSent;
  Future<void> Function(Client) userToDB;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toRequestSent,
      @required this.userToDB})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        userToDB: (Client user) =>
            dispatchFuture(CreateClientUserDocument(user)),
        toRequestSent: () =>
            dispatch(NavigateAction.pushNamed("/requestSent")));
  }
}
