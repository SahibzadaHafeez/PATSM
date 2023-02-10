abstract class LoginEvent{}

class Login extends LoginEvent{
  String email;
  String pass;

  Login({
    required this.email,
    required this.pass,
  });
}

class ClearError extends LoginEvent{}