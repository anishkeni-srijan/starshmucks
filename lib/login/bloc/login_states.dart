
import 'package:flutter/material.dart';



class LoginState extends StatelessWidget {
  const LoginState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class LoginInitialState extends LoginState{

  //check if the user exists
}

class LoginValidState extends LoginState{
  String  validity = '';
  LoginValidState(this.validity);
}


class LoginErrorState extends LoginState{
  String errormessage = '';
  LoginErrorState(this.errormessage);
}

class LoginLoadingState extends LoginState{}