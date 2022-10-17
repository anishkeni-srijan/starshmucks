import 'package:flutter/material.dart';
import 'package:starshmucks/registration_screen.dart';
import 'package:starshmucks/login/login.dart';
import 'package:starshmucks/splash/bloc/splash_states.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/splash_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#175244"),
      body: Center(child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
          builder: (context, state) {
        //checking if There's an error in Loginstate
        if (state is SplashInitialState || state is SplashloadingState) {
          return Container(
            child: SplashScreenView(
              duration: Duration(milliseconds: 1500),
              imageSrc: "images/shmucks.png",
              navigateRoute: LoginPage(),
            ),
          );
        } else {
          return Container(
            child: SplashScreenView(
              duration: Duration(milliseconds: 1500),
              imageSrc: "images/shmucks.png",
              navigateRoute: RegistrationPage(),
            ),
          );
        }
      })),
    );
  }
}
