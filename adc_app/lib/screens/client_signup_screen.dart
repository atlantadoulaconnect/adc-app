import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_app/screens/home_screen.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/util/auth.dart';

class ClientSignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClientSignupPageState();
}

class _ClientSignupPageState extends State<ClientSignupPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  TextEditingController _nameInputController;
  TextEditingController _emailInputController;
  TextEditingController _pwdInputController;
  TextEditingController _confirmPwdInputController;

  bool _isLoading;

  @override
  initState() {
    _nameInputController = new TextEditingController();
    _emailInputController = new TextEditingController();
    _pwdInputController = new TextEditingController();
    _confirmPwdInputController = new TextEditingController();

    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Request a Doula"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text("Sign Up"),
              _registerForm(),
              Text("Already have an account?"),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  color: themeColors["yellow"],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  child: Text("LOG IN")),
            ],
          )),
        ));
  }

  Widget _registerForm() {
    return Form(
        key: _registerFormKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration:
                  InputDecoration(labelText: "Name*", hintText: "Jane D."),
              controller: _nameInputController,
              validator: (val) {
                if (val.length < 3) {
                  return "Please enter a valid name.";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Email*", hintText: "jane.doe@gmail.com"),
              controller: _emailInputController,
              validator: emailValidator,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: "Password*", hintText: "********"),
              controller: _pwdInputController,
              obscureText: true,
              validator: pwdValidator,
            ),
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Confirm Password*", hintText: "********"),
                controller: _confirmPwdInputController,
                obscureText: true,
                validator: (val) {
                  if (val != _pwdInputController.text)
                    return "Passwords do not match.";
                  return null;
                }),
            FlatButton(
              color: themeColors["yellow"],
              textColor: Colors.black,
              padding: EdgeInsets.all(15.0),
              child: Text("SIGN UP"),
              onPressed: () async {
                if (_registerFormKey.currentState.validate()) {
                  _registerFormKey.currentState.save();
                  try {
                    FirebaseAuth _mAuth = FirebaseAuth.instance;
                    _mAuth.createUserWithEmailAndPassword(
                      email: _emailInputController.text, password: _pwdInputController.text)
                    .then((currentUser) => Firestore.instance
                      .collection("users")
                      .document(currentUser.uid))
                      .setData({
                        "name": _nameInputController.text,
                        "email": _emailInputController.text
                    }))
                  } catch (e) {
                    print("Error: $e");
                  }
                }
              },
            )
          ],
        ));
  }
}
