import 'package:flutter/cupertino.dart';

import '../../common.dart';
import 'package:table_calendar/table_calendar.dart';

class Dp4Availability extends StatefulWidget {
  final Doula currentUser;
  final void Function(List<String>) updateDoula;
  final VoidCallback toDp5PhotoRelease;
  final void Function(bool) cancelApplication;

  Dp4Availability(this.currentUser, this.updateDoula, this.toDp5PhotoRelease,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "doula" &&
            updateDoula != null &&
            toDp5PhotoRelease != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return Dp4AvailabilityState();
  }
}

class Dp4AvailabilityState extends State<Dp4Availability> {
  Doula currentUser;
  void Function(List<String>) updateDoula;
  VoidCallback toDp5PhotoRelease;
  void Function(bool) cancelApplication;
  CalendarController calendarController;
  List<DateTime> unavailableDates;

  @override
  void initState() {
    super.initState();

    currentUser = widget.currentUser;
    updateDoula = widget.updateDoula;
    toDp5PhotoRelease = widget.toDp5PhotoRelease;
    cancelApplication = widget.cancelApplication;
    calendarController = CalendarController();
    unavailableDates = List<DateTime>();

    initialPlaceholders();
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

  void initialPlaceholders() {}

  void saveValidInputs() {
    List<String> unavailableDatesAsString = new List<String>();
    for (DateTime d in unavailableDates) {
      unavailableDatesAsString.add(formatDateYYYYMMDD(d));
    }
    updateDoula(
        unavailableDatesAsString.isEmpty ? null : unavailableDatesAsString);
  }

  Future<bool> _onBackPressed() {
    saveValidInputs();

    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    TableCalendar myCal = TableCalendar(
      calendarController: calendarController,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      calendarStyle: CalendarStyle(),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      startDay: DateTime.now(),
      onDaySelected: (date, events, holidays) {
        setState(() {
          if (unavailableDates.contains(date)) {
            unavailableDates.remove(date);
          } else {
            unavailableDates.add(date);
          }
        });
      },
      builders: CalendarBuilders(
        dayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
            ),
            decoration: BoxDecoration(
              color: unavailableDates.contains(date)
                  ? themeColors["gold"]
                  : themeColors["lightGrey"],
              shape: BoxShape.circle,
            ),
          );
        },
        outsideDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["coolGray5"]),
            ),
          );
        },
        outsideHolidayDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["coolGray5"]),
            ),
          );
        },
        outsideWeekendDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["coolGray5"]),
            ),
          );
        },
        unavailableDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["coolGray5"]),
            ),
          );
        },
        weekendDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(color: themeColors["black"]),
            ),
            decoration: BoxDecoration(
              color: unavailableDates.contains(date)
                  ? themeColors["gold"]
                  : themeColors["lightGrey"],
              shape: BoxShape.circle,
            ),
          );
        },
        todayDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(
                  color: themeColors["mediumBlue"],
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
              color: unavailableDates.contains(date)
                  ? themeColors["gold"]
                  : themeColors["lightGrey"],
              shape: BoxShape.circle,
            ),
          );
        },
        selectedDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(
                color: themeColors["black"],
              ),
            ),
            decoration: BoxDecoration(
              color: unavailableDates.contains(date)
                  ? themeColors["gold"]
                  : themeColors["lightGrey"],
              shape: BoxShape.circle,
              border: Border.all(color: themeColors["mediumBlue"], width: 2.0),
            ),
          );
        },
      ),
    );

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Doula Application"),
            ),
            body: Container(
                child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 17.0, bottom: 8.0),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 350,
                        width: 320,
                        color: themeColors["lightGrey"],
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
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
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: themeColors['mediumBlue'])),
                                onPressed: () {
                                  saveValidInputs();

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
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
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
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: themeColors['yellow'])),
                                onPressed: () {
                                  // TODO selecting calendar dates and adding to Doula
                                  List<String> unavailableDatesAsString =
                                      new List<String>();
                                  for (DateTime d in unavailableDates) {
                                    unavailableDatesAsString
                                        .add(formatDateYYYYMMDD(d));
                                  }
                                  updateDoula(unavailableDatesAsString);
                                  toDp5PhotoRelease();
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
                ]))));
  }
}

class Dp4AvailabilityConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => Dp4Availability(
          vm.currentUser,
          vm.updateDoula,
          vm.toDp5PhotoRelease,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  void Function(List<String>) updateDoula;
  VoidCallback toDp5PhotoRelease;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateDoula,
      @required this.toDp5PhotoRelease,
      @required this.cancelApplication});

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        updateDoula: (List<String> availableDates) =>
            dispatch(UpdateDoulaUserAction(availableDates: availableDates)),
        toDp5PhotoRelease: () =>
            dispatch(NavigateAction.pushNamed("/dp5PhotoRelease")),
        cancelApplication: (bool confirmed) {
          dispatch(NavigateAction.pop());
          if (confirmed) {
            dispatch(CancelApplicationAction());
            dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
          }
        });
  }
}
