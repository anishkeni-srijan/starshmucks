import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../boxes.dart';
import '../../model/user_model.dart';
import '/home_screen.dart';
import '/signin/bloc/signin_events.dart';
import '/signin/bloc/signin_states.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitialState()) {
    //works on login text changed
    on<SigninTextChangedEvent>(
      (event, emit) {
//user exists
        if (event.emailvalue == event.obtainedemail &&
            event.passwordvalue == event.obtainedpassword) {

              emit(SigninValidState("all good"));

        } else {
// incorrect credentials
          if (event.emailvalue == '' ||
              event.emailvalue != event.obtainedemail) {

            emit(
              SigninErrorState("Please enter a valid Email"),
            );
          } else if (event.passwordvalue == '' ||
              event.passwordvalue != event.passwordvalue) {
            emit(
              SigninErrorState("Please enter a valid password"),
            );
          }
        }
      },
    );

    //works if login is valid
    on<SigninSumittedEvent>(
      (event, emit) {
        if (state is SigninValidState) {
          Get.to(
            HomePage(),
          );
        }
      },
    );
  }
}
