import 'package:adc_app/frontend/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import '../../../../backend/states/appState.dart';

class ClientSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Request a Doula")),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[Text("Sign Up")])));
  }
}
