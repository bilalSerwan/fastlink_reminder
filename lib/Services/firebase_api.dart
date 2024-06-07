import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseAPI{
  final _firebasemessaging = FirebaseMessaging.instance;

  Future<void> initializeNotification()async{

    Future<void> backGroundMessage(RemoteMessage message)async{
      print('notification title ===========${message.notification!.title}');
      print('notification body ===========${message.notification!.body}');
      print('notification paylod ===========${message.data}');
    }
    await _firebasemessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage((message) =>backGroundMessage(message) );
  }

  Future<String?> getFCMToken()async{
    final fcm_token= await _firebasemessaging.getToken();
    print('fcm_token=======================$fcm_token');
    return fcm_token;
  }

}
