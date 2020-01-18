import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO this is just a copy of HomePage. Make a login page
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Screen')),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: _createBody(),
      ),
    );
  }

  Widget _createBody() {
    return StreamBuilder(
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
          //return Center(child: CircularProgressIndicator());
        });
  }
}
