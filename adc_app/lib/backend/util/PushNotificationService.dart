import 'dart:async';
import 'package:adc_app/backend/actions/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../backend/models/pushNotificationMessage.dart';


class PushNotificationService {
  final Firestore _db = Firestore.instance;
  FirebaseMessaging _fcm = FirebaseMessaging();

  PushNotificationService(this._fcm);
  StreamSubscription iosSubscription;

  Future initialise() async {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data);
        _saveDeviceToken();
      });
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    // If you want to test the push notification locally,
    // you need to get the token and input to the Firebase console
    // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
    String token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");

    _fcm.configure(
      //when app is open and it receives push notification
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        if (Platform.isAndroid) {
          var notification = PushNotificationMessage(
            title: message['notification']['title'],
            body: message['notification']['body'],
          );
          showSimpleNotification(
            Container(child: Text(notification.body)),
            position: NotificationPosition.top,
          );
        }

        // show notification UI here
      },
      // when app is completely closed and opened directly from the push notification
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      // when app is in background and opened directly from the push notification
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    //adds device token to user document in firestore
    //Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();
  }

  _saveDeviceToken() async {
    // Get the current user

    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    print("uid: $uid");
    final dbRef = Firestore.instance;

    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();
    print("fcmToken: $fcmToken");

    // Save it to Firestore
    if (fcmToken != null) {
      await dbRef
          .collection('users')
          .document(uid).updateData({
            'token': fcmToken,
          });

      // await tokens.updateData({
      //   'token': fcmToken,
      // });
    }
  }
}
