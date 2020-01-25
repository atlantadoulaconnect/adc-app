import 'package:flutter/widgets.dart';
import 'package:adc_app/util/auth.dart';

// import every class that has a screen definition
//import 'package:adc_app/screens/root_screen.dart';
import 'package:adc_app/screens/home_screen.dart';
import 'package:adc_app/screens/login_screen.dart';
//import 'package:adc_app/screens/applications/client_app.dart';
import 'package:adc_app/screens/applications/doula_app.dart';
import 'package:adc_app/screens/applications/client_app.dart';
import 'package:adc_app/screens/client_signup_screen.dart';
import 'package:adc_app/screens/doula_signup_screen.dart';
import 'package:adc_app/screens/client_home_screen.dart';
import 'package:adc_app/screens/applications/doula_app_page2.dart';
import 'package:adc_app/screens/applications/doula_app_page3.dart';
import 'package:adc_app/screens/applications/doula_app_page4.dart';
import 'package:adc_app/screens/applications/doula_app_page5.dart';
import 'package:adc_app/screens/applications/doula_app_completion_page.dart';



final Map<String, WidgetBuilder> routesTable = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(),
  "/login": (BuildContext context) => LoginPage(),
  "/doulaApp": (BuildContext context) => DoulaAppPage(),
  "/doulaAppPage2": (BuildContext context) => DoulaAppPage2(),
  "/doulaAppPage3": (BuildContext context) => DoulaAppPage3(),
  "/doulaAppPage4": (BuildContext context) => DoulaAppPage4(),
  "/doulaAppPage5": (BuildContext context) => DoulaAppPage5(),
  "/doulaAppCompletionPage": (BuildContext context) => DoulaAppCompletionPage(),
  "/clientApp": (BuildContext context) => ClientAppPage(),
  "/clientSignup": (BuildContext context) => ClientSignupPage(),
  "/doulaSignup": (BuildContext context) => DoulaSignupPage(),
  "/clientHome": (BuildContext context) => ClientHome(),
};
