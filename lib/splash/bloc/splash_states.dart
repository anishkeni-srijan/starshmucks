import 'package:flutter/material.dart';

class SplashScreenState extends StatelessWidget {
  const SplashScreenState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SplashInitialState extends SplashScreenState {}

class SplashloadingState extends SplashScreenState {}

class NewUserState extends SplashScreenState {}

class UserExistsState extends SplashScreenState {}
