import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import './backend/states/appState.dart';

import './frontend/theme/style.dart';

// general screens
import './frontend/screens/homeScreen.dart';
import './frontend/screens/loginScreen.dart';

// application screens
import './frontend/screens/application/client/clientSignupScreen.dart';

import './frontend/screens/application/doula/doulaSignupScreen.dart';
import './frontend/screens/application/doula/doulaAppPage1.dart';

// client screens
// doula screens
// admin screens

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final AppState initState = AppState();
  final Store<AppState> _store = Store<AppState>(initialState: initState);
  NavigateAction.setNavigatorKey(navigatorKey);
  runApp(new ADCApp(store: _store));
}

class ADCApp extends StatelessWidget {
  final Store<AppState> store;

  ADCApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: "Atlanta Doula Connect",
          theme: appTheme(),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute: "/",
          routes: {
            '/': (context) => HomeScreenConnector(),
            '/login': (context) => LoginScreen(),
            '/clientSignup': (context) => ClientSignupScreen(),
            '/doulaSignup': (context) => DoulaSignupScreen(),
            '/doulaAppPage1': (context) => DoulaAppPage1(),
          },
        ));
  }
}
