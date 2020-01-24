import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';

class ClientAppPersonalInfoPage extends StatefulWidget {
  ClientAppPersonalInfoPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClientAppPersonalInfoPageState createState() => _ClientAppPersonalInfoPageState();
}

class _ClientAppPersonalInfoPageState extends State<ClientAppPersonalInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Personal Information',
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
                valueColor: AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                value: 0,
              ),
            ),
            Spacer(flex: 2,),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Spacer(flex: 2,),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Birthday (MM/DD/YYYY)',
                  prefixIcon: Icon(Icons.cake),
                  suffixIcon: Icon(Icons.calendar_today)
                ),
              ),
            ),
            Spacer(flex: 2,),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ),
            Spacer(flex: 2,),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone 2 (Optional)',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ),
            Spacer(flex: 3,),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: themeColors['yellow'])),
              onPressed: () {
                Navigator.pushNamed(context, '/clientAppContact');
              },
              color: themeColors['yellow'],
              textColor: Colors.black,
              padding: EdgeInsets.all(15.0),
              splashColor: themeColors['yellow'],
              child: Text(
                "NEXT",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ClientAppContactPage extends StatefulWidget {
  ClientAppContactPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClientAppContactPageState createState() => _ClientAppContactPageState();
}

class _ClientAppContactPageState extends State<ClientAppContactPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column( // TODO: Make screen scrollable
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Emergency Contacts',
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
                valueColor: AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                value: 0.2,
              ),
            ),
            Spacer(),
            Text(
              'Emergency Contact 1',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: themeColors['black'],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Spacer(),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Relationship',
                    prefixIcon: Icon(Icons.people),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone 2 (Optional)',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ),
//            Spacer(),
//            Text(
//              'Emergency Contact 2',
//              style: TextStyle(
//                fontFamily: 'Roboto',
//                color: themeColors['black'],
//                fontWeight: FontWeight.bold,
//                fontSize: 20,
//              ),
//            ),
//            Spacer(),
//            Container(
//              width: 300.0,
//              child: TextField(
//                autocorrect: false,
//                textCapitalization: TextCapitalization.words,
//                decoration: InputDecoration(
//                  border: OutlineInputBorder(),
//                  labelText: 'Name',
//                  prefixIcon: Icon(Icons.person),
//                ),
//              ),
//            ),
//            Spacer(),
//            Container(
//              width: 300.0,
//              child: TextField(
//                autocorrect: false,
//                textCapitalization: TextCapitalization.words,
//                decoration: InputDecoration(
//                  border: OutlineInputBorder(),
//                  labelText: 'Relationship',
//                  prefixIcon: Icon(Icons.people),
//                ),
//              ),
//            ),
//            Spacer(),
//            Container(
//              width: 300.0,
//              child: TextField(
//                autocorrect: false,
//                keyboardType: TextInputType.phone,
//                decoration: InputDecoration(
//                  border: OutlineInputBorder(),
//                  labelText: 'Phone',
//                  prefixIcon: Icon(Icons.phone),
//                ),
//              ),
//            ),
//            Spacer(),
//            Container(
//              width: 300.0,
//              child: TextField(
//                autocorrect: false,
//                keyboardType: TextInputType.phone,
//                decoration: InputDecoration(
//                  border: OutlineInputBorder(),
//                  labelText: 'Phone 2 (Optional)',
//                  prefixIcon: Icon(Icons.phone),
//                ),
//              ),
//            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['lightBlue'])),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: themeColors['lightBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['lightBlue'],
                  child: Text(
                    "PREVIOUS",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['yellow'])),
                  onPressed: () {
                    Navigator.pushNamed(context, '/clientAppCurrentBirthInfo');
                  },
                  color: themeColors['yellow'],
                  textColor: Colors.black,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['yellow'],
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ]
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ClientAppCurrentBirthInfoPage extends StatefulWidget {
  ClientAppCurrentBirthInfoPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClientAppCurrentBirthInfoPageState createState() => _ClientAppCurrentBirthInfoPageState();
}

class _ClientAppCurrentBirthInfoPageState extends State<ClientAppCurrentBirthInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Current Birth Information',
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
                valueColor: AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                value: 0.4,
              ),
            ),
            Spacer(flex: 2,),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Due Date (MM/DD/YYYY)',
                    prefixIcon: Icon(Icons.cake),
                    suffixIcon: Icon(Icons.calendar_today)
                ),
              ),
            ),
            Spacer(flex: 2,),
            Container( // TODO: change to a dropdown
              width: 300.0,
              child: TextField(
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Planned Birth Location',
                  prefixIcon: Icon(Icons.local_hospital),
                ),
              ),
            ),
            Spacer(flex: 2,),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'If other, name here',
                  prefixIcon: Icon(Icons.local_hospital),
                ),
              ),
            ),
            Spacer(flex: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['lightBlue'])),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: themeColors['lightBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['lightBlue'],
                  child: Text(
                    "PREVIOUS",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['yellow'])),
                  onPressed: () {
                    Navigator.pushNamed(context, '/clientAppPreviousBirthInfo');
                  },
                  color: themeColors['yellow'],
                  textColor: Colors.black,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['yellow'],
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ]
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ClientAppPreviousBirthInfoPage extends StatefulWidget {
  ClientAppPreviousBirthInfoPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClientAppPreviousBirthInfoPageState createState() => _ClientAppPreviousBirthInfoPageState();
}

class _ClientAppPreviousBirthInfoPageState extends State<ClientAppPreviousBirthInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Previous Birth Information',
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
                valueColor: AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                value: 0.6,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['lightBlue'])),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: themeColors['lightBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['lightBlue'],
                  child: Text(
                    "PREVIOUS",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['yellow'])),
                  onPressed: () {
                    Navigator.pushNamed(context, '/clientAppDoulaQuestions');
                  },
                  color: themeColors['yellow'],
                  textColor: Colors.black,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['yellow'],
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ]
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ClientAppDoulaQuestionsPage extends StatefulWidget {
  ClientAppDoulaQuestionsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClientAppDoulaQuestionsPageState createState() => _ClientAppDoulaQuestionsPageState();
}

class _ClientAppDoulaQuestionsPageState extends State<ClientAppDoulaQuestionsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Doula Questions',
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
                valueColor: AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                value: 0.8,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['lightBlue'])),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: themeColors['lightBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['lightBlue'],
                  child: Text(
                    "PREVIOUS",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['yellow'])),
                  onPressed: () {
                    Navigator.pushNamed(context, '/clientAppPhotoRelease');
                  },
                  color: themeColors['yellow'],
                  textColor: Colors.black,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['yellow'],
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ]
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ClientAppPhotoReleasePage extends StatefulWidget {
  ClientAppPhotoReleasePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClientAppPhotoReleasePageState createState() => _ClientAppPhotoReleasePageState();
}

class _ClientAppPhotoReleasePageState extends State<ClientAppPhotoReleasePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Photo Release',
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
                valueColor: AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                value: 1,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['lightBlue'])),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: themeColors['lightBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['lightBlue'],
                  child: Text(
                    "PREVIOUS",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['yellow'])),
                  onPressed: () {
                    Navigator.pushNamed(context, '/clientAppConfirmation');
                  },
                  color: themeColors['yellow'],
                  textColor: Colors.black,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['yellow'],
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ]
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ClientAppConfirmationPage extends StatefulWidget {
  ClientAppConfirmationPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClientAppConfirmationPageState createState() => _ClientAppConfirmationPageState();
}

class _ClientAppConfirmationPageState extends State<ClientAppConfirmationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Confirmation',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: themeColors['emoryBlue'],
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['lightBlue'])),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: themeColors['lightBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['lightBlue'],
                  child: Text(
                    "PREVIOUS",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: themeColors['yellow'])),
                  onPressed: () {
                    Navigator.pushNamed(context, '/clientAppRequestSent');
                  },
                  color: themeColors['yellow'],
                  textColor: Colors.black,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['yellow'],
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ]
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ClientAppRequestSentPage extends StatefulWidget {
  ClientAppRequestSentPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClientAppRequestSentPageState createState() => _ClientAppRequestSentPageState();
}

class _ClientAppRequestSentPageState extends State<ClientAppRequestSentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Request Sent!',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: themeColors['emoryBlue'],
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Spacer(),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: themeColors['yellow'])),
              onPressed: () {
                Navigator.pushNamed(context, '/');
                // TODO: Reset Navigator stack
              },
              color: themeColors['yellow'],
              textColor: Colors.black,
              padding: EdgeInsets.all(15.0),
              splashColor: themeColors['yellow'],
              child: Text(
                "RETURN HOME",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}