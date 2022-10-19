abstract class SigninEvent {}

class SigninTextChangedEvent extends SigninEvent {
  String unamevalue = '';
  String obtainedname = '';
  String passwordvalue = '';
  String obtainedpassword='';

  SigninTextChangedEvent(this.unamevalue, this.passwordvalue,this.obtainedname,this.obtainedpassword);
}

class SigninSumittedEvent extends SigninEvent {
  String? username;
  String? password;

  SigninSumittedEvent(
    this.username,
    this.password,
  );
}
