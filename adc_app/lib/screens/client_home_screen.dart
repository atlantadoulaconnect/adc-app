import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  @override
  Widget build(BuildContext context) {
    // TODO: sprint 1 'your application has been submitted. you will be notified when ADC has finished their review'
    return Scaffold(
        appBar: AppBar(
          title: Text("Doula Application"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
              ),
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("LOG OUT"),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  print("signout success");
                } catch (e) {
                  print("sign out error $e");
                }
              },
            ),
          ],
        )));
  }
}
