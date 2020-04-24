import '../../common.dart';
import 'package:calendarro/calendarro.dart';

class DoulaAppPage4 extends StatefulWidget {
  final Doula currentUser;
  final void Function(Doula, List<String>) updateDoula;
  final VoidCallback toDoulaAppPage5;
  final void Function(bool) cancelApplication;

  DoulaAppPage4(this.currentUser, this.updateDoula, this.toDoulaAppPage5,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDoulaAppPage5 != null &&
            cancelApplication != null);

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
  void Function(bool) cancelApplication;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDoulaAppPage5 = widget.toDoulaAppPage5;
    cancelApplication = widget.cancelApplication;

    super.initState();
  }

  confirmCancelDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Cancel Application"),
          content: Text("Do you want to cancel your application?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                //dispatch CancelApplication
                cancelApplication(true);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                cancelApplication(false);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String monthYear = formatDateMonthYYYY(DateTime.now());
    Calendarro myCal = Calendarro(
      displayMode: DisplayMode.MONTHS,
      selectionMode: SelectionMode.MULTI,
      startDate: DateTime.now()
          .subtract(Duration(days: DateTime.now().day - 1)),
      endDate: DateTime.now().add(Duration(days: 1000)),
    );
    myCal.onPageSelected = (start, end) {
      monthYear = formatDateMonthYYYY(start);
      setState(() {});
    };
    return Scaffold(
        appBar: AppBar(
          title: Text("Doula Application"),
        ),
        body: Container(
            child: ListView(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Availability',
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
                    valueColor: AlwaysStoppedAnimation<Color>(
                        themeColors['mediumBlue']),
                    value: 0.8,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Please select the dates when you \nare NOT available:',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                  child: Text(
                    monthYear,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 280,
                    width: 300,
                    color: themeColors["coolGray1"],
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: myCal,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: themeColors['mediumBlue'])),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: themeColors['coolGray5'])),
                            onPressed: () {
                              // dialog to confirm cancellation
                              confirmCancelDialog(context);
                            },
                            color: themeColors['coolGray5'],
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15.0),
                            splashColor: themeColors['coolGray5'],
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: themeColors['black'],
                              ),
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
                              // TODO selecting calendar dates and adding to Doula
                              List<String> availableDates = new List<String>();
                              for (DateTime d in myCal.selectedDates) {
                                availableDates.add(formatDateYYYYMMDD(d));
                              }
                              print(availableDates);
                              updateDoula(currentUser, availableDates);
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
                        ),
                      ]),
                ),
              ),
            ])));
  }
}

class DoulaAppPage4Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => DoulaAppPage4(
          vm.currentUser,
          vm.updateDoula,
          vm.toDoulaAppPage5,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(Doula, List<String>) updateDoula;
  VoidCallback toDoulaAppPage5;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDoulaAppPage5,
      @required this.cancelApplication});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        updateDoula: (Doula user, List<String> availableDates) =>
            dispatch(UpdateDoulaUserAction(user, availableDates: availableDates)),
        toDoulaAppPage5: () =>
            dispatch(NavigateAction.pushNamed("/doulaAppPage5")),
        cancelApplication: (bool confirmed) {
          dispatch(NavigateAction.pop());
          if (confirmed) {
            dispatch(CancelApplicationAction());
            dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          }
        });
  }
}
