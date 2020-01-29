import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/doula.dart';

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
        title: Text('Doula Application'),
      ),
      body: Center(
          child: Form(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              Text(
                'Short Bio',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['emoryBlue'],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Spacer(),
              Container(
                width: 250,
                child: LinearProgressIndicator(
                  backgroundColor: themeColors['skyBlue'],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                  value: 0.4,
                ),
              ),
              Spacer(
                flex: 3,
              ),
              Text(
                'Please enter a brief description that your \nclients will be able to see',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Spacer(),
              Container(
                width: 300.0,
                height: 300.0,
                child: TextField(
                  minLines: 12,
                  maxLines: 12,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '',
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Row(children: <Widget>[
                Spacer(
                  flex: 2,
                ),
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
                Spacer(
                  flex: 2,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: themeColors['yellow'])),
                  onPressed: () {
                    Navigator.pushNamed(context, '/doulaAppPage3');
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
                Spacer(
                  flex: 2,
                ),
              ]),
              Spacer(
                flex: 3,
              ),
            ]),
      )),
    );
  }
}
