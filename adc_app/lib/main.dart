import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import './backend/states/appState.dart';

import './frontend/theme/style.dart';

// general screens
import './frontend/screens/homeScreen.dart';
import './frontend/screens/loginScreen.dart';
import './frontend/screens/infoScreen.dart';

// application screens
import './frontend/screens/application/signupScreen.dart';
import './frontend/screens/application/appTypeScreen.dart';

import './frontend/screens/application/client/clientAppPage1.dart';

import './frontend/screens/application/doula/doulaAppPage1.dart';
import './frontend/screens/application/doula/doulaAppPage2.dart';
import './frontend/screens/application/doula/doulaAppPage3.dart';
import './frontend/screens/application/doula/doulaAppPage4.dart';
import './frontend/screens/application/doula/doulaAppPage5.dart';

// client screens
// doula screens
// admin screens

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  final AppState state = AppState.initialState();
  final Store<AppState> _store = Store<AppState>(initialState: state);
  print("main: state of appstate: ${state.toString()}");
  NavigateAction.setNavigatorKey(navigatorKey);
  runApp(new ADCApp(store: _store));
}

class ADCApp extends StatelessWidget {
  final Store<AppState> store;

  ADCApp({this.store});

  @override
  Widget build(BuildContext context) {
    print("ADCApp build: state of appstate: ${store.state.toString()}");
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
            '/signup': (context) => SignupScreenConnector(),
            '/appType': (context) => AppTypeScreenConnector(),
            '/info': (context) => InfoScreen(),
            '/appType': (context) => AppTypeScreenConnector(),
            '/clientAppPage1': (context) => ClientAppPage1(),
            '/doulaAppPage1': (context) => DoulaAppPage1Connector(),
//            '/doulaAppPage2': (context) => DoulaAppPage2Connector(),
//            '/doulaAppPage3': (context) => DoulaAppPage3Connector(),
//            '/doulaAppPage4': (context) => DoulaAppPage4Connector(),
//            '/doulaAppPage5': (context) => DoulaAppPage5Connector(),
          },
        ));
  }
}
