import 'package:get/get.dart';
import 'package:starshmucks/signup/bloc/signup_events.dart';
import '/home_screen.dart';
import '/Signup/bloc/signup_states.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    //works on login text changed
    on<SignupTextChangedEvent>((event, emit) {
//user exists
      if (event.unamevalue == 'anish' && event.passwordvalue == 'pass') {
        emit(SignupValidState("all good"));
      } else {
// incorrect credentials
        if (event.unamevalue == '' || event.unamevalue != 'anish') {
          emit(SignupErrorState("Please enter a valid username"));
        } else if (event.passwordvalue == '' || event.passwordvalue != 'pass') {
          emit(SignupErrorState("Please enter a valid password"));
        }
      }
    });

    //works if login is valid
    on<SignupSumittedEvent>((event, emit) {
      if (state is SignupValidState) {
        Get.to(HomePage());
      }
    });
  }
}
