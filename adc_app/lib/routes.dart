import 'package:flutter/widgets.dart';

// import every class that has a screen definition
//import 'package:adc_app/screens/root_screen.dart';
import 'package:adc_app/screens/home_screen.dart';
import 'package:adc_app/screens/login_screen.dart';
//import 'package:adc_app/screens/applications/client_app.dart';
import 'package:adc_app/screens/applications/doula_app.dart';
import 'package:adc_app/screens/client_signup_screen.dart';
import 'package:adc_app/util/auth.dart';

final Map<String, WidgetBuilder> routesTable = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(),
  "/login": (BuildContext context) => LoginPage(),
  "/doulaApp": (BuildContext context) =>
      DoulaAppPage(title: 'Doula Application'),
  "/clientSignup": (BuildContext context) => ClientSignupPage(),
};
