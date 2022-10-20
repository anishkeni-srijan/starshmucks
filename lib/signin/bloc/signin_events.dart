abstract class SigninEvent {}

class SigninTextChangedEvent extends SigninEvent {
  String emailvalue = '';
  String obtainedemail = '';
  String passwordvalue = '';
  String obtainedpassword = '';

  SigninTextChangedEvent(this.emailvalue, this.passwordvalue,
      this.obtainedemail, this.obtainedpassword);
}

class SigninSumittedEvent extends SigninEvent {
  String? email;
  String? password;

  SigninSumittedEvent(
    this.email,
    this.password,
  );
}
