import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/contact.dart';
import 'package:adc_app/models/client.dart';
import 'package:adc_app/util/auth.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:adc_app/util/sensitive.dart';

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
              child: ListView(
                children: <Widget>[

                  Padding(
                      padding: const EdgeInsets.all(8.0),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 250,
                        child: LinearProgressIndicator(
                          backgroundColor: themeColors['skyBlue'],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              themeColors['mediumBlue']),
                          value: 0,
                        ),
                      ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 300.0,
                        child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Birthday (MM/YYYY)',
                              prefixIcon: Icon(Icons.cake),
                              suffixIcon: Icon(Icons.calendar_today)),
                          controller: _bdayController,
                          validator: bdayValidator,
                        ),
                      ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                          currentUser.phone =
                              _phoneController.text.toString().trim();
//                          if (_altPhoneController
//                              .toString()
//                              .trim()
//                              .isNotEmpty) {
//                            currentUser.addPhone(
//                                _altPhoneController.toString().trim());
//                          }
                          currentUser.bday =
                              _bdayController.text.toString().trim();

                          print(
                              "userid: ${currentUser.userid}\ntype: ${currentUser.userType}\nname: ${currentUser.name}\nemail: ${currentUser.email}\nphone: ${currentUser.phone}\nbday: ${currentUser.bday}");

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
            child: ListView(

              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Emergency Contacts',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250,
                      child: LinearProgressIndicator(
                        backgroundColor: themeColors['skyBlue'],
                        valueColor: AlwaysStoppedAnimation<Color>(
                            themeColors['mediumBlue']),
                        value: 0.2,
                      ),
                    ),
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Emergency Contact 1',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Emergency Contact 2',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                                    _relationshipController.text
                                        .toString()
                                        .trim(),
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
              ],
            ),
          ),
        ));
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
  TextEditingController _dueDateController;
  TextEditingController _birthLocController;

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    _dueDateController = new TextEditingController();
    _birthLocController = new TextEditingController();
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");

    super.initState();
  }


  //drop down list
  List<DropdownMenuItem<String>> birthType = [];
  String selectedBirthType;

  List<DropdownMenuItem<String>> birthLocation = [];
  String selectedBirthLocation;
  int epiduralValue = 1;
  int cSectionValue = 1;
  void loadData() {
    birthType = [];
    birthType.add(new DropdownMenuItem(
      child: new Text('Singleton'),
      value: '1',
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('Twins'),
      value: '2',
    ));
    birthType.add(new DropdownMenuItem(
      child: new Text('Triplets'),
      value: '3',
    ));

    birthLocation = [];
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Northside'),
      value: '0',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Emory Decatur'),
      value: '1',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Grady'),
      value: '2',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('A Birthing Center'),
      value: '3',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('At Home'),
      value: '4',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('No plans'),
      value: '5',
    ));
    birthLocation.add(new DropdownMenuItem(
      child: new Text('Other (please specify below)'),
      value: '6',
    ));

  }


  @override
  Widget build(BuildContext context) {
    birthType = [];
    birthLocation = [];
    loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Doula"),
      ),
      body: Center(
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Current Birth Information',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['emoryBlue'],
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                ),
                // progress bar
                Padding(
                    padding: const EdgeInsets.all(8.0),
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
                // due date
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300.0,
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Due Date (MM/DD/YYYY)',
                            prefixIcon: Icon(Icons.cake),
                            suffixIcon: Icon(Icons.calendar_today)),
                        controller: _dueDateController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please enter your due date.";
                          }
                          return null;
                        },
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select your planned birth location:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                // drop down menu for birth location
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: selectedBirthLocation,
                        items: birthLocation,
                        hint: new Text('Birth Location'),
                        isExpanded: true,
                        onChanged: (value) {
                          selectedBirthLocation = value;
                          setState(() {
//                          if (selectedBirthCount == '0') {
//
//                          }
                          });
                        },



                      ),

                    )

                ),
                //if other, please specify
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200.0,
                    child: TextField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'If other, please specify',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select your birth type:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                // drop down menu for birth type
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: selectedBirthType,
                        items: birthType,
                        hint: new Text('Birth Type'),
                        isExpanded: true,
                        onChanged: (value) {
                          selectedBirthType = value;
                          setState(() {
//                          if (selectedBirthCount == '0') {
//
//                          }
                          });
                        },



                      ),

                    )

                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Are you planning on having an epidural?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: epiduralValue,
                      onChanged: (T) {
                        setState(() {
                          epiduralValue = T;
                        });
                      },
                    ),
                    Text(
                      'Yes'
                    ),
                    Radio(
                      value: 2,
                      groupValue: epiduralValue,
                      onChanged: (T) {
                        setState(() {
                          epiduralValue = T;
                        });
                      },
                    ),
                    Text(
                        'No'
                    ),
                    ]


                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Are you expecting to have a caesarean section (C-Section)?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: cSectionValue,
                        onChanged: (T) {
                          setState(() {
                            cSectionValue = T;
                          });
                        },
                      ),
                      Text(
                          'Yes'
                      ),
                      Radio(
                        value: 2,
                        groupValue: cSectionValue,
                        onChanged: (T) {
                          setState(() {
                            cSectionValue = T;
                          });
                        },
                      ),
                      Text(
                          'No'
                      ),
                    ]


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

                            currentUser.dueDate =
                                _dueDateController.text.toString().trim();
                            currentUser.birthLocation =
                                _birthLocController.text.toString().trim();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClientAppPreviousBirthInfoPage(
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

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
    print(
        "currentUser initState client app state: \n${currentUser.toString()}");

    super.initState();
  }
  //drop down list
  List<DropdownMenuItem<String>> birthCount = [];
  String selectedBirthCount;

  void loadData() {
     birthCount = [];
     birthCount.add(new DropdownMenuItem(
       child: new Text('0'),
       value: 'Zero',
     ));
     birthCount.add(new DropdownMenuItem(
       child: new Text('1'),
       value: 'One',
     ));
     birthCount.add(new DropdownMenuItem(
       child: new Text('2'),
       value: 'Two',
     ));
     birthCount.add(new DropdownMenuItem(
       child: new Text('3'),
       value: 'Three',
     ));
     birthCount.add(new DropdownMenuItem(
       child: new Text('4'),
       value: 'Four',
     ));

   }
  int pretermValue = 1;
  int lowBirthWeightValue = 1;
  bool vaginalBirth = false, cesarean = false, vbac = false;

  @override
  Widget build(BuildContext context) {

    loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text("Request a Doula"),
      ),
      body: Center(
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Previous Birth Information',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['emoryBlue'],
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250,
                      child: LinearProgressIndicator(
                        backgroundColor: themeColors['skyBlue'],
                        valueColor:
                        AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                        value: 0.6,
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Number of previous live births:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                // drop down menu for births
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      value: selectedBirthCount,
                      items: birthCount,
                      hint: new Text('Previous Births'),
                      isExpanded: true,
                      onChanged: (value) {
                        //print("value: $value");
                        setState(() {
                          selectedBirthCount = value;
                          //print("birth count: " + selectedBirthCount);
                          //if (selectedBirthCount.contains('1', 0)) {
                            //DisplayPreviousBirthInfo();
                          //}

                        });
                      },

                    ),

                  )

                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Were any of your previous life births: ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),

                //preterm
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 8, 0),
                  child: Text(
                    'Preterm: ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                  child: Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: pretermValue,
                          onChanged: (T) {
                            setState(() {
                              pretermValue = T;
                            });
                          },
                        ),
                        Text(
                            'Yes'
                        ),
                        Radio(
                          value: 2,
                          groupValue: pretermValue,
                          onChanged: (T) {
                            setState(() {
                              pretermValue = T;
                            });
                          },
                        ),
                        Text(
                            'No'
                        ),
                      ]


                  ),
                ),

                //low birth weight
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 8, 0),
                  child: Text(
                    'Low Birth Weight (< 2,500g):',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                  child: Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: lowBirthWeightValue,
                          onChanged: (T) {
                            setState(() {
                              lowBirthWeightValue = T;
                            });
                          },
                        ),
                        Text(
                            'Yes'
                        ),
                        Radio(
                          value: 2,
                          groupValue: lowBirthWeightValue,
                          onChanged: (T) {
                            setState(() {
                              lowBirthWeightValue = T;
                            });
                          },
                        ),
                        Text(
                            'No'
                        ),
                      ]


                  ),
                ),

                //Previous Birth Types
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Previous Birth Types (check all that apply): ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Vaginal Birth"),
                          Checkbox(
                            value: vaginalBirth,
                            onChanged: (bool value) {
                              setState(() {
                                vaginalBirth = value;
                              });
                            },
                          )
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Cesaerean"),
                          Checkbox(
                            value: cesarean,
                            onChanged: (bool value) {
                              setState(() {
                                cesarean = value;
                              });
                            },
                          )
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("VBAC"),
                          Checkbox(
                            value: vbac,
                            onChanged: (bool value) {
                              setState(() {
                                vbac = value;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
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
              ],
            ),
          )),
    );
  }
}

//TODO figure out how to call this method in a loop for previous birth info
class DisplayPreviousBirthInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Text("Trying This")
    ],
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
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Doula Questions',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                      width: 250,
                      child: LinearProgressIndicator(
                        backgroundColor: themeColors['skyBlue'],
                        valueColor: AlwaysStoppedAnimation<Color>(
                            themeColors['mediumBlue']),
                        value: 0.8,
                      ),
                    ),
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
                                        ClientAppPhotoReleasePage(
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
              ],
            ),
          ),
        ));
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
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Photo Release',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 250,
                    child: LinearProgressIndicator(
                      backgroundColor: themeColors['skyBlue'],
                      valueColor:
                      AlwaysStoppedAnimation<Color>(themeColors['mediumBlue']),
                      value: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Please read the following statements: '
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      'I, grant the Urban Health Initiative of Emory Photo/Video '
                          'permission to use any photographs in Emory’s own publications or in any other broadcast'
                          ',print,  or  electronic  media,  including—without  limitation—newspaper, radio,  '
                          'television,  magazine,  internet.  I  waive  any  right  to  inspect  or  approve  my  depictions'
                          '  in  these  works.     '
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      'I  agree  that  Emory  University  may  use  such  photographs  of  me  '
                          'and my infant with  or  without  my  name  and  for  any  lawful  purpose,  '
                          'including  for  example  such  purposes  as  publicity,  illustration,  '
                          'advertising,  and  Web  content.  '
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('CHECKBOX GOES HERE'
                  ),
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
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              ' Name: ${currentUser.name}',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Birthday: ${currentUser.bday}',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Phone: ${currentUser.phone}',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
//            Text(
//              ' Phone 2 (Optional): ',
//              style: TextStyle(
//                  fontFamily: 'Roboto',
//                  color: themeColors['black'],
//                  fontSize: 18,
//                  height: 1.5),
//              textAlign: TextAlign.left,
//            ),
            Text(
              ' Emergency Contacts:',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 2),
              textAlign: TextAlign.left,
            ),
            Text(
              ' ${currentUser.emergencyContacts[0].toString()}',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
//            Text(
//              ' Name: ',
//              style: TextStyle(
//                  fontFamily: 'Roboto',
//                  color: themeColors['black'],
//                  fontSize: 18,
//                  height: 1.5),
//              textAlign: TextAlign.left,
//            ),
//            Text(
//              ' Relationship: ',
//              style: TextStyle(
//                  fontFamily: 'Roboto',
//                  color: themeColors['black'],
//                  fontSize: 18,
//                  height: 1.5),
//              textAlign: TextAlign.left,
//            ),
//            Text(
//              ' Phone: ',
//              style: TextStyle(
//                  fontFamily: 'Roboto',
//                  color: themeColors['black'],
//                  fontSize: 18,
//                  height: 1.5),
//              textAlign: TextAlign.left,
//            ),
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
              ' Due Date: ${currentUser.dueDate}',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Planned Birth Location: ${currentUser.birthLocation}',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
            Text(
              //TODO add the rest of the information
              ' ADD THE REST OF THE INFO LATER!!!!',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['black'],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 1.5),
              textAlign: TextAlign.left,
            ),
//            Text(
//              ' Birth type: ',
//              style: TextStyle(
//                  fontFamily: 'Roboto',
//                  color: themeColors['black'],
//                  fontSize: 18,
//                  height: 1.5),
//              textAlign: TextAlign.left,
//            ),
//            Text(
//              ' Are you planning to have an epidural? : ',
//              style: TextStyle(
//                  fontFamily: 'Roboto',
//                  color: themeColors['black'],
//                  fontSize: 18,
//                  height: 1.5),
//              textAlign: TextAlign.left,
//            ),
//            Text(
//              ' Are you expecting to have a C-section? : ',
//              style: TextStyle(
//                  fontFamily: 'Roboto',
//                  color: themeColors['black'],
//                  fontSize: 18,
//                  height: 1.5),
//              textAlign: TextAlign.left,
//            ),
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
                    onPressed: () async {
                      // add application document
                      await Firestore.instance.collection("applications").add({
                        "user_type": currentUser.userType,
                        "name": currentUser.name,
                        "email": currentUser.email,
                        "phone": currentUser.phone,
                        "due_date": currentUser.dueDate,
                        "birth_location": currentUser.birthLocation
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClientAppRequestSentPage()),
                      );
                    },
                    color: themeColors['yellow'],
                    textColor: Colors.black,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['yellow'],
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

class ClientAppRequestSentPage extends StatefulWidget {
  //todo change remove user from constructor
  Client user;

  @override
  _ClientAppRequestSentPageState createState() =>
      _ClientAppRequestSentPageState();
}

class _ClientAppRequestSentPageState extends State<ClientAppRequestSentPage> {
  @override
  void initState() {
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