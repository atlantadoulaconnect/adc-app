import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/doula.dart';

import 'doula_app_page4.dart';

class DoulaAppPage3 extends StatefulWidget {
  Doula user;
  DoulaAppPage3({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor doula app: \n${user.toString()}");
  }

  @override
  _DoulaAppPage3 createState() => _DoulaAppPage3();
}

class _DoulaAppPage3 extends State<DoulaAppPage3> {
  Doula currentUser;
  Key key;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<bool> isSelected = [false, true];
  List<bool> isSelected2 = [true, false];
  bool certifiedDoula = false;
  bool workingToBecomeCertified = false;
  String certificationProgram;
  TextEditingController numOfBirths;
  String dropdownValue = "";

  @override
  void initState() {
    currentUser = widget.user;
    key = widget.key;
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
        key: _formKey,
        autovalidate: false,
          child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Questions',
                    textAlign: TextAlign.center,
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
                        value: 0.6,
                      ),
                    ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Are you a certified doula?',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ToggleButtons(
                      children: <Widget>[
                        Text(
                          "Yes",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "No",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                      borderRadius: new BorderRadius.circular(10.0),
                      constraints: BoxConstraints(
                        minWidth: 100,
                        minHeight: 40,
                      ),
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = !isSelected[buttonIndex];
                              certifiedDoula = isSelected[buttonIndex];
                            } else {
                              isSelected[buttonIndex] = false;
                              certifiedDoula = isSelected[buttonIndex];
                            }
                          }
                        });
                      },
                      isSelected: isSelected,
                    ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Are you working towards becoming a certified doula?',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ToggleButtons(
                      children: <Widget>[
                        Text(
                          "Yes",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "No",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                      borderRadius: new BorderRadius.circular(10.0),
                      constraints: BoxConstraints(
                        minWidth: 100,
                        minHeight: 40,
                      ),
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                          buttonIndex < isSelected2.length;
                          buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected2[buttonIndex] = !isSelected2[buttonIndex];
                              workingToBecomeCertified = isSelected2[buttonIndex];
                            } else {
                              isSelected2[buttonIndex] = false;
                              workingToBecomeCertified = isSelected2[buttonIndex];
                            }
                          }
                        });
                      },
                      isSelected: isSelected2,
                    ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Spacer(),
                          Text(
                            'Certification Program:',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 80,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              underline: Container(
                                height: 2,
                                color: themeColors['emoryBlue'],
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                  certificationProgram = dropdownValue;
                                });
                              },
                              items: <String>['', 'DONA', 'CAPPA', 'ICEA', 'Other']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                        ]),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child:  Container(
                      width: 205.0,
                      child: TextField(
                        autocorrect: false,
                        keyboardType: TextInputType.phone,
                        controller: numOfBirths,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),

                          labelText: 'Number of Births Needed',
                        ),
                      ),
                    ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
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

                            currentUser.certified = !certifiedDoula;
                            currentUser.certInProgress = !workingToBecomeCertified;
                            currentUser.certProgram = certificationProgram;
//                            int intNumOfBirths = int.parse(numOfBirths.toString().trim());
//                            currentUser.birthsNeeded = intNumOfBirths;

                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => DoulaAppPage4(
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
                ),

              ]),
        ),
      ),
    );
  }
}
