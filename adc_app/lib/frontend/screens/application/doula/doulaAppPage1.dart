import '../../common.dart';

class DoulaAppPage1 extends StatefulWidget {
  final Doula currentUser;
  final void Function(Doula) updateDoula;
  final VoidCallback toDoulaAppPage2;

  DoulaAppPage1(
      {Key key, this.currentUser, this.updateDoula, this.toDoulaAppPage2})
      : assert(currentUser != null && currentUser.userType == "doula"),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DoulaAppPage1State();
  }
}

class DoulaAppPage1State extends State<DoulaAppPage1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Key key;
  Doula currentUser;
  void Function(Doula) updateDoula;
  VoidCallback toDoulaAppPage2;

  TextEditingController _firstNameCtrl;
  TextEditingController _lastInitCtrl;
  TextEditingController _bdayCtrl;
  TextEditingController _phoneCtrl;
  TextEditingController _altPhoneCtrl;

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController();
    _lastInitCtrl = TextEditingController();
    _bdayCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _altPhoneCtrl = TextEditingController();
    key = widget.key;
    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDoulaAppPage2 = widget.toDoulaAppPage2;
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
    // TODO: implement build
    return null;
  }
}

class DoulaAppPage1Connector extends StatelessWidget {
  DoulaAppPage1Connector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => DoulaAppPage1(
          currentUser: vm.currentUser,
          updateDoula: vm.updateDoula,
          toDoulaAppPage2: vm.toDoulaAppPage2),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(Doula) updateDoula;
  VoidCallback toDoulaAppPage2;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppPage2});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toDoulaAppPage2: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppPage2")),
        updateDoula: (Doula user,
                {String userid,
                String userType,
                String name,
                String email,
                bool phoneVerified,
                List<Phone> phones,
                String bday,
                bool emailVerified,
                String bio,
                bool certified,
                bool certInProgress,
                String certProgram,
                int birthsNeeded,
                List<String> availableDates,
                List<Client> currentClients}) =>
            dispatch(UpdateDoulaUserAction(user,
                userid: userid,
                userType: userType,
                name: name,
                email: email,
                phones: phones,
                phoneVerified: phoneVerified,
                bday: bday,
                emailVerified: emailVerified,
                bio: bio,
                certified: certified,
                certInProgress: certInProgress,
                certProgram: certProgram,
                birthsNeeded: birthsNeeded,
                availableDates: availableDates,
                currentClients: currentClients)));
  }
}
