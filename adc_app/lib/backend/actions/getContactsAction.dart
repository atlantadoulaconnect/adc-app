import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/admin.dart';
import '../models/client.dart';
import '../models/doula.dart';
import '../states/appState.dart';
import '../actions/waitAction.dart';

class GetContactsAction extends ReduxAction<AppState> {
  // userid of the current user, don't add current user to list of contacts
  final String userid;
  GetContactsAction(this.userid) : assert(userid != null);

  @override
  AppState reduce() {}
}
