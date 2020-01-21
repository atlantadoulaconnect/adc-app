import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';

class DoulaAppPage extends StatefulWidget {
  DoulaAppPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DoulaAppPage> {

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
                value: 0.2,
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
                ),
              ),
            ),
            Spacer(flex: 7,),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
