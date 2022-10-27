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
    on<SigninemailChangedEvent>(
      (event, emit) {
//user exists
        if (event.emailvalue == event.obtainedemail) {

              emit(SigninValidState("all good"));

        } else if (event.emailvalue == '' ||
              event.emailvalue != event.obtainedemail) {
            emit(
              SigninErrorState("Please enter a valid Email"),
            );
          }
          else return Container();
        }
    );
    on<SigninpassChangedEvent>(
      (event, emit) {
//user exists
        if (event.passwordvalue == event.obtainedpassword) {
          Get.to(
            HomePage(),
          );

        } else if (event.passwordvalue == '' ||
              event.passwordvalue != event.obtainedpassword) {
            emit(
              SigninErrorState("Please enter a valid Password"),
            );
          }
          else return Container();
        }
    );

    //works if login is valid
    // on<SigninSumittedEvent>(
    //   (event, emit) {
    //     if (state is SigninValidState) {
    //
    //     }
    //   },
    // );
  }
}
