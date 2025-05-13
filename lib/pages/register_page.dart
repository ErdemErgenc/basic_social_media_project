// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_procet/auth/user_model.dart';
import 'package:social_media_procet/auth/user_service.dart';

import 'package:social_media_procet/components/my_button.dart';
import 'package:social_media_procet/components/my_textfield.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserService userService = UserService();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  void registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final username = usernameController.text.trim();

    // Şifre uyuşmazlığı
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Hata"),
              content: Text("Şifreler uyuşmuyor."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Tamam"),
                ),
              ],
            ),
      );
      return;
    }

    // Yükleniyor göster
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Firebase Authentication ile kullanıcı oluştur
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Kullanıcı Firestore'a kaydediliyor
      await userService.createUser(
        UserModel(
          uid: userCredential.user!.uid,
          username: username,
          email: email,
        ),
      );

      if (!mounted) return;

      // CircularProgressIndicator'ı kapat
      Navigator.pop(context);

      // Başarılı mesajı göster
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Başarılı"),
              content: Text(
                "Kayıt başarılı! Giriş ekranına yönlendiriliyorsunuz.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Mesaj dialogunu kapat
                    widget.onTap?.call(); // Login sayfasına geç
                  },
                  child: Text("Tamam"),
                ),
              ],
            ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      // CircularProgressIndicator'ı kapat
      Navigator.pop(context);

      // Hata mesajı göster
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Hata"),
              content: Text(e.message ?? "Bir hata oluştu."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Tamam"),
                ),
              ],
            ),
      );
    } catch (e) {
      if (!mounted) return;

      // CircularProgressIndicator'ı kapat
      Navigator.pop(context);

      // Genel hata mesajı göster
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Hata"),
              content: Text("Bir hata oluştu: $e"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Tamam"),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Image.asset("lib/images/tardis.png", height: 80, width: 80),

                SizedBox(height: 20),

                //app name
                Text(
                  "T A R D I S",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                MyTextfield(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController,
                ),

                SizedBox(height: 10),

                //email textformfield
                MyTextfield(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),

                SizedBox(height: 10),

                //password textformfield
                MyTextfield(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),

                SizedBox(height: 10),

                MyTextfield(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPasswordController,
                ),

                //forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),

                //sign in button
                MyButton(
                  text: "Register",
                  onTap: () {
                    registerUser();
                  },
                ),

                SizedBox(height: 10),

                //dont have an account? sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: widget.onTap,
                      child: Text(
                        "Login here",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
