import 'package:patsm/features/auth/signup/signup_events.dart';

abstract class SignupEvent{}

class Signup extends SignupEvent{
  String email;
  String pass;

  Signup({
    required this.email,
    required this.pass,
});
}

class ClearError extends SignupEvent{}