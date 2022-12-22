// ignore_for_file: void_checks

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/common_things.dart';
import '/signin/bloc/signin_events.dart';
import '/signin/bloc/signin_states.dart';
import '/signup/signup.dart';
import '../../databse/user_db.dart';

late String obtainedemail;
late String obtainedpassword;
List<Map<String, dynamic>> userddt = [];
UserDB udb = UserDB();

getUser() async {
  udb.initDBUserData();
  userddt = await udb.getDataUserData();
}

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitialState()) {
    //works on login text changed
    on<SigninemailChangedEvent>((event, emit) {
//user exists
      getUser();
      if (userddt.isEmpty) {
        obtainedemail = '';
        obtainedpassword = '';
      } else {
        obtainedemail = userddt[0]['email'];
        obtainedpassword = userddt[0]['password'];
      }

      if (event.emailvalue == obtainedemail) {
        emit(SigninValidState("all good"));
      } else if (event.emailvalue == '' || event.emailvalue != obtainedemail) {
        emit(
          SigninErrorState("Please enter a valid Email"),
        );
      } else {
        return Container();
      }
    });
    on<SigninpassChangedEvent>((event, emit) {
//user exists
      if (event.passwordvalue == obtainedpassword) {
        Get.to(() => const BottomBar());
      } else if (event.passwordvalue == '' ||
          event.passwordvalue != obtainedpassword) {
        emit(
          SigninErrorState("Please enter a valid Password"),
        );
      } else {
        return Container();
      }
    });

    //works if login is valid
    on<SignupRedirect>(
      (event, emit) {
        Get.to(const SignupPage());
      },
    );
  }
}
