import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/common_things.dart';
import '/databse/user_db.dart';
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
          Get.to(() => BottomBar());
        } else {
          emit(SignupErrorState("Please fill out all the fields"));
        }
      },
    );
  }
}
