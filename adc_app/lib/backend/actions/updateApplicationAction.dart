import 'package:async_redux/async_redux.dart';
import 'common.dart';

// initialize pages according to user type

// add application page

// remove application page

// cancel application
class CancelApplicationAction extends ReduxAction<AppState> {
  CancelApplicationAction();

  @override
  AppState reduce() {
    print("user cancelled application");
    User updated = User(state.currentUser.userid, state.currentUser.email);

    return state.copy(
        currentUser: updated, formState: ApplicationState.initialState());
  }
}
