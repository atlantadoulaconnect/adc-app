import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';

class DoulaAppPage3 extends StatefulWidget {
  @override
  _DoulaAppPage3 createState() => _DoulaAppPage3();
}

class _DoulaAppPage3 extends State<DoulaAppPage3> {
  List<bool> isSelected = [false, true];
  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doula Application'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 2,),
              Text(
                'Questions',
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
              Spacer(flex: 2,),
              Text(
                'Are you a certified doula?',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              ToggleButtons(
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
                    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
              Spacer(),
              Text(
                'Are you working towards becoming a \ncertified doula?',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              ToggleButtons(
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
                    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
              Spacer(),
              Row(
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
                          });
                        },
                        items: <String>['','DONA', 'CAPPA', 'ICEA', 'Other']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Spacer(flex: 2,),
                  ]
              ),
              Spacer(),
              Container(
                width: 205.0,
                child: TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number of Births Needed',
                  ),
                ),
              ),
              Spacer(flex: 2,),
              Row (
                  children: <Widget>[
                    Spacer(flex: 2,),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: themeColors['mediumBlue'])
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/doulaAppPage2');
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
                    Spacer(flex: 2,),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: themeColors['yellow'])),
                      onPressed: () {
                        Navigator.pushNamed(context, '/doulaAppPage4');
                      },
                      color: themeColors['yellow'],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['yellow'],
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Spacer(flex: 2,),
                  ]
              ),
              Spacer(flex: 2,),
            ]
        ),
      ),
    );
  }
}
