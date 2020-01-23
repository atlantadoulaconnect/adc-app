import 'package:adc_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_app/util/auth.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;

  HomePage({this.auth});

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: _createBody(context),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          Text("Atlanta Doula Connect", style: TextStyle(fontSize: 50.0)),
          Spacer(
            flex: 3,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(color: themeColors['mediumBlue'])),
            onPressed: () {
              Navigator.pushNamed(context, '/clientSignup');
            },
            color: themeColors['mediumBlue'],
            textColor: Colors.white,
            padding: EdgeInsets.all(15.0),
            splashColor: themeColors['mediumBlue'],
            child: Text(
              "Request a Doula",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Spacer(),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(color: themeColors['lightBlue'])),
            onPressed: () {
              Navigator.pushNamed(context, '/doulaSignup');
            },
            color: themeColors['lightBlue'],
            textColor: Colors.white,
            padding: EdgeInsets.all(15.0),
            splashColor: themeColors['lightBlue'],
            child: Text(
              "Apply as a Doula",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(color: themeColors['yellow'])),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            color: themeColors['yellow'],
            textColor: Colors.black,
            padding: EdgeInsets.all(15.0),
            splashColor: themeColors['yellow'],
            child: Text(
              "Log In",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
