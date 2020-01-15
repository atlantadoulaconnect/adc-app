import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: NotePage(),
    );
  }
}

class NotePage extends StatelessWidget {
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
              return Text(doc['name'] + '\n' + doc['typeName']);
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
