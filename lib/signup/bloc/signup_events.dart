import 'package:flutter/material.dart';
abstract class SignupEvent {}

class SignupTextChangedEvent extends SignupEvent {
  String unamevalue = '';
  String passwordvalue = '';

  SignupTextChangedEvent(this.unamevalue, this.passwordvalue);
}

class SignupSumittedEvent extends SignupEvent {
  String? username;
  String? password;

  SignupSumittedEvent(
      this.username,
      this.password,
      );
}
