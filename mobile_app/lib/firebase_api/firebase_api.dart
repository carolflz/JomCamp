import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_app/main.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Channel',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotification () async{
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    print("Token: $fCMToken");

    initPushNotification();
    initLocalNotification();
  }

  Future initLocalNotification() async {
    const IOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(android: android, iOS: IOS);

    await _localNotifications.initialize(
      setting,
       onDidReceiveNotificationResponse: (payload){
        final message = RemoteMessage.fromMap(jsonDecode(payload as String));
        handleMessaging(message);
       }
      );

      final platform = _localNotifications.resolvePlatformSpecificImplementation
      <AndroidFlutterLocalNotificationsPlugin>();

      await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotification() async{
    
    await FirebaseMessaging.instance
    .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    
    FirebaseMessaging.instance.getInitialMessage().then(handleMessaging);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessaging);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message){

      final notification = message.notification;
      if(notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body ,
        NotificationDetails(android: AndroidNotificationDetails(
          _androidChannel.id, 
           _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@drawable/ic_launcher',
          ),
          ),
          payload: jsonEncode(message.toMap())
      );
    });
  }
}

void handleMessaging(RemoteMessage? message){
    if(message == null) return;

    navigatorKey.currentState?.pushNamed(
      'mobile_app/lib/screens/notification_screen.dart',
      arguments: message
    );
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async{
    print('title: ${message.notification?.title}');
    print('Body: ${message.notification?.title}');
    print('Payload: ${message.data}');
  }