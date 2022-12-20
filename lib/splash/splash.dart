import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '/common_things.dart';
import '../signin/signin.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool flag = false;

  @override
  void initState() {
    checkifloggedin();
    super.initState();
  }

  checkifloggedin() async {
    final prefs = await SharedPreferences.getInstance();
    String? useremail = prefs.getString('signedInEmail');
    setState(() {});
    if (useremail != null) flag = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#175244"),
        body: SplashScreenView(
          duration: const Duration(milliseconds: 1500),
          imageSrc: "images/shmucks.png",
          navigateRoute: flag ? const bottomBar() : const SigninPage(),
        ));
  }
}
