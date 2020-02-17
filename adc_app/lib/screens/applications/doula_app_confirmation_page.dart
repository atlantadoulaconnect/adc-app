import 'package:adc_app/screens/applications/doula_app_completion_page.dart';
import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/doula.dart';

class DoulaAppConfirmationPage extends StatefulWidget {
  Doula user;
  DoulaAppConfirmationPage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor doula app: \n${user.toString()}");
  }
  @override
  _DoulaAppConfirmationPage createState() => _DoulaAppConfirmationPage();
}

class _DoulaAppConfirmationPage extends State<DoulaAppConfirmationPage> {
  Doula currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    currentUser = widget.user;
    print("currentUser initState state: \n${currentUser.toString()}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidate: false,
            child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Confirmation',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: themeColors['emoryBlue'],
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            height: 1.5),
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Personal Information',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Name: ${currentUser.name}',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontSize: 18,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Birthday: ${currentUser.bday}',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontSize: 18,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Phone: ${currentUser.phone}',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontSize: 18,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Bio: ${currentUser.bio}',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontSize: 18,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Doula Questions',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Certified doula: ${currentUser.getYesOrNoFromBool(currentUser.certified)}',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontSize: 18,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Working towards doula certification: ${currentUser.getYesOrNoFromBool(currentUser.certInProgress)}',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontSize: 18,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Certificate Program: ${currentUser.certProgram} ',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontSize: 18,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Births Needed: ${currentUser.birthsNeeded}',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontSize: 18,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Availability:  ',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontSize: 18,
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Photo Release: ',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: themeColors['black'],
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.5),
                      textAlign: TextAlign.left,
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
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DoulaAppCompletionPage(
                                              key: key, user: currentUser)));
                            }
                          },
                          color: themeColors['yellow'],
                          textColor: Colors.white,
                          padding: EdgeInsets.all(15.0),
                          splashColor: themeColors['yellow'],
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: themeColors['black'],
                            ),
                          ),
                        ),
                      ]),
                ]


            ),
      ),
      ),
    );
  }
}
