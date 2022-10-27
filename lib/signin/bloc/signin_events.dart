abstract class SigninEvent {}

class SigninpassChangedEvent extends SigninEvent {
  String passwordvalue = '';
  String obtainedpassword = '';

  SigninpassChangedEvent(this.passwordvalue, this.obtainedpassword);
}
class SigninemailChangedEvent extends SigninEvent {
  String emailvalue = '';
  String obtainedemail = '';

  SigninemailChangedEvent(this.emailvalue,
      this.obtainedemail);
}

class SigninSumittedEvent extends SigninEvent {
  String? email;
  String? password;

  SigninSumittedEvent(
    this.email,
    this.password,
  );
}
