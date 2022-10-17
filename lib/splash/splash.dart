
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
      body: getsplash(context),
    );
  }
}

getsplash(context) {
  return Center(
    child: Container(
      child: SplashScreenView(
        navigateRoute: LoginPage(),
        imageSrc: "images/shmucks.png",
        // paddingText
        // paddingLoading
      ),



    ),
  );
}