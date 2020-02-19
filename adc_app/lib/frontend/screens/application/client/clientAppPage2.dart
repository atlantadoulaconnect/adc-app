import '../../common.dart';
import '../../../../backend/util/inputValidation.dart';

class ClientAppPage2 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, List<EmergencyContact>) updateClient;
  final VoidCallback toClientAppPage3;

  ClientAppPage2(this.currentUser, this.updateClient, this.toClientAppPage3)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage3 != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage2State();
  }
}

class ClientAppPage2State extends State<ClientAppPage2> {
  final GlobalKey<FormState> _c2formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, List<EmergencyContact>) updateClient;
  VoidCallback toClientAppPage3;

  TextEditingController _name1Controller;
  TextEditingController _relationship1Controller;
  TextEditingController _phone1Controller;
  TextEditingController _altPhone1Controller;

  TextEditingController _name2Controller;
  TextEditingController _relationship2Controller;
  TextEditingController _phone2Controller;
  TextEditingController _altPhone2Controller;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage3 = widget.toClientAppPage3;

    _name1Controller = TextEditingController();
    _relationship1Controller = TextEditingController();
    _phone1Controller = TextEditingController();
    _altPhone1Controller = TextEditingController();

    _name2Controller = TextEditingController();
    _relationship2Controller = TextEditingController();
    _phone2Controller = TextEditingController();
    _altPhone2Controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name1Controller.dispose();
    _relationship1Controller.dispose();
    _phone1Controller.dispose();
    _altPhone1Controller.dispose();

    _name2Controller.dispose();
    _relationship2Controller.dispose();
    _phone2Controller.dispose();
    _altPhone2Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ClientAppPage2Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          ClientAppPage2(vm.currentUser, vm.updateClient, vm.toClientAppPage3),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, List<EmergencyContact>) updateClient;
  VoidCallback toClientAppPage3;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage3})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppPage3: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage3")),
        updateClient: (Client user, List<EmergencyContact> contacts) =>
            dispatch(
                UpdateClientUserAction(user, emergencyContacts: contacts)));
  }
}
