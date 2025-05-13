import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_procet/components/my_button.dart';
import 'package:social_media_procet/components/my_textfield.dart';
import 'package:social_media_procet/pages/home_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void login() async {
    // CircularProgressIndicator göster
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Firebase ile giriş yap
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      // CircularProgressIndicator'ı kapat
      Navigator.pop(context);

      // Giriş başarılıysa HomePage'e yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
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
              title: Text("Giriş Hatası"),
              content: Text(e.message ?? "Bilinmeyen bir hata oluştu."),
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

  void registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;
      Navigator.pop(context); // Loading dialog kapat

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
      Navigator.pop(context); // Loading dialog kapat
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
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
                text: "Sign In",
                onTap: () {
                  login();
                },
              ),

              SizedBox(height: 10),

              //dont have an account? sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: widget.onTap,
                    child: Text(
                      "Sign Up",
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
    );
  }
}
