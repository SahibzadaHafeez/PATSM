import 'package:flutter/material.dart';
import 'package:patsm/features/auth/login/screens/login_ui_mob.dart';
import 'package:patsm/features/auth/login/screens/login_ui_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const LoginPageMob(),
      tablet: const LoginPageWeb(),
      desktop: const LoginPageWeb(),
    );
  }
}
