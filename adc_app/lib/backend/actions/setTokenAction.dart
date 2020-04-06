import 'common.dart';

import 'package:firebase_database/firebase_database.dart';

import '../actions/waitAction.dart';

class SetTokenAction extends ReduxAction<AppState> {
  final String userid;
  final String token;

  SetTokenAction(this.userid, this.token) : assert(userid != null, token != null);

  // appends message object to corresponding thread
  @override
  Future<AppState> reduce() async {}

}