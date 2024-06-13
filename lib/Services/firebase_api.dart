// import 'package:firebase_messaging/firebase_messaging.dart';

// class FireBaseAPI {
//   final _firebasemessaging = FirebaseMessaging.instance;
//   Future<void> backGroundMessage(RemoteMessage message) async {
//     print('notification title ===========${message.notification!.title}');
//     print('notification body ===========${message.notification!.body}');
//     print('notification paylod ===========${message.data}');
//   }

//   Future<void> initializeNotification() async {
//     await _firebasemessaging.requestPermission();
//     getFCMToken();
//     FirebaseMessaging.onBackgroundMessage(backGroundMessage);
//     FirebaseMessaging.onMessage.listen((event) {
//       backGroundMessage(event);
//     });
//   }

//   Future<String?> getFCMToken() async {
//     final fcmToken = await _firebasemessaging.getToken();
//     print('fcm_token=======================$fcmToken');
//     return fcmToken;
//   }
// }
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initialize() {
    // Request permission for iOS
    _firebaseMessaging.requestPermission();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.messageId}');
      if (message.notification != null) {
        print(
            'Notification: ${message.notification?.title}, ${message.notification?.body}');
      }
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle when the app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked!');
      if (message.notification != null) {
        print(
            'Notification: ${message.notification?.title}, ${message.notification?.body}');
      }
    });

    // Get the token
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });
  }

  Future getToken() async {
    final userToken = await _firebaseMessaging.getToken();
    log('userToken====>$userToken');
    return userToken;
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }
}
