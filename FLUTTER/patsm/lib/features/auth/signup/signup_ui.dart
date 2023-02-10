import 'package:flutter/material.dart';
import 'package:patsm/features/auth/signup/screens/signup_ui_mob.dart';
import 'package:patsm/features/auth/signup/screens/signup_ui_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SignupPageMob(),
      tablet: const SignupPageWeb(),
      desktop: const SignupPageWeb(),
    );
  }
}
