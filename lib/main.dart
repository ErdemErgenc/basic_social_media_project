import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_procet/auth/auth.dart';
import 'package:social_media_procet/auth/login_or_register.dart';
import 'package:social_media_procet/firebase_options.dart';
import 'package:social_media_procet/pages/home_page.dart';
import 'package:social_media_procet/pages/profile_page.dart';
import 'package:social_media_procet/pages/users_page.dart';
import 'package:social_media_procet/theme/dark_mode.dart';
import 'package:social_media_procet/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(), theme: lightMode, darkTheme: darkMode,

      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) =>  HomePage(),
        '/users_page': (context) => const UsersPage(),
        '/profile_page': (context) =>  ProfilePage(),
      },
      );
  }
}
