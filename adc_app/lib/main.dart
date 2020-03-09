import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import './backend/states/appState.dart';
import './backend/states/errorsState.dart';
import 'backend/util/persistence.dart';

import './frontend/theme/style.dart';

// general screens
import './frontend/screens/homeScreen.dart';
import './frontend/screens/loginScreen.dart';
import './frontend/screens/infoScreen.dart';

// application screens
import './frontend/screens/application/signupScreen.dart';
import './frontend/screens/application/appTypeScreen.dart';
import './frontend/screens/application/requestSentScreen.dart';

import './frontend/screens/application/client/clientAppPage1.dart';
import './frontend/screens/application/client/clientAppPage2.dart';
import './frontend/screens/application/client/clientAppPage3.dart';
import './frontend/screens/application/client/clientAppPage4.dart';
import './frontend/screens/application/client/clientAppPage5.dart';
import './frontend/screens/application/client/clientAppPage6.dart';
import './frontend/screens/application/client/clientAppConfirmationPage.dart';

import './frontend/screens/application/doula/doulaAppPage1.dart';
import './frontend/screens/application/doula/doulaAppPage2.dart';
import './frontend/screens/application/doula/doulaAppPage3.dart';
import './frontend/screens/application/doula/doulaAppPage4.dart';
import './frontend/screens/application/doula/doulaAppPage5.dart';
import './frontend/screens/application/doula/doulaAppConfirmationPage.dart';

// client screens
import './frontend/screens/client/clientHomeScreen.dart';
import './frontend/screens/client/clientProfileScreen.dart';

// doula screens
import './frontend/screens/doula/doulaHomeScreen.dart';
import './frontend/screens/doula/doulaProfileScreen.dart';

// admin screens
import './frontend/screens/admin/adminHomeScreen.dart';
import './frontend/screens/admin/registeredDoulasScreen.dart';
import './frontend/screens/admin/registeredClientsScreen.dart';
import './frontend/screens/admin/approveClientScreen.dart';
import './frontend/screens/admin/approveDoulaScreen.dart';

// messaging screens
import './frontend/screens/messaging/contactsScreen.dart';
import './frontend/screens/messaging/messagesScreen.dart';
import './frontend/screens/messaging/recentMessagesScreen.dart';
import './frontend/screens/messaging/textBankScreen.dart';
import 'frontend/screens/admin/pendingApplications.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Persistence persistor = Persistence(
      throttle: Duration(seconds: 2),
      saveDuration: Duration(milliseconds: 400));
  final AppState state = await persistor.readInitialState();
  await persistor.saveInitialState(state);

  final Store<AppState> _store =
      Store<AppState>(initialState: state, persistor: persistor);
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
            '/': (context) =>
                HomeScreenConnector(), // replace with splash screen, home -> /defaultHome
            '/login': (context) => LoginScreenConnector(),
            '/signup': (context) => SignupScreenConnector(),
            '/appType': (context) => AppTypeScreenConnector(),
            '/info': (context) => InfoScreenConnector(),
            '/appType': (context) => AppTypeScreenConnector(),
            '/clientAppPage1': (context) => ClientAppPage1Connector(),
            '/clientAppPage2': (context) => ClientAppPage2Connector(),
            '/clientAppPage3': (context) => ClientAppPage3Connector(),
            '/clientAppPage4': (context) => ClientAppPage4Connector(),
            '/clientAppPage5': (context) => ClientAppPage5Connector(),
            '/clientAppPage6': (context) => ClientAppPage6Connector(),
            '/clientAppConfirmation': (context) =>
                ClientAppConfirmationPageConnector(),
            '/doulaAppPage1': (context) => DoulaAppPage1Connector(),
            '/doulaAppPage2': (context) => DoulaAppPage2Connector(),
            '/doulaAppPage3': (context) => DoulaAppPage3Connector(),
            '/doulaAppPage4': (context) => DoulaAppPage4Connector(),
            '/doulaAppPage5': (context) => DoulaAppPage5Connector(),
            '/doulaAppConfirmation': (context) =>
                DoulaAppConfirmationPageConnector(),
            '/requestSent': (context) => RequestSentScreenConnector(),
            '/clientHome': (context) => ClientHomeScreenConnector(),
            '/doulaHome': (context) => DoulaHomeScreenConnector(),
            '/adminHome': (context) => AdminHomeScreenConnector(),
            '/contacts': (context) => ContactsScreenConnector(),
            '/messages': (context) => MessagesScreenConnector(),
            '/recentMessages': (context) => RecentMessagesScreenConnector(),
            '/textBank': (context) => TextBankScreen(),
            '/registeredDoulas': (context) => RegisteredDoulasScreenConnector(),
            '/registeredClients': (context) =>
                RegisteredClientsScreenConnector(),
            '/approveClient': (context) => ApproveClientScreen(),
            '/approveDoula': (context) => ApproveDoulaScreen(),
            '/pendingApps': (context) => PendingApplicationsConnector()
          },
        ));
  }
}
