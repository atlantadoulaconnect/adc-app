import 'package:adc_app/backend/actions/common.dart';

import 'common.dart';

class NotificationHandler extends StatefulWidget {
  @override
  createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {

  final FirebaseMessaging fcm = FirebaseMessaging();
  
  _getToken() {
    fcm.getToken().then((deviceToken) {
      print("***DEVICE TOKEN***: $deviceToken");
    });
  }

  _saveDeviceToken() async {
    String fcmToken = await fcm.getToken();

    final dbRef = Firestore.instance;
//    if (fcmToken != null) {
//      await dbRef
//          .collection("users")
//          .document(user.userid)
//          .collection("tokens")
//          .document(fcmToken)
//          .setData({
//        "token": fcmToken,
//        "createdAt": FieldValue.serverTimestamp(),
//        "platform": Platform.operatingSystem
//
//      });
//    }
  }

  @override
  void initState() {
    super.initState();
    _getToken();
//    if (Platform.isIOS) {
//      iosSubscription = fcm._onIosSettingsRegistered.listen((data) {
//        _saveDeviceToken();
//      });
//      fcm.requestNotificationPermissions(IosNotificationPermissions());
//    } else {
//      _saveDeviceToken();
//    }
    fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: ListTile(
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );

//          final snackbar = SnackBar(
//            content: Text(message['notification']['title']),
//            action: SnackBarAction(
//              label: 'Go',
//              onPressed: () => null,
//            ),
//          );
//
//          Scaffold.of(context).showSnackBar(snackbar);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}