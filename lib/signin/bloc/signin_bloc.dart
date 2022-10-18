import 'package:get/get.dart';
import '/home_screen.dart';

import '/signin/bloc/signin_events.dart';
import '/signin/bloc/signin_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitialState()) {
    //works on login text changed
    on<SigninTextChangedEvent>((event, emit) {
//user exists
      if (event.unamevalue == 'anish' && event.passwordvalue == 'pass') {
        emit(SigninValidState("all good"));
      } else {
// incorrect credentials
        if (event.unamevalue == '' || event.unamevalue != 'anish') {
          emit(SigninErrorState("Please enter a valid username"));
        } else if (event.passwordvalue == '' || event.passwordvalue != 'pass') {
          emit(SigninErrorState("Please enter a valid password"));
        }
      }
    });

    //works if login is valid
    on<SigninSumittedEvent>((event, emit) {
      if (state is SigninValidState) {
        Get.to(HomePage());
      }
    });
  }
}
