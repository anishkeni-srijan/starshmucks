import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starshmucks/login/bloc/login_events.dart';
import 'package:starshmucks/login/bloc/login_states.dart';
import '../../home_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc(): super(
      LoginInitialState()){
    //works on login text changed
     on<LogInTextChangedEvent>((event, emit) {

//user exists
      if (event.unamevalue == 'anish' && event.passwordvalue == 'pass') {
        emit(LoginValidState("all good"));

      }

      else {
// incorrect credentials
        if (event.unamevalue == '' || event.unamevalue != 'anish') {
          emit(LoginErrorState("Please enter a valid username"));
        }
        else if (event.passwordvalue == '' || event.passwordvalue != 'pass') {
          emit(LoginErrorState("Please enter a valid password"));
        }
      }

    });


    //works if login is valid
    on<LoginSumittedEvent>((event, emit) {
      if(state is LoginValidState ) {
        Get.to(HomePage());
      }});
  }
}


