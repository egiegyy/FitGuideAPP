import 'package:fitguide/database/preferance.dart';
import 'package:fitguide/mainScreen.dart';
import 'package:fitguide/view/signIn.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    bool isLogin = await UserPref.isLogin();

    print("Login Status : $isLogin");

    if (!mounted) return;

    if (isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/logoFitGuide.png"),
      ),
    );
  }
}
