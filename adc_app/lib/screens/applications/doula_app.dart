import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/user.dart';
import 'package:adc_app/models/doula.dart';
import 'package:adc_app/util/auth.dart';

class DoulaAppPage extends StatefulWidget {
  Doula user;
  DoulaAppPage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor doula app: \n${user.toString()}");
  }

  @override
  _DoulaAppHomePage createState() => _DoulaAppHomePage();
}

class _DoulaAppHomePage extends State<DoulaAppPage> {
  Doula currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers

  @override
  void initState() {
    currentUser = widget.user;
    print("currentUser initState doula app state: \n${currentUser.toString()}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "currentUser initState doula app state build method: \n${currentUser.toString()}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Doula Application"),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            autovalidate: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Text(
                  'Personal Information',
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
                    valueColor:
                        AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                    value: 0.2,
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                  width: 300.0,
                  child: TextField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                  width: 300.0,
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Birthday (MM/DD/YYYY)',
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                  width: 300.0,
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                  width: 300.0,
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Alternate Phone (optional)',
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                Row(children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: themeColors['mediumBlue'])),
                    onPressed: () {
                      Navigator.pushNamed(context, '/clientSignup');
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
                  Spacer(
                    flex: 2,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: themeColors['yellow'])),
                    onPressed: () {
                      Navigator.pushNamed(context, '/doulaAppPage2');
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
                  Spacer(
                    flex: 2,
                  ),
                ]),
                Spacer(
                  flex: 3,
                ),
              ],
        )
        ),
      ),
    );
  }
}
