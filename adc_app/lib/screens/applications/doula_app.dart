import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/user.dart';
import 'package:adc_app/models/doula.dart';
import 'package:adc_app/util/auth.dart';

import 'doula_app_page2.dart';

class DoulaAppPage extends StatefulWidget {
  Doula user;
  DoulaAppPage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor doula app: \n${user.toString()}");
  }

  @override
  _DoulaAppHomePage createState() => _DoulaAppHomePage();
}

class _DoulaAppHomePage extends State<DoulaAppPage> {
  Doula currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  TextEditingController _nameController;
  TextEditingController _bdayController;
  TextEditingController _phoneController;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print("currentUser initState doula app state: \n${currentUser.toString()}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "currentUser initState doula app state build method: \n${currentUser.toString()}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Doula Application"),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            autovalidate: false,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Personal Information',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 250,
                    child: LinearProgressIndicator(
                      backgroundColor: themeColors['skyBlue'],
                      valueColor:
                      AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                      value: 0.2,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 300.0,
                    child: TextField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 300.0,
                    child: TextField(
                      autocorrect: false,
                      keyboardType: TextInputType.datetime,
                      controller: _bdayController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Birthday (MM/DD/YYYY)',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 300.0,
                    child: TextField(
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 300.0,
                    child: TextField(
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Alternate Phone (optional)',
                      ),
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: themeColors['mediumBlue'])),
                    onPressed: () {
                      Navigator.pushNamed(context, '/doulaSignup');
                    },
                    color: themeColors['mediumBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['mediumBlue'],
                    child: Text(
                      "Back",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: themeColors['yellow'])),
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();

                        currentUser.name = _nameController.toString().trim();
                        currentUser.bday = _bdayController.toString().trim();
                        currentUser.phone = _phoneController.toString().trim();

                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DoulaAppPage2(
                                        key: key, user: currentUser)));
                      }
                    },
                    color: themeColors['yellow'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['yellow'],
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: themeColors['black'],
                      ),
                    ),
                  ),
                ]),
              ],
        )
        ),
      ),
    );
  }
}
