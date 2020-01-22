import 'package:adc_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Screen')),
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
              color: themeColors['lightBlue'],
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
              Navigator.pushNamed(context, '/doulaApp');
            },
            color: themeColors['lightBlue'],
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
            color: themeColors['yellow'],
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

    //return Center(child: CircularProgressIndicator());
  }
}
