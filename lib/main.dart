
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';


import 'di/di_config.dart';
import 'presentation/myapp/my_app_screen.dart';

/// App start with here
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  try{
    await Firebase.initializeApp();
    await setupFlutterNotifications();
    showFlutterNotification(message);
  }
  catch(e){
    print("_firebaseMessagingBackgroundHandler error ${e.toString()}");
  }

}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> showFlutterNotification(RemoteMessage message) async {
  print("showFlutterNotification ${message.data}");
  if (message.data.isNotEmpty) {
    flutterLocalNotificationsPlugin.show(
     message.hashCode,
      message.data['bodyText']??"",
      message.data['organization']??"",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );

    try{
      FlutterTts flutterTts = FlutterTts();
      await flutterTts.speak( message.data['bodyText']??"");
    }
    catch(e){
      print("FlutterTts ${e.toString()}");
    }
  }

}

Future<void> ttsPlay() async {
  try{
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.speak("New notification");
  }
  catch(e){
    print("FlutterTts ${e.toString()}");
  }

}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// This will initialize firebase after that we can use firebase any where.
  await Firebase.initializeApp();
  await setupFlutterNotifications();

  configureDependencies(Env.development);
  initGlobal();
  runApp(const MyApp());
}

void initGlobal(){
  GetIt.instance.registerSingleton<GlobalKey<NavigatorState>>(GlobalKey<NavigatorState>());
}


