import 'package:flutter/material.dart';



class SigninState extends StatelessWidget {
  const SigninState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SigninInitialState extends SigninState {
  //check if the user exists
}

class SigninValidState extends SigninState {
  String validity = '';
  SigninValidState(this.validity);

}

class SigninErrorState extends SigninState {
  String errormessage = '';
  SigninErrorState(this.errormessage);
}

class SigninLoadingState extends SigninState {}
