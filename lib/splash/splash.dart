import 'package:flutter/material.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:hexcolor/hexcolor.dart';

import '../signin/signin.dart';
import '/common_things.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool flag = false;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#175244"),
        body: Container(
          child: SplashScreenView(
            duration: Duration(milliseconds: 1500),
            imageSrc: "images/shmucks.png",
            navigateRoute: flag ? bottomBar() : SigninPage(),
          ),
        ));
  }
}
