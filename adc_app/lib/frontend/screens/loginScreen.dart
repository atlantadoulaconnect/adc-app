import 'package:adc_app/frontend/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import '../../backend/states/appState.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Log In")),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                children: <Widget>[Text("Welcome to Atlanta Doula Connect")])));
  }
}
