import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:starshmucks/db/user_db.dart';

import '../../model/user_model.dart';
import '/common_things.dart';
import '/signup/bloc/signup_events.dart';
import '/signup/bloc/signup_states.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupNoErrorState()) {
    UserDB udb = UserDB();
    udb.initDBUserData();
    //works if login is valid
    on<SignupSumittedEvent>(
      (event, emit) {
        if (state is SignupValidState) {
          udb.insertUserData(event.userdata);
          udb.getDataUserData();
          Get.to(() => bottomBar());
        } else {
          emit(SignupErrorState("Please fill out all the fields"));
        }
      },
    );
  }
}
