import 'package:flutter/material.dart';
import 'package:starshmucks/login/login.dart';
import 'package:starshmucks/splash/bloc/splash_events.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#175244"),
      body: Center(
        child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (context, state) {
          //checking if There's an error in Loginstate
          if (state is SplashInitialState) {
            return Container(
              child: null,
            );
          }
          //if the login is valid
          else if (state is SplashloadedState || state is SplashloadingState) {
            return Container(
              child: SplashScreenView(
                duration: Duration(milliseconds: 1500),
                imageSrc: "images/shmucks.png",
                navigateRoute: LoginPage(),
              ),
            );
          } else {
            return Container(
              child: null,
            );
          }
        }),
      ),
    );
  }
}
