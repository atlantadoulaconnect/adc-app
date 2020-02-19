import '../../common.dart';

class ClientAppPage4 extends StatefulWidget {
  final Client currentUser;
  final void Function(Client, int, bool, bool, List<String>, bool) updateClient;
  final VoidCallback toClientAppPage5;

  ClientAppPage4(this.currentUser, this.updateClient, this.toClientAppPage5)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toClientAppPage5 != null);

  @override
  State<StatefulWidget> createState() {
    return ClientAppPage4State();
  }
}

class ClientAppPage4State extends State<ClientAppPage4> {
  final GlobalKey<FormState> _c4formKey = GlobalKey<FormState>();
  Client currentUser;
  void Function(Client, int, bool, bool, List<String>, bool) updateClient;
  VoidCallback toClientAppPage5;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toClientAppPage5 = widget.toClientAppPage5;
    super.initState();
  }

  List<DropdownMenuItem<String>> birthCount = [];
  String selectedBirthCount;

  void loadData() {
    birthCount = [];
    birthCount.add(new DropdownMenuItem(
      child: new Text('0'),
      value: 'Zero',
    ));
    birthCount.add(new DropdownMenuItem(
      child: new Text('1'),
      value: 'One',
    ));
    birthCount.add(new DropdownMenuItem(
      child: new Text('2'),
      value: 'Two',
    ));
    birthCount.add(new DropdownMenuItem(
      child: new Text('3'),
      value: 'Three',
    ));
    birthCount.add(new DropdownMenuItem(
      child: new Text('4'),
      value: 'Four',
    ));
  }

  int pretermValue = 1;
  int previousTwinsOrTriplets = 1;
  int lowBirthWeightValue = 1;
  bool vaginalBirth = false, cesarean = false, vbac = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ClientAppPage4Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          ClientAppPage4(vm.currentUser, vm.updateClient, vm.toClientAppPage5),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(Client, int, bool, bool, List<String>, bool) updateClient;
  VoidCallback toClientAppPage5;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toClientAppPage5})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientAppPage5: () =>
            dispatch(NavigateAction.pushNamed("/clientAppPage5")),
        updateClient: (Client user, int liveBirths, bool preterm,
                bool lowWeight, List<String> deliveryTypes, bool multiples) =>
            dispatch(UpdateClientUserAction(user,
                liveBirths: liveBirths,
                preterm: preterm,
                lowWeight: lowWeight,
                deliveryTypes: deliveryTypes,
                multiples: multiples)));
  }
}
