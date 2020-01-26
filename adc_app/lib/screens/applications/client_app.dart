import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/contact.dart';
import 'package:adc_app/models/client.dart';
import 'package:adc_app/util/auth.dart';

class ClientAppPersonalInfoPage extends StatefulWidget {
  Client user;
  ClientAppPersonalInfoPage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor client app state: \n${user.toString()}");
  }

  @override
  _ClientAppPersonalInfoPageState createState() =>
      _ClientAppPersonalInfoPageState();
}

class _ClientAppPersonalInfoPageState extends State<ClientAppPersonalInfoPage> {
  Client currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  TextEditingController _nameController;
  TextEditingController _bdayController;
  TextEditingController _phoneController;
  TextEditingController _altPhoneController;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");

    _nameController = new TextEditingController();
    _bdayController = new TextEditingController();
    _phoneController = new TextEditingController();
    _altPhoneController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "currentUser initState client app state build method: \n${currentUser.toString()}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Doula"),
      ),
      body: Center(
          child: Form(
              key: _formKey,
              autovalidate: false,
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                          themeColors['mediumBlue']),
                      value: 0,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      controller: _nameController,
                      validator: nameValidator,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Birthday (MM/DD/YYYY)',
                          prefixIcon: Icon(Icons.cake),
                          suffixIcon: Icon(Icons.calendar_today)),
                      controller: _bdayController,
                      validator: bdayValidator,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      controller: _phoneController,
                      validator: phoneValidator,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone 2 (Optional)',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      controller: _altPhoneController,
                      validator: altPhoneValidator,
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        side: BorderSide(color: themeColors['yellow'])),
                    onPressed: () {
                      //Navigator.pushNamed(context, '/clientAppContact');
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        try {
                          print(currentUser.toString());
                          currentUser.name =
                              _nameController.text.toString().trim();
                          currentUser.addPhone(
                              _phoneController.text.toString().trim());
                          if (_altPhoneController
                              .toString()
                              .trim()
                              .isNotEmpty) {
                            currentUser.addPhone(
                                _altPhoneController.toString().trim());
                          }
                          currentUser.bday =
                              _bdayController.text.toString().trim();

                          print(
                              "userid: ${currentUser.userid}\ntype: ${currentUser.userType}\nname: ${currentUser.name}\nemail: ${currentUser.email}\nphone: ${_phoneController.text.toString().trim()}\nbday: ${currentUser.bday}");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientAppContactPage(
                                      key: key, user: currentUser)));
                        } catch (e) {
                          print(e);
                        }
                      }
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
              ))),
    );
  }
}

class ClientAppContactPage extends StatefulWidget {
  Client user;
  Key key;
  ClientAppContactPage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor client app state: \n${user.toString()}");
  }

  @override
  _ClientAppContactPageState createState() => _ClientAppContactPageState();
}

class _ClientAppContactPageState extends State<ClientAppContactPage> {
  Client currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  TextEditingController _nameController;
  TextEditingController _relationshipController;
  TextEditingController _phoneController;
  TextEditingController _altPhoneController;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");

    _nameController = new TextEditingController();
    _relationshipController = new TextEditingController();
    _phoneController = new TextEditingController();
    _altPhoneController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Doula"),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        autovalidate: false,
        child: Column(
          // TODO: Make screen scrollable
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
                valueColor:
                    AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
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
              child: TextFormField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  controller: _nameController,
                  validator: nameValidator),
            ),
            Spacer(),
            Container(
              width: 300.0,
              child: TextFormField(
                autocorrect: false,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Relationship',
                  prefixIcon: Icon(Icons.people),
                ),
                controller: _relationshipController,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please enter how this contact is related to you.";
                  }
                  return null;
                },
              ),
            ),
            Spacer(),
            Container(
              width: 300.0,
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                ),
                controller: _phoneController,
                validator: phoneValidator,
              ),
            ),
            Spacer(),
            Container(
              width: 300.0,
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone 2 (Optional)',
                  prefixIcon: Icon(Icons.phone),
                ),
                controller: _altPhoneController,
                validator: altPhoneValidator,
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
                      color: themeColors['yellow'],
                      textColor: Colors.black,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['yellow'],
                      child: Text(
                        "NEXT",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();

                          try {
                            Contact ec1 = new Contact(
                                _nameController.text.toString().trim(),
                                _relationshipController.text.toString().trim(),
                                _phoneController.text.toString().trim());

                            currentUser.addContact(ec1);
                          } catch (e) {
                            print(e);
                          }

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ClientAppCurrentBirthInfoPage(
                                          key: key, user: currentUser)));
                        }
                      }),
                ]),
            Spacer(),
          ],
        ),
      )),
    );
  }
}

class ClientAppCurrentBirthInfoPage extends StatefulWidget {
  Client user;
  ClientAppCurrentBirthInfoPage({Key key, @required this.user})
      : super(key: key) {
    print("currentUser constructor client app state: \n${user.toString()}");
  }

  @override
  _ClientAppCurrentBirthInfoPageState createState() =>
      _ClientAppCurrentBirthInfoPageState();
}

class _ClientAppCurrentBirthInfoPageState
    extends State<ClientAppCurrentBirthInfoPage> {
  Client currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  TextEditingController _nameController;
  TextEditingController _bdayController;
  TextEditingController _phoneController;
  TextEditingController _altPhoneController;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");

    _nameController = new TextEditingController();
    _bdayController = new TextEditingController();
    _phoneController = new TextEditingController();
    _altPhoneController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Doula"),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        autovalidate: false,
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
                valueColor:
                    AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                value: 0.4,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Container(
              width: 300.0,
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Due Date (MM/DD/YYYY)',
                    prefixIcon: Icon(Icons.cake),
                    suffixIcon: Icon(Icons.calendar_today)),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Container(
              // TODO: change to a dropdown
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
            Spacer(
              flex: 2,
            ),
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
            Spacer(
              flex: 3,
            ),
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
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClientAppPreviousBirthInfoPage(
                                        key: key, user: currentUser)));
                      }
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
                ]),
            Spacer(),
          ],
        ),
      )),
    );
  }
}

class ClientAppPreviousBirthInfoPage extends StatefulWidget {
  Client user;
  ClientAppPreviousBirthInfoPage({Key key, @required this.user})
      : super(key: key) {
    print("currentUser constructor client app state: \n${user.toString()}");
  }

  @override
  _ClientAppPreviousBirthInfoPageState createState() =>
      _ClientAppPreviousBirthInfoPageState();
}

class _ClientAppPreviousBirthInfoPageState
    extends State<ClientAppPreviousBirthInfoPage> {
  Client currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  TextEditingController _nameController;
  TextEditingController _bdayController;
  TextEditingController _phoneController;
  TextEditingController _altPhoneController;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");

    _nameController = new TextEditingController();
    _bdayController = new TextEditingController();
    _phoneController = new TextEditingController();
    _altPhoneController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Doula"),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        autovalidate: false,
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
                valueColor:
                    AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
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
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClientAppDoulaQuestionsPage(
                                        key: key, user: currentUser)));
                      }
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
                ]),
            Spacer(),
          ],
        ),
      )),
    );
  }
}

class ClientAppDoulaQuestionsPage extends StatefulWidget {
  Client user;
  ClientAppDoulaQuestionsPage({Key key, @required this.user})
      : super(key: key) {
    print("currentUser constructor client app state: \n${user.toString()}");
  }

  @override
  _ClientAppDoulaQuestionsPageState createState() =>
      _ClientAppDoulaQuestionsPageState();
}

class _ClientAppDoulaQuestionsPageState
    extends State<ClientAppDoulaQuestionsPage> {
  Client currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  TextEditingController _nameController;
  TextEditingController _bdayController;
  TextEditingController _phoneController;
  TextEditingController _altPhoneController;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");

    _nameController = new TextEditingController();
    _bdayController = new TextEditingController();
    _phoneController = new TextEditingController();
    _altPhoneController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Doula"),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        autovalidate: false,
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
                valueColor:
                    AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
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
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClientAppPhotoReleasePage(
                                    key: key, user: currentUser)));
                      }
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
                ]),
            Spacer(),
          ],
        ),
      )),
    );
  }
}

class ClientAppPhotoReleasePage extends StatefulWidget {
  Client user;
  ClientAppPhotoReleasePage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor client app state: \n${user.toString()}");
  }

  @override
  _ClientAppPhotoReleasePageState createState() =>
      _ClientAppPhotoReleasePageState();
}

class _ClientAppPhotoReleasePageState extends State<ClientAppPhotoReleasePage> {
  Client currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  TextEditingController _nameController;
  TextEditingController _bdayController;
  TextEditingController _phoneController;
  TextEditingController _altPhoneController;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");

    _nameController = new TextEditingController();
    _bdayController = new TextEditingController();
    _phoneController = new TextEditingController();
    _altPhoneController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Doula"),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        autovalidate: false,
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
                valueColor:
                    AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
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
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClientAppConfirmationPage(
                                    key: key, user: currentUser)));
                      }
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
                ]),
            Spacer(),
          ],
        ),
      )),
    );
  }
}

class ClientAppConfirmationPage extends StatefulWidget {
  Client user;
  ClientAppConfirmationPage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor client app state: \n${user.toString()}");
  }

  @override
  _ClientAppConfirmationPageState createState() =>
      _ClientAppConfirmationPageState();
}

class _ClientAppConfirmationPageState extends State<ClientAppConfirmationPage> {
  Client currentUser;
  Key key;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Doula"),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(),
            Text('Confirmation',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: themeColors['emoryBlue'],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5),
                textAlign: TextAlign.center),
            Text(
              ' Personal Information',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Name: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Birthday: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Phone: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Phone 2 (Optional): ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Emergency Contacts',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 2),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Emergency Contact 1: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Name: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Relationship: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Phone: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Phone 2 (Optional): ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Current Birth Information',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Due Date: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Planned Birth Location: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Birth type: ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Are you planning to have/do you want to have an epidural? : ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Are you expecting to have a cesarean section? (C-section)? : ',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
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
                ]),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ClientAppRequestSentPage extends StatefulWidget {
  //todo change remove user from constructor
  Client user;
  ClientAppRequestSentPage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor client app state: \n${user.toString()}");
  }

  @override
  _ClientAppRequestSentPageState createState() =>
      _ClientAppRequestSentPageState();
}

class _ClientAppRequestSentPageState extends State<ClientAppRequestSentPage> {
  Client currentUser;
  Key key;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Request a Doula"),
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
        ));
  }
}
