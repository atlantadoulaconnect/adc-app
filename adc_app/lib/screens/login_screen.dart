import 'package:adc_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_app/util/auth.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;

  LoginPage({this.auth, this.loginCallback});

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();

  TextEditingController _emailInputController;
  TextEditingController _pwdInputController;

  String userId;

  @override
  initState() {
    _emailInputController = new TextEditingController();
    _pwdInputController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log In"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Text("Welcome to Atlanta Doula Connect"),
              _loginForm(),
              Text("Don't have an account?"),
              FlatButton(
                  color: themeColors["lightBlue"],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  child: Text("SIGN UP"),
                  onPressed: () {
                    // TODO navigate to sign up screen
                  }),
            ])));
  }

  Widget _loginForm() {
    return Form(
        key: _loginFormKey,
        autovalidate: false,
        child: Column(children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: "Email",
                hintText: "jane.doe@gmail.com",
                icon: new Icon(Icons.mail, color: themeColors["coolGray5"])),
            controller: _emailInputController,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value.isEmpty ? "Please enter email" : null,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Password",
                hintText: "********",
                icon: new Icon(Icons.lock, color: themeColors["coolGray5"])),
            controller: _pwdInputController,
            maxLines: 1,
            obscureText: true,
            validator: (value) =>
                value.isEmpty ? "Please enter password" : null,
          ),
          FlatButton(
              color: themeColors["yellow"],
              textColor: Colors.black,
              padding: EdgeInsets.all(15.0),
              child: Text("LOG IN"),
              onPressed: () async {
                final form = _loginFormKey.currentState;
                if (form.validate()) {
                  form.save();
                  try {
                    userId = await widget.auth.signIn(
                        _emailInputController.text, _pwdInputController.text);
                    if (userId.length > 0 && userId != null) {
                      widget.loginCallback();
                      // TODO navigate to user specific home screen
                    }
                  } catch (e) {
                    print("Login error: $e");
                    form.reset();
                  }
                }
              }),
        ]));
  }
}
