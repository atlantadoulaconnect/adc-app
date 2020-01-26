import 'package:adc_app/screens/applications/doula_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/util/auth.dart';
import 'package:adc_app/models/doula.dart';

class DoulaSignupPage extends StatefulWidget {
  DoulaSignupPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DoulaSignupPageState();
}

class _DoulaSignupPageState extends State<DoulaSignupPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  TextEditingController _emailInputController;
  TextEditingController _pwdInputController;
  TextEditingController _confirmPwdInputController;

  String userId;
  Key key;

  @override
  void initState() {
    _emailInputController = new TextEditingController();
    _pwdInputController = new TextEditingController();
    _confirmPwdInputController = new TextEditingController();

    key = widget.key;
    super.initState();
  }

  void resetForm() {
    _registerFormKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Apply to be an ADC Doula"),
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
                  color: themeColors["lightBlue"],
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
              decoration: InputDecoration(
                  labelText: "Email*",
                  hintText: "jane.doe@gmail.com",
                  icon: new Icon(Icons.mail, color: themeColors["coolGray5"])),
              controller: _emailInputController,
              validator: emailValidator,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Password*",
                  hintText: "********",
                  icon: new Icon(Icons.lock, color: themeColors["coolGray5"])),
              controller: _pwdInputController,
              obscureText: true,
              validator: pwdValidator,
            ),
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Confirm Password*",
                    hintText: "********",
                    icon:
                        new Icon(Icons.lock, color: themeColors["coolGray5"])),
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
                final form = _registerFormKey.currentState;
                if (form.validate()) {
                  form.save();
                  try {
                    AuthResult result = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailInputController.text.toString().trim(),
                            password:
                                _pwdInputController.text.toString().trim());
                    FirebaseUser user = result.user;
                    userId = user.uid;
                    print("sign up returned user id: $userId");

                    if (userId.length > 0 && userId != null) {
                      Doula doulaApplicant = new Doula(userId, "doula",
                          _emailInputController.text.toString().trim());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DoulaAppPage(key: key, user: doulaApplicant)),
                      );
                    } else {
                      print("invalid user id returned from firebase");
                    }
                  } catch (e) {
                    print("Doula account sign up error: $e");
                    form.reset();
                  }
                }
              },
            )
          ],
        ));
  }
}
