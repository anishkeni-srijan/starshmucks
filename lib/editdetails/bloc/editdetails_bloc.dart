import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'editdetails_events.dart';
import 'editdetails_states.dart';

class EditdetailsBloc extends Bloc<EditdetailsEvent, EditdetailsState> {
  EditdetailsBloc() : super(EditdetailsInitialState()) {
    //works on login text changed
    on<EditdetailsemailChangedEvent>((event, emit) {
//user exists
      if (event.emailvalue != '') {
        emit(EditdetailsValidState("all good"));
      } else if (event.emailvalue == '' || event.emailvalue.trim().length < 4) {
        emit(
          EditdetailsErrorState("Please enter a valid Email"),
        );
      } else {
        return Container();
      }
    });
    on<EditdetailsNameChangedEvent>((event, emit) {
//user exists
      if (event.namevalue == '' || event.namevalue.trim().length < 4) {
        emit(
          EditdetailsErrorState("Please enter a valid Name"),
        );
      } else {
        return Container();
      }
    });
    on<EditdetailsNumberChangedEvent>(
      (event, emit) {
        if (event.phnvalue == null || event.phnvalue.trim().isEmpty) {
          emit(
            EditdetailsErrorState("Please enter your phone number"),
          );
        } else if (event.phnvalue.trim().length < 4) {
          emit(
            EditdetailsErrorState(
                "Your phone number must be at least 4 digits"),
          );
        }
        // Return null if the entered username is valid
        else
          return Container();
      },
    );
    //works if login is valid
    // on<EditdetailsSumittedEvent>(
    //   (event, emit) {
    //     if (state is EditdetailsValidState) {
    //
    //     }
    //   },
    // );
  }
}
