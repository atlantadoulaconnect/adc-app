import '../common.dart';

class AppTypeScreen extends StatelessWidget {
  final User currentUser;
  final void Function(Client) updateClient;
  final void Function(Doula) updateDoula;
  final VoidCallback toClientApp;
  final VoidCallback toDoulaApp;

  AppTypeScreen(
      {this.currentUser,
      this.updateClient,
      this.updateDoula,
      this.toClientApp,
      this.toDoulaApp})
      : assert(currentUser != null &&
            updateClient != null &&
            updateDoula != null &&
            toClientApp != null &&
            toDoulaApp != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Application")),
        drawer: Menu(),
        body: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Center(
                child: Column(
              children: <Widget>[
                Spacer(flex: 1),
                Text("Atlanta Doula Connect",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    )),
                Spacer(flex: 2),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: themeColors['mediumBlue']),
                    ),
                    color: themeColors['mediumBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['mediumBlue'],
                    child: Text(
                      "Request a Doula",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      // replace current User with a Client in AppState
                      Client user = Client(
                          userType: "client",
                          userid: currentUser.userid,
                          email: currentUser.email);
                      updateClient(user);
                      toClientApp();
                    }),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        side: BorderSide(color: themeColors['lightBlue'])),
                    color: themeColors['lightBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['lightBlue'],
                    child: Text(
                      "Apply as a Doula",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Doula user = Doula(
                          userType: "doula",
                          userid: currentUser.userid,
                          email: currentUser.email);
                      updateDoula(user);
                      toDoulaApp();
                    }),
                Spacer(flex: 1),
              ],
            ))));
  }
}

class AppTypeScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) {
          return AppTypeScreen(
              currentUser: vm.currentUser,
              updateClient: vm.updateClient,
              toClientApp: vm.toClientApp,
              toDoulaApp: vm.toDoulaApp);
        });
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  void Function(Client) updateClient;
  void Function(Doula) updateDoula;
  VoidCallback toClientApp;
  VoidCallback toDoulaApp;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toClientApp,
      @required this.toDoulaApp,
      @required this.updateClient,
      @required this.updateDoula})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toClientApp: () => dispatch(NavigateAction.pushNamed("/clientSignup")),
        toDoulaApp: () => dispatch(NavigateAction.pushNamed("/doulaSignup")),
        updateClient: (Client user,
                {String userid,
                String userType,
                String name,
                List<Phone> phones,
                String email,
                bool phoneVerified,
                String bday,
                Doula primaryDoula,
                Doula backupDoula,
                String dueDate,
                String birthLocation,
                String birthType,
                bool epidural,
                bool cesarean,
                List<EmergencyContact> emergencyContacts,
                int liveBirths,
                bool preterm,
                bool lowWeight,
                List<String> deliveryTypes,
                bool multiples,
                bool meetBefore,
                bool homeVisit,
                bool photoRelease}) =>
            dispatch(UpdateClientUserAction(user,
                userid: userid,
                userType: userType,
                name: name,
                phones: phones,
                email: email,
                phoneVerified: phoneVerified,
                bday: bday,
                primaryDoula: primaryDoula,
                backupDoula: backupDoula,
                dueDate: dueDate,
                birthLocation: birthLocation,
                birthType: birthType,
                epidural: epidural,
                cesarean: cesarean,
                emergencyContacts: emergencyContacts,
                liveBirths: liveBirths,
                preterm: preterm,
                lowWeight: lowWeight,
                deliveryTypes: deliveryTypes,
                multiples: multiples,
                meetBefore: meetBefore,
                homeVisit: homeVisit,
                photoRelease: photoRelease)),
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
