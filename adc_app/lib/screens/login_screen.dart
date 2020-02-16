import 'package:adc_app/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:adc_app/util/auth.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
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
            child: ListView(children: <Widget>[
              Text("Welcome to Atlanta Doula Connect",
                  textAlign: TextAlign.center),
              _loginForm(),
              SizedBox(
                height: 20,
              ),
              Text("Don't have an account?",
                  textAlign: TextAlign.center
              ),
              SizedBox(
                height: 5,
              ),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: themeColors['lightBlue'])),
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
          SizedBox(
            height: 100,
          ),
          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: themeColors['yellow'])),
              color: themeColors["yellow"],
              textColor: Colors.black,
              padding: EdgeInsets.all(15.0),
              child: Text("LOG IN"),
              onPressed: () async {
                final form = _loginFormKey.currentState;
                if (form.validate()) {
                  form.save();
                  try {
                    AuthResult result = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailInputController.text.toString().trim(),
                            password:
                                _pwdInputController.text.toString().trim());

                    FirebaseUser user = result.user;
                    userId = user.uid;

                    print("successful login of userid: $userId");

                    if (userId.length > 0 && userId != null) {
                      Navigator.pushNamed(context, '/clientHome');
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
