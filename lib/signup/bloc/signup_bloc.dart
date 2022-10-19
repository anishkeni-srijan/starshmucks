import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/signup/bloc/signup_events.dart';
import '../../Signup/bloc/Signup_states.dart';
import '../../home_screen.dart';
import 'package:email_validator/email_validator.dart';
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    //works on login text changed
    on<SignupNameChangedEvent>((event, emit) {
//user exists
      if (event.namevalue == 'anish') {
        emit(
          SignupValidState("all good"),
        );
      } else {
// incorrect credentials
        if (event.namevalue == '' || event.namevalue != 'anish') {
          emit(
            SignupErrorState("Please enter a valid username"),
          );
        } else
          return SignupValidState('all good');
      }
    }

// incorrect credentials
        );

    on<SignupDobChangedEvent>((event, emit) {
      if (event.dobvalue == null || event.dobvalue.trim().isEmpty) {
        emit(SignupErrorState("Please enter your Date of Birth"));
      }
      // Return null if the entered username is valid
      else
        return SignupValidState('all good');
    });
    on<SignupEmailChangedEvent>((event, emit) {
      final bool isEmailValid = EmailValidator.validate(event.emailvalue);
      if (isEmailValid) {
        SignupValidState('all good');
      }
      // Return null if the entered username is valid
      else return  emit(SignupErrorState("Please enter your email"));

    });
    on<SignupNumberChangedEvent>((event, emit) {
      if (event.phnumbervalue == null || event.phnumbervalue.trim().isEmpty) {
        emit(SignupErrorState("Please enter your phone number"));
      } else if (event.phnumbervalue.trim().length < 4) {
        emit(SignupErrorState("Your phone number must be at least 4 digits"));
      }
      // Return null if the entered username is valid
      else
        return SignupValidState('all good');
    });
    on<SignupPasswordChangedEvent>((event, emit) {
      if (event.passwordvalue == null || event.passwordvalue.trim().isEmpty) {
        emit(SignupErrorState("Please enter a password"));
      } else if (event.passwordvalue.trim().length < 4) {
        emit(SignupErrorState("Your password must be at least 4 Characters"));
      }
      // Return null if the entered username is valid
      else
        return SignupValidState('all good');
    });
    on<SignupConfirmPasswordChangedEvent>((event, emit) {
      if (event.confirmpassvalue == null ||
          event.confirmpassvalue.trim().isEmpty) {
        emit(SignupErrorState("Please confirm your password"));
      } else if (event.confirmpassvalue.trim().length < 4) {
        emit(SignupErrorState(
            "Your confirm password must be at least 4 Characters"));
      } else if (event.confirmpassvalue != event.passwordvalue) {
        emit(SignupErrorState(
            "Your password and confirm password should match"));
      }
      // Return null if the entered username is valid
      else
        return SignupValidState('all good');
    });
    on<SignuptandcChangedEvent>((event, emit) {
      if (event.checked == true) {
        return SignupValidState('all goood');
      } else {
        emit(SignupErrorState("Please agree to the T&C."));
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
