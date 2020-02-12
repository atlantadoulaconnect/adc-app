import 'package:adc_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adc_app/util/auth.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: _createBody(context),
      ),
      drawer: Drawer(
        child: Container(
          color: themeColors['mediumBlue'],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: themeColors['yellow'],
                ),
//              child: Text(
//                'Drawer Header',
//                style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 24,
//                ),
//              ),
              ),
              ListTile(
                leading: Icon(
                  IconData(59530, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
                title: Text('Home',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () => Navigator.pushNamed(context, '/'),
              ),
              ListTile(
                leading: Icon(
                  IconData(59679, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
                title: Text('Request a Doula',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () => Navigator.pushNamed(context, '/clientSignup'),
              ),
              ListTile(
                leading: Icon(
                  IconData(57534, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
                title: Text('Apply as a Doula',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () => Navigator.pushNamed(context, '/doulaSignup'),
              ),
              ListTile(
                leading: Icon(
                  IconData(59448, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
                title: Text('Frequently asked Questions',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              ListTile(
                leading: Icon(
                  IconData(59534, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
                title: Text('About Atlanta Doula Connect',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              ListTile(
                leading: Icon(
                  IconData(59513, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
                title: Text('Log In',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () => Navigator.pushNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Spacer(
            flex: 1,
          ),
          Text("Atlanta Doula Connect",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              )),
          Spacer(
            flex: 2,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(color: themeColors['mediumBlue'])),
            onPressed: () {
              //Navigator.pushNamed(context, '/clientAppConfirmation'); //testing purposes
              Navigator.pushNamed(context, '/clientSignup');
            },
            color: themeColors['mediumBlue'],
            textColor: Colors.white,
            padding: EdgeInsets.all(15.0),
            splashColor: themeColors['mediumBlue'],
            child: Text(
              "Request a Doula",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Spacer(),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(color: themeColors['lightBlue'])),
            onPressed: () {
              Navigator.pushNamed(context, '/doulaSignup');
            },
            color: themeColors['lightBlue'],
            textColor: Colors.white,
            padding: EdgeInsets.all(15.0),
            splashColor: themeColors['lightBlue'],
            child: Text(
              "Apply as a Doula",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                side: BorderSide(color: themeColors['yellow'])),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            color: themeColors['yellow'],
            textColor: Colors.black,
            padding: EdgeInsets.all(15.0),
            splashColor: themeColors['yellow'],
            child: Text(
              "Log In",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
