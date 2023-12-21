import 'package:apptalk/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class _MyAppState extends State<MyApp>{

  @override
  void initState(){
    super.initState();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Called when the app is in the foreground
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Called when the app is opened from a notification
      // Handle navigation or other app logic
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Handle background messages
  }

  Future<void> _showNotification(RemoteMessage message) async {
    var androidChannelSpecifics = const AndroidNotificationDetails(
      '200785318528',
      'GlaucoTalk',
      importance: Importance.max,
      priority: Priority.high,
    );

    var generalNotificationDetails =
    NotificationDetails(android: androidChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // ID
      message.notification?.title ?? 'Title',
      message.notification?.body ?? 'Body',
      generalNotificationDetails,
      payload: 'Notification Payload',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Your app UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCM Token Example'),
      ),
      body: const Center(
        child: Text( 'Retrieving FCM token...'),
      ),
    );
  }
}