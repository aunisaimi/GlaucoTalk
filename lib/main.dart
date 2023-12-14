import 'package:apptalk/firebase/auth_service.dart';
import 'package:apptalk/firebase/firebase_api.dart';
import 'package:apptalk/pages/MySplashPage.dart';
import 'package:apptalk/pages/main_menu.dart';
import 'package:apptalk/pages/setting/notification.dart';
import 'package:apptalk/pages/status/statuspage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(
      ChangeNotifierProvider(
          create: (context) => AuthService(),
      child: const MyApp(),
      )
  );

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  // final CameraDescription camera;

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySplashPage(),
    );
  }
}

