import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/doula.dart';

class DoulaAppCompletionPage extends StatefulWidget {
  Doula user;
  DoulaAppCompletionPage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor doula app: \n${user.toString()}");
  }
  @override
  _DoulaAppCompletionPage createState() => _DoulaAppCompletionPage();
}

class _DoulaAppCompletionPage extends State<DoulaAppCompletionPage> {
  Doula currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool photoReleasePermission = false;

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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 3,
              ),
              Text(
                'All Done!',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: themeColors['emoryBlue'],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
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
                  Navigator.pushNamed(context, '/doulaHome');
                },
                color: themeColors['yellow'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['yellow'],
                child: Text(
                  "RETURN HOME",
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
      ),
    );
  }
}
