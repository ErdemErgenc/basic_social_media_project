import 'package:flutter/material.dart';
import 'package:social_media_procet/pages/login_page.dart';
import 'package:social_media_procet/pages/register_page.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister ({super.key});

  @override
  State<LoginOrRegister> createState() => _AuthPageState();
}

class _AuthPageState extends State<LoginOrRegister> {
  bool showLogin = true;

  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
