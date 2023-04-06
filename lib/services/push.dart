import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationServices {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String token;
  static final StreamController<String> _messageController = StreamController.broadcast();

  static Stream<String> get messageStream => _messageController.stream;

  static Future _handler(RemoteMessage message) async{
    //print('handler ${message.messageId}');
    _messageController.sink.add(message.notification?.title ?? 'Not title');
  }

  static Future _onHandler(RemoteMessage message) async{
    //print('onHandler ${message.messageId}');
    _messageController.sink.add(message.notification?.title ?? 'Not title');
  }

  static Future _onOpenApp(RemoteMessage message) async{
    //print('onOpenApp ${message.messageId}');
    _messageController.sink.add(message.notification?.title ?? 'Not title');
  }

  static Future initializeApp() async{
    //Push notification
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('El token: $token');

    //Handler's
    FirebaseMessaging.onBackgroundMessage(_handler);
    FirebaseMessaging.onMessage.listen(_onHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenApp);

    //Local notification
  }
}