import 'package:flutter/material.dart';
abstract class SignupEvent {}

class SignupNameChangedEvent extends SignupEvent {
  String namevalue = '';


  SignupNameChangedEvent(this.namevalue);
}
//dob
class SignupDobChangedEvent extends SignupEvent {
  String dobvalue = '';


  SignupDobChangedEvent(this.dobvalue);
}
//email
class SignupEmailChangedEvent extends SignupEvent {
  String emailvalue = '';


  SignupEmailChangedEvent(this.emailvalue);
}
//number
class SignupNumberChangedEvent extends SignupEvent {
  String phnumbervalue = '';


  SignupNumberChangedEvent(this.phnumbervalue);
}
//password
class SignupPasswordChangedEvent extends SignupEvent {
  String passwordvalue = '';


  SignupPasswordChangedEvent(this.passwordvalue,);
}
//confirm pass
class SignupConfirmPasswordChangedEvent extends SignupEvent {
  String confirmpassvalue = '';
  String passwordvalue = '';

  SignupConfirmPasswordChangedEvent(this.passwordvalue,this.confirmpassvalue);
}
class SignuptandcChangedEvent extends SignupEvent {
  bool checked;

  SignuptandcChangedEvent(this.checked);
}

class SignupSumittedEvent extends SignupEvent {
  String? username;
  String? password;
  String? dob;
  String? email;
  String? phno;
  String? pswd;
  String? cpaswd;
  bool? checked;



  SignupSumittedEvent(
      this.username,
      this.password,
      this.dob,
      this.email,
      this.phno,
      this.pswd,
      this.cpaswd,
      this.checked,
      );
}
