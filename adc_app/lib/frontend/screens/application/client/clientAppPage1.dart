import '../../common.dart';
import '../../../../backend/util/inputValidation.dart';

class ClientAppPage1 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, String, String, List<Phone>) updateClient;
  final VoidCallback toClientAppPage2;

  ClientAppPage1(this.currentUser, this.updateClient, this.toClientAppPage2)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage2 != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage1State();
  }
}

class ClientAppPage1State extends State<ClientAppPage1> {
  final GlobalKey<FormState> _c1formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, String, String, List<Phone>) updateClient;
  VoidCallback toClientAppPage2;

  TextEditingController _firstNameCtrl;
  TextEditingController _lastInitCtrl;
  TextEditingController _bdayCtrl;
  TextEditingController _phoneCtrl;
  TextEditingController _altPhoneCtrl;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage2 = widget.toClientAppPage2;
    _firstNameCtrl = TextEditingController();
    _lastInitCtrl = TextEditingController();
    _bdayCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _altPhoneCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastInitCtrl.dispose();
    _bdayCtrl.dispose();
    _phoneCtrl.dispose();
    _altPhoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Apply as a Doula")),
        drawer: Menu(),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[Text("Sign Up")])));
  }
}

class ClientAppPage1Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          ClientAppPage1(vm.currentUser, vm.updateClient, vm.toClientAppPage2),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, String, String, List<Phone>) updateClient;
  VoidCallback toClientAppPage2;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage2})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppPage2: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage2")),
        updateClient:
            (Client user, String name, String bday, List<Phone> phones) =>
                dispatch(UpdateClientUserAction(user,
                    name: name, phones: phones, bday: bday)));
  }
}
