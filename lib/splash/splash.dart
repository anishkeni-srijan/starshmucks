import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starshmucks/splash/bloc/splash_bloc.dart';
import 'package:starshmucks/splash/bloc/splash_events.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/common_things.dart';
import '../signin/signin.dart';
import 'bloc/splash_states.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashScreenBloc>(context).add(
      LoginStatuscheckEvent(),
    );
    return Scaffold(
        backgroundColor: HexColor("#175244"),
        body: SplashScreenView(
          duration: const Duration(milliseconds: 1500),
          imageSrc: "images/shmucks.png",
          navigateRoute:  BlocBuilder<SplashScreenBloc,SplashScreenState>(
            builder: (context, state) {

              if (state is UserExistsState) {
                return BottomBar();
              } else {
                return  SigninPage();
              }
            },
          ),
        ));
  }
}
