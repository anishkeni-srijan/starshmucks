import 'package:flutter/material.dart';

class SignupState extends StatelessWidget {
  const SignupState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SignupInitialState extends SignupState {
  //check if the user exists
}

class SignupValidState extends SignupState {
  String validity = '';
  SignupValidState(this.validity);
}

class SignupErrorState extends SignupState {
  String errormessage = '';
  SignupErrorState(this.errormessage);
}

class SignupLoadingState extends SignupState {}
