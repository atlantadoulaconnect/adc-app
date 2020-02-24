import '../../common.dart';
import 'package:calendarro/calendarro.dart';

class DoulaAppPage4 extends StatefulWidget {
  final Doula currentUser;
  final void Function(Doula, List<String>) updateDoula;
  final VoidCallback toDoulaAppPage5;

  DoulaAppPage4(this.currentUser, this.updateDoula, this.toDoulaAppPage5)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDoulaAppPage5 != null);

  @override
  State<StatefulWidget> createState() {
    return DoulaAppPage4State();
  }
}

class DoulaAppPage4State extends State<DoulaAppPage4> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Doula currentUser;
  void Function(Doula, List<String>) updateDoula;
  VoidCallback toDoulaAppPage5;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDoulaAppPage5 = widget.toDoulaAppPage5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Doula Application"),
        ),
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
                'Availability',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['emoryBlue'],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Container(
                width: 250,
                child: LinearProgressIndicator(
                  backgroundColor: themeColors['skyBlue'],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                  value: 0.8,
                ),
              ),
              Text(
                'Please select the dates that you \nare available to serve as a doula:',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Container(
                height: 260,
                width: 300,
                child: Calendarro(
                  displayMode: DisplayMode.MONTHS,
                  selectionMode: SelectionMode.MULTI,
                  startDate: DateTime.now()
                      .subtract(Duration(days: DateTime.now().day - 1)),
                  endDate: DateTime.now().add(Duration(days: 1000)),

//                  onTap: (date) {
//                    setState(() {
//                      monthYear = date.toString();
//                    });
//                  }
                ),
              ),
              Row(children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: themeColors['mediumBlue'])),
                  onPressed: () {
                    // info will be lost
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
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: themeColors['yellow'])),
                  onPressed: () {
                    // TODO
                    toDoulaAppPage5();
                  },
                  color: themeColors['yellow'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['yellow'],
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: themeColors['black'],
                    ),
                  ),
                ),
              ]),
            ])));
  }
}

class DoulaAppPage4Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          DoulaAppPage4(vm.currentUser, vm.updateDoula, vm.toDoulaAppPage5),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(Doula, List<String>) updateDoula;
  VoidCallback toDoulaAppPage5;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppPage5});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        updateDoula: (Doula user, List<String> dates) =>
            dispatch(UpdateDoulaUserAction(user, availableDates: dates)),
        toDoulaAppPage5: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppPage5")));
  }
}
