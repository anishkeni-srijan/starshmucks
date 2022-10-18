import 'package:get/get.dart';
import 'package:starshmucks/signup/bloc/signup_events.dart';

import '../../Signup/bloc/Signup_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_screen.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    //works on login text changed
    on<SignupNameChangedEvent>((event, emit) {
//user exists
      if (event.namevalue == null || event.namevalue.trim().isEmpty) {
        emit(SignupErrorState("Please enter your name correctly"));
      }
        else if (event.namevalue.trim().length < 4) {
          emit(SignupErrorState("Your name must be at least 4 Characters"));
      }
      // Return null if the entered username is valid
      else return null;
    },

// incorrect credentials

    );

    //works if login is valid
    on<SignupSumittedEvent>((event, emit) {
      if (state is SignupValidState) {
        Get.to(HomePage());
      }
    });
  }
}

