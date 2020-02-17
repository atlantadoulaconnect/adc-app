import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/doula.dart';

import 'doula_app_page3.dart';

class DoulaAppPage2 extends StatefulWidget {
  Doula user;
  DoulaAppPage2({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor doula app: \n${user.toString()}");
  }
  @override
  _DoulaAppPage2 createState() => _DoulaAppPage2();
}

class _DoulaAppPage2 extends State<DoulaAppPage2> {
  Doula currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print("currentUser initState state: \n${currentUser.toString()}");

    super.initState();
  }

  TextEditingController shortBio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doula Application'),
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
                  'Short Bio',
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
                      value: 0.4,
                    ),
                  ),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Please enter a brief description that your \nclients will be able to see',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    child: TextField(
                      minLines: 12,
                      maxLines: 12,
                      autocorrect: true,
                      controller: shortBio,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '',
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
                    Navigator.pop(context);
                  },
                  color: themeColors['mediumBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['mediumBlue'],
                  child: Text(
                    "PREVIOUS",
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

                      currentUser.bio = shortBio.toString().trim();

                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => DoulaAppPage3(
                                  key: key, user: currentUser)));
                    }
                  },

                  color: themeColors['yellow'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['yellow'],
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: themeColors['black'],
                    ),
                  ),
                ),
              ]),
            ]),
      )),
    );
  }
}
