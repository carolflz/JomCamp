import 'dart:io';
import 'package:application/Screen/error_screen.dart';
import 'package:application/Screen/main_screen.dart';
import 'package:application/api/notification_controller.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyCIphtkBfmJAj352SUxmRaIqdLWe_6VmXo',
          appId: '1:297160251276:android:59163e288a3197aa5aa8a9',
          messagingSenderId: '297160251276',
          projectId: 'jomcamp-8453d',
        ))
      : await Firebase.initializeApp();
  await AwesomeNotifications().initialize('resource://drawable/res_app_icon', [
    NotificationChannel(
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Test Notification Channel")
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "basic_channel_group", channelGroupName: "Basic Group")
  ]);

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationController.appContext = context;

    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreateMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayMethod);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'JomCamp Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => MainScreen());

          case '/notification-page':
            return MaterialPageRoute(builder: (context) {
              return ErrorScreen();
            });

          default:
            assert(false, 'Page ${settings.name} not found');
            return null;
        }
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
