abstract class LoginEvent{}

class LogInTextChangedEvent extends LoginEvent{
  String unamevalue = '';
  String passwordvalue = '';

  LogInTextChangedEvent(this.unamevalue,this.passwordvalue);

}

class LoginSumittedEvent extends LoginEvent{
  String? username;
  String? password;

  LoginSumittedEvent(this.username,this.password,);
}
