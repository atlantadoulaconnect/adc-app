import 'package:flutter/widgets.dart';

import './frontend/screens/homeScreen.dart';
import './frontend/screens/signupScreen.dart';

// import every class that has a screen definition

final Map<String, WidgetBuilder> routesTable = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/signup": (BuildContext context) => SignupScreen(),
};
