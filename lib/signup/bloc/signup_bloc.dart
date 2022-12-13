import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/common_things.dart';
import '/signup/bloc/signup_events.dart';
import '/signup/bloc/signup_states.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    //works on login text changed
    on<SignupNameChangedEvent>(
      (event, emit) {
//user exists

// incorrect credentials
        if (event.namevalue.isEmpty || event.namevalue.length < 2) {
          emit(
            SignupErrorState(""),
          );
        } else
          emit(
            SignupValidState(""),
          );
      },
    );

    on<SignupDobChangedEvent>(
      (event, emit) {
        if (event.dobvalue == null || event.dobvalue.trim().isEmpty) {
          emit(
            SignupErrorState("Please enter your Date of Birth"),
          );
        }
        // Return null if the entered username is valid
        else
          return emit(
            SignupValidState(''),
          );
      },
    );
    on<SignupEmailChangedEvent>(
      (event, emit) {
        final bool isEmailValid = EmailValidator.validate(event.emailvalue);
        if (isEmailValid) {
          emit(
            SignupValidState(''),
          );
        }
        // Return null if the entered username is valid
        else
          emit(
            // SignupErrorState("Please enter your email"),
            SignupErrorState(""),
          );
      },
    );
    on<SignupNumberChangedEvent>(
      (event, emit) {
        if (event.phnumbervalue == null || event.phnumbervalue.trim().isEmpty) {
          emit(
            SignupErrorState(""),
          );
        } else if (event.phnumbervalue.trim().length < 4) {
          emit(
            SignupErrorState(""),
          );
        }
        // Return null if the entered username is valid
        else
          emit(
            SignupValidState(''),
          );
      },
    );
    on<SignupPasswordChangedEvent>(
      (event, emit) {
        if (event.passwordvalue == null || event.passwordvalue.trim().isEmpty) {
          emit(
            SignupErrorState(""),
          );
        } else if (event.passwordvalue.trim().length < 4) {
          emit(
            SignupErrorState(""),
          );
        } else
          emit(
            SignupValidState(''),
          );
      },
    );
    on<SignupConfirmPasswordChangedEvent>(
      (event, emit) {
        if (event.confirmpassvalue == null ||
            event.confirmpassvalue.trim().isEmpty) {
          emit(
            SignupErrorState(""),
          );
        } else if (event.confirmpassvalue.trim().length < 4) {
          emit(
            SignupErrorState(""),
          );
        } else if (event.confirmpassvalue != event.passwordvalue) {
          emit(
            SignupErrorState(""),
          );
        }
        // Return null if the entered username is valid
        else
          emit(
            SignupValidState(''),
          );
      },
    );
    on<SignuptandcChangedEvent>(
      (event, emit) {
        if (event.checked == true) {
          emit(
            SignupErrorState("Please agree to the T&C."),
          );
        } else
          return emit(SignupNoerrorState(''));
      },
    );

    //works if login is valid
    on<SignupSumittedEvent>(
      (event, emit) {
        if (state is SignupNoerrorState) {
          Get.to(() => bottomBar());
        } else {
          emit(SignupErrorState("Please fill out all the fields"));
        }
      },
    );
  }
}
