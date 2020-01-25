import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';


class DoulaAppPage5 extends StatefulWidget {
  @override
  _DoulaAppPage5 createState() => _DoulaAppPage5();
}

class _DoulaAppPage5 extends State<DoulaAppPage5> {
  bool photoReleasePermission = false;

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
                  value: 1.0,
                ),
              ),
              Spacer(flex: 2,),
              Container(
                width: 330,
                child: Text(
                  'I grant the Urban Health Initiative of Emory Photo/Video permission to use any photographs in Emory’s own publications or in any other broadcast, print,  or  electronic  media,  including—without  limitation—newspaper, radio,  television,  magazine,  internet.  I  waive  any  right  to  inspect  or  approve  my  depictions  in  these  works.    ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                  ),
                ),
              ),
              Spacer(flex: 2,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: photoReleasePermission,
                      onChanged: (bool value) {
                        setState(() {
                          photoReleasePermission = value;
                        });
                      },
                    ),
                    Text(
                      "I agree to the statement above",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                      ),
                    ),
                  ]
              ),
              Spacer(flex: 3,),
              Row (
                  children: <Widget>[
                    Spacer(flex: 2,),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: themeColors['mediumBlue'])
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/doulaAppPage4');
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
                        Navigator.pushNamed(context, '/doulaAppCompletionPage');
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
