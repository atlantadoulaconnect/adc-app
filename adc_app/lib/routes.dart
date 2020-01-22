import 'package:flutter/widgets.dart';

// import every class that has a screen definition
import 'package:adc_app/screens/home_screen.dart';
import 'package:adc_app/screens/login_screen.dart';
//import 'package:adc_app/screens/applications/client_app.dart';
import 'package:adc_app/screens/applications/doula_app.dart';
import 'package:adc_app/screens/client_signup_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(),
  "/login": (BuildContext context) => LoginPage(),
<<<<<<< HEAD
  "/doulaApp": (BuildContext context) =>
      DoulaAppPage(title: 'Doula Application'),
  "/clientSignup": (BuildContext context) => ClientSignupPage(),
=======
  "/doulaApp": (BuildContext context) => DoulaAppPage(title: 'Apply as a Doula')
>>>>>>> 3dc0268a92c1dd5fcbc71cded33a78ac349032c4
};
