import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:calendarro/calendarro.dart';
import 'package:adc_app/models/doula.dart';

import 'doula_app_page5.dart';

//Availability Page

class DoulaAppPage4 extends StatefulWidget {
  Doula user;
  DoulaAppPage4({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor doula app: \n${user.toString()}");
  }
  @override
  _DoulaAppPage4 createState() => _DoulaAppPage4();
}

class _DoulaAppPage4 extends State<DoulaAppPage4> {
  Doula currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String monthYear;

//  @override
//  void initState() {
//    super.initState();
//    monthYear = DateTime.now().toString();
//  }

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print("currentUser initState state: \n${currentUser.toString()}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doula Application'),
      ),
      body: Center(
        child: Form(
        key: _formKey,
        autovalidate: false,
          child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Availability',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,

                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      width: 250,
                      child: LinearProgressIndicator(
                        backgroundColor: themeColors['skyBlue'],
                        valueColor:
                        AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                        value: 0.8,
                      ),
                    ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Please select the dates that you \nare available to serve as a doula:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                ),

  //              Text(
  //                monthYear,
  //              ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
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
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: themeColors['mediumBlue'])),
                    onPressed: () {
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
                      final form = _formKey.currentState;
                      if (form.validate()) {

                        form.save();


                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DoulaAppPage5(
                                        key: key, user: currentUser)));
                      }
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
              ]),
      ),
      ),
    );
  }
}
