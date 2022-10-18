abstract class SigninEvent {}

class SigninTextChangedEvent extends SigninEvent {
  String unamevalue = '';
  String passwordvalue = '';

  SigninTextChangedEvent(this.unamevalue, this.passwordvalue);
}

class SigninSumittedEvent extends SigninEvent {
  String? username;
  String? password;

  SigninSumittedEvent(
    this.username,
    this.password,
  );
}
