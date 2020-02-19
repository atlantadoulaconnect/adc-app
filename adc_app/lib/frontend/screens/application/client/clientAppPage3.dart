import '../../common.dart';

class ClientAppPage3 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, String, String, String, bool, bool) updateClient;
  final VoidCallback toClientAppPage4;

  ClientAppPage3(this.currentUser, this.updateClient, this.toClientAppPage4)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage4 != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage3State();
  }
}

class ClientAppPage3State extends State<ClientAppPage3> {
  final GlobalKey<FormState> _c3formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, String, String, String, bool, bool) updateClient;
  VoidCallback toClientAppPage4;

  TextEditingController _dueDateController;
  TextEditingController _birthLocController;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage4 = widget.toClientAppPage4;
    _dueDateController = TextEditingController();
    _birthLocController = TextEditingController();
    super.initState();
  }

  //drop down list
  List<DropdownMenuItem<String>> birthType = [];
  String selectedBirthType;

  List<DropdownMenuItem<String>> birthLocation = [];
  String selectedBirthLocation;
  int epiduralValue = 1;
  int cSectionValue = 1;

  void loadData() {
    birthType = [];
    birthType.add(new DropdownMenuItem(
      child: new Text('Singleton'),
      value: '1',
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('Twins'),
      value: '2',
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('Triplets'),
      value: '3',
    ));

    birthLocation = [];
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Grady'),
      value: '0',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Emory Decatur'),
      value: '1',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Northside'),
      value: '2',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('A Birthing Center'),
      value: '3',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('At Home'),
      value: '4',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('No plans'),
      value: '5',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Other (please specify below)'),
      value: '6',
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ClientAppPage3Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          ClientAppPage3(vm.currentUser, vm.updateClient, vm.toClientAppPage4),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, String, String, String, bool, bool) updateClient;
  VoidCallback toClientAppPage4;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage4})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppPage4: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage4")),
        updateClient: (Client user, String dueDate, String birthLocation,
                String birthType, bool epidural, bool cesarean) =>
            dispatch(UpdateClientUserAction(user,
                dueDate: dueDate,
                birthLocation: birthLocation,
                birthType: birthType,
                epidural: epidural,
                cesarean: cesarean)));
  }
}
