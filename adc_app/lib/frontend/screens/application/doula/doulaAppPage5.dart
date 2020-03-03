import '../../common.dart';

class DoulaAppPage5 extends StatefulWidget {
  final Doula currentUser;
  final void Function(Doula, bool) updateDoula;
  final VoidCallback toDoulaAppConfirmation;

  DoulaAppPage5(this.currentUser, this.updateDoula, this.toDoulaAppConfirmation)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDoulaAppConfirmation != null);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DoulaAppPage5State();
  }
}

class DoulaAppPage5State extends State<DoulaAppPage5> {
  Doula currentUser;
  Function(Doula, bool) updatedoula;
  VoidCallback toDoulaAppConfirmation;

  bool photoReleasePermission = false;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updatedoula = widget.updateDoula;
    toDoulaAppConfirmation = widget.toDoulaAppConfirmation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doula Application'),
      ),
      body: Center(
        child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Photo Release',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 250,
                  child: LinearProgressIndicator(
                    backgroundColor: themeColors['skyBlue'],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                    value: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 330,
                  child: Text(
                    'I grant the Urban Health Initiative of Emory Photo/Video permission to use any photographs in Emory’s own publications or in any other broadcast, print,  or  electronic  media,  including—without  limitation—newspaper, radio,  television,  magazine,  internet.  I  waive  any  right  to  inspect  or  approve  my  depictions  in  these  works.    ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          child: Checkbox(
                        value: photoReleasePermission,
                        onChanged: (bool value) {
                          setState(() {
                            photoReleasePermission = value;
                          });
                        },
                      )),
                      Flexible(
                          child: Text(
                        "I agree to the statement above",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                        ),
                      ))
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: themeColors['mediumBlue'])),
                      onPressed: () {
                        // information will be lost
                        Navigator.pop(context);
                      },
                      color: themeColors['mediumBlue'],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['mediumBlue'],
                      child: Text(
                        "PREVIOUS",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: themeColors['yellow'])),
                      onPressed: () {
                        updatedoula(currentUser, photoReleasePermission);
                        toDoulaAppConfirmation();
                      },
                      color: themeColors['yellow'],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['yellow'],
                      child: Text(
                        "FINISH",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: themeColors['black'],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ]),
      ),
    );
  }
}

class DoulaAppPage5Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => DoulaAppPage5(
          vm.currentUser, vm.updateDoula, vm.toDoulaAppConfirmation),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(Doula, bool) updateDoula;
  VoidCallback toDoulaAppConfirmation;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppConfirmation});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        updateDoula: (Doula user, bool photoRelease) =>
            dispatch(UpdateDoulaUserAction(user, photoRelease: photoRelease)),
        toDoulaAppConfirmation: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppConfirmation")));
  }
}
