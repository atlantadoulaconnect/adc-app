import 'package:flutter/material.dart';
import 'package:adc_app/routes.dart';
import 'package:adc_app/theme/style.dart';

void main() => runApp(ADCApp());

class ADCApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
