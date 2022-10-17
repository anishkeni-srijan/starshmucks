import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starshmucks/registration_screen.dart';
import 'package:starshmucks/login/login.dart';
import 'package:starshmucks/splash/bloc/splash_events.dart';
import 'package:starshmucks/splash/bloc/splash_states.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(
            //if new user
            SplashInitialState()) {
    on<OnSplashEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(SplashloadingState());
    });
  }

  //else if the user exists

}
