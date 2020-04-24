import '../../backend/states/appState.dart';
import 'package:async_redux/async_redux.dart';

class LoadingAction extends ReduxAction<AppState> {
  final bool waiting;
  LoadingAction(this.waiting);

  @override
  AppState reduce() {
    return state.copy(waiting: waiting);
  }
}
