
import 'package:flutter/material.dart';
import 'package:starshmucks/login/login.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';




class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: SplashScreenView(
            duration: Duration(milliseconds: 1500),
            navigateRoute: LoginPage(),
            imageSrc: "images/shmucks.png",
            // paddingText
            // paddingLoading
          ),
        ),
      ),
    );
  }
}

