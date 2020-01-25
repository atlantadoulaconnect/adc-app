import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:calendarro/calendarro.dart';


class DoulaAppPage4 extends StatefulWidget {
  @override
  _DoulaAppPage4 createState() => _DoulaAppPage4();
}

class _DoulaAppPage4 extends State<DoulaAppPage4> {
  String monthYear;

//  @override
//  void initState() {
//    super.initState();
//    monthYear = DateTime.now().toString();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doula Application'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 2,),
              Text(
                'Availability',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['emoryBlue'],
                  fontWeight: FontWeight.bold,

                  fontSize: 25,
                ),
              ),
              Spacer(),
              Container(
                width: 250,
                child: LinearProgressIndicator(
                  backgroundColor: themeColors['skyBlue'],
                  valueColor: AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                  value: 0.8,
                ),
              ),
              Spacer(flex: 2,),
              Text(
                'Please select the dates that you \nare available to serve as a doula:',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Spacer(flex: 2,),
//              Text(
//                monthYear,
//              ),
              Container(
                height: 260,
                width: 300,
                child: Calendarro(
                  displayMode: DisplayMode.MONTHS,
                  selectionMode: SelectionMode.MULTI,
                  startDate: DateTime.now().subtract(Duration(days: DateTime.now().day - 1)),
                  endDate: DateTime.now().add(Duration(days: 1000)),
//                  onTap: (date) {
//                    setState(() {
//                      monthYear = date.toString();
//                    });
//                  }
                ),
              ),
              Spacer(flex: 2,),
              Row (
                  children: <Widget>[
                    Spacer(flex: 2,),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: themeColors['mediumBlue'])
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/doulaAppPage3');
                      },
                      color: themeColors['mediumBlue'],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['mediumBlue'],
                      child: Text(
                        "Back",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Spacer(flex: 2,),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: themeColors['yellow'])),
                      onPressed: () {
                        Navigator.pushNamed(context, '/doulaAppPage5');
                      },
                      color: themeColors['yellow'],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['yellow'],
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: themeColors['black'],
                        ),
                      ),
                    ),
                    Spacer(flex: 2,),
                  ]
              ),
              Spacer(flex: 2,),
            ]
        ),
      ),
    );
  }
}
