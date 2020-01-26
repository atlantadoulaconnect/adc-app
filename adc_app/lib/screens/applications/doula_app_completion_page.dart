import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';


class DoulaAppCompletionPage extends StatefulWidget {
  @override
  _DoulaAppCompletionPage createState() => _DoulaAppCompletionPage();
}

class _DoulaAppCompletionPage extends State<DoulaAppCompletionPage> {
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
              Spacer(flex: 3,),
              Text(
                'All Done!!',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['emoryBlue'],
                  fontWeight: FontWeight.bold,

                  fontSize: 25,
                ),
              ),
              Spacer(flex: 2,),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    side: BorderSide(color: themeColors['yellow'])),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                color: themeColors['yellow'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['yellow'],
                child: Text(
                  "Return Home",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: themeColors['black'],
                  ),
                ),
              ),
              Spacer(flex: 2,),
            ]
        ),
      ),
    );
  }
}
