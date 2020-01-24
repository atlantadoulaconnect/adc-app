import 'package:flutter/widgets.dart';

// import every class that has a screen definition
import 'package:adc_app/screens/home_screen.dart';
import 'package:adc_app/screens/login_screen.dart';
import 'package:adc_app/screens/applications/client_app.dart';
import 'package:adc_app/screens/applications/doula_app.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(),
  "/login": (BuildContext context) => LoginPage(),
  "/clientAppPersonalInfo": (BuildContext context) => ClientAppPersonalInfoPage(title: 'Request a Doula'),
  "/clientAppContact": (BuildContext context) => ClientAppContactPage(title: 'Request a Doula'),
  "/clientAppCurrentBirthInfo": (BuildContext context) => ClientAppCurrentBirthInfoPage(title: 'Request a Doula'),
  "/clientAppPreviousBirthInfo": (BuildContext context) => ClientAppPreviousBirthInfoPage(title: 'Request a Doula'),
  "/clientAppDoulaQuestions": (BuildContext context) => ClientAppDoulaQuestionsPage(title: 'Request a Doula'),
  "/clientAppPhotoRelease": (BuildContext context) => ClientAppPhotoReleasePage(title: 'Request a Doula'),
  "/clientAppConfirmation": (BuildContext context) => ClientAppConfirmationPage(title: 'Request a Doula'),
  "/clientAppRequestSent": (BuildContext context) => ClientAppRequestSentPage(title: 'Request a Doula'),
  "/doulaApp": (BuildContext context) => DoulaAppPage(title: 'Apply as a Doula')
};
