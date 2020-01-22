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
          StreamBuilder(
            // tester stream builder
            stream: Firestore.instance
                .collection('testCollection')
                .document('testDoc1')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var doc = snapshot.data;
                if (doc.exists) {
                  return Text(doc['name']);
                }
                return Text('doc doesnt exist');
              } else if (snapshot.hasError) {
                return Text('snapshot.error.toString()');
              }
              return Text('no snapshot data, no error');
            },
          ),
          Spacer(
            flex: 3,
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.blueAccent)),
            onPressed: () {
              Navigator.pushNamed(context, '/doulaApp');
            },
            color: Colors.blue,
            textColor: Colors.white,
            padding: EdgeInsets.all(15.0),
            splashColor: Colors.blueAccent,
            child: Text(
              "Apply as a Doula",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Spacer(),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.blueAccent)),
            onPressed: () {
              Navigator.pushNamed(context, '/clientSignup');
            },
            color: Colors.blue,
            textColor: Colors.white,
            padding: EdgeInsets.all(15.0),
            splashColor: Colors.blueAccent,
            child: Text(
              "Request a Doula",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Spacer(
            flex: 3,
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.yellow)),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            color: Colors.yellow,
            textColor: Colors.black,
            padding: EdgeInsets.all(15.0),
            splashColor: Colors.blueAccent,
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
