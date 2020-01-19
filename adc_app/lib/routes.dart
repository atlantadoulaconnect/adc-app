import 'package:flutter/widgets.dart';
// import every class that has a screen definition
import 'package:adc_app/screens/home_screen.dart';
import 'package:adc_app/screens/login_screen.dart';
import 'package:adc_app/screens/applications/doula_app.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(),
  "/login": (BuildContext context) => LoginPage(),
  "/doulaApp": (BuildContext context) => DoulaAppPage(title: 'Doula App Page')
};
