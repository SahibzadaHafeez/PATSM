import 'package:flutter/material.dart';
import 'package:patsm/features/home/user_not_found/screens/user_not_found_ui_mob.dart';
import 'package:patsm/features/home/user_not_found/screens/user_not_found_ui_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserNotFoundPage extends StatefulWidget {
  const UserNotFoundPage({Key? key}) : super(key: key);

  @override
  State<UserNotFoundPage> createState() => _UserNotFoundPageState();
}

class _UserNotFoundPageState extends State<UserNotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const UserNotFoundPageMob(),
      tablet: const UserNotFoundPageWeb(),
      desktop: const UserNotFoundPageWeb(),
    );
  }
}
