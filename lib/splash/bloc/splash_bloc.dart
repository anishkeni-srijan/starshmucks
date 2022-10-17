
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starshmucks/login/login.dart';
import 'package:starshmucks/splash/bloc/splash_events.dart';
import 'package:starshmucks/splash/bloc/splash_states.dart';


class SplashScreenBloc extends Bloc<SplashScreenEvent,SplashScreenState>{
  SplashScreenBloc(): super(
      SplashloadingState()){

    on<LoginStatuscheckEvent>((event, emit) {

    });


    //works if login is valid
    on<NavigateToLoginScreenEvent>((event, emit) {
    });

  }
}

