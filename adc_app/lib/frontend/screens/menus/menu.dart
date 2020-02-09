import '../common.dart';
import 'package:async_redux/async_redux.dart';

import './newUserMenu.dart';
import './clientMenu.dart';
import './doulaMenu.dart';
import './adminMenu.dart';

// returns menu based on the current user's user type
// If no user is logged in then it will return the New User menu

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO get usertype of current user
    return NewUserMenu();
  }
}
