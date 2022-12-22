import 'package:flutter/material.dart';

class EditdetailsState extends StatelessWidget {
  const EditdetailsState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class EditdetailsInitialState extends EditdetailsState {
  const EditdetailsInitialState({super.key});
  //check if the user exists
}

class EditdetailsValidState extends EditdetailsState {
  String validity = '';

  EditdetailsValidState(this.validity);
}

class EditdetailsErrorState extends EditdetailsState {
  String errormessage = '';

  EditdetailsErrorState(this.errormessage);
}

class EditdetailsLoadingState extends EditdetailsState {}
