import 'package:flutter/material.dart';

class SignupState extends StatelessWidget {
  const SignupState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SignupNoErrorState extends SignupState {
  SignupNoErrorState();
}

class SignupValidState extends SignupState {
  String message = '';

  SignupValidState(this.message);
}

class SignupErrorState extends SignupState {
  String errormessage = '';

  SignupErrorState(this.errormessage);
}
