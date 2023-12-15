import 'package:apptalk/firebase/auth_service.dart';
import 'package:apptalk/firebase/firebase_api.dart';
import 'package:apptalk/pages/MySplashPage.dart';
import 'package:apptalk/pages/login.dart';
import 'package:apptalk/pages/main_menu.dart';
import 'package:apptalk/pages/setting/account_center.dart';
import 'package:apptalk/pages/setting/notification.dart';
import 'package:apptalk/pages/setting/theme/Apparance.dart';
import 'package:apptalk/pages/setting/theme/theme.dart';
import 'package:apptalk/pages/setting/theme/theme_provider.dart';
import 'package:apptalk/pages/status/statuspage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(), // Make sure MyApp is a descendant of MultiProvider
    ),
  );
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(onTap: (){}),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

