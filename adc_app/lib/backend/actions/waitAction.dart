import '../../backend/states/appState.dart';
import 'package:async_redux/async_redux.dart';

class WaitAction extends ReduxAction<AppState> {
  final bool waiting;
  WaitAction(this.waiting);

  @override
  AppState reduce() {
    return state.copy(waiting: waiting);
  }
}
