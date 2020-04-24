import 'package:async_redux/async_redux.dart';
import 'common.dart';

// initialize pages according to user type
class ClientInitFormAction extends ReduxAction<AppState> {
  ClientInitFormAction();

  @override
  AppState reduce() {
    Map<String, bool> form = {
      "clientAppPage1": false,
      "clientAppPage2": false,
      "clientAppPage3": false,
      "clientAppPage4": false,
      "clientAppPage5": false,
      "clientAppPage6": false,
    };
    return state.copy(pages: form);
  }
}

class DoulaInitFormAction extends ReduxAction<AppState> {
  DoulaInitFormAction();

  @override
  AppState reduce() {
    Map<String, bool> form = {
      "doulaAppPage1": false,
      "doulaAppPage2": false,
      "doulaAppPage3": false,
      "doulaAppPage4": false,
      "doulaAppPage5": false,
    };
    return state.copy(pages: form);
  }
}

// add application page
class CompletePageAction extends ReduxAction<AppState> {
  final String pageName;

  CompletePageAction(this.pageName) : assert(pageName != null);

  @override
  AppState reduce() {
//    Map<String, bool> form = state.pages ?? Map<String, bool>(); // sanity check
//    form[pageName] = true;
//    return state.copy(pages: form);
    return null;
  }
}

// remove application page

// cancel application
class CancelApplicationAction extends ReduxAction<AppState> {
  CancelApplicationAction();

  @override
  AppState reduce() {
    print("user cancelled application");
    User updated = User(state.currentUser.userid, state.currentUser.email);
    updated.status = "incomplete";

    return state.copy(currentUser: updated, pages: null);
  }
}
