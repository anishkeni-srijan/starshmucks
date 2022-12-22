import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '/common_things.dart';
import '/splash/bloc/splash_bloc.dart';
import '/splash/bloc/splash_events.dart';
import '../signin/signin.dart';
import 'bloc/splash_states.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#175244"),
      body: SplashScreenView(
        duration: const Duration(milliseconds: 1500),
        imageSrc: "images/shmucks.png",
        navigateRoute: BlocBuilder<SplashScreenBloc, SplashScreenState>(
          builder: (context, state) {
            BlocProvider.of<SplashScreenBloc>(context).add(
              LoginStatusCheckEvent(),
            );
            if (state is UserExistsState) {
              return const BottomBar();
            } else {
              return const SigninPage();
            }
          },
        ),
      ),
    );
  }
}
