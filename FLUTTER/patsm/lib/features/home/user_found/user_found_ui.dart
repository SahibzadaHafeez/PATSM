import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:patsm/features/home/user_found/screens/user_found_ui_mob.dart';
import 'package:patsm/features/home/user_found/screens/user_found_ui_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserFoundPage extends StatefulWidget {
  const UserFoundPage({Key? key}) : super(key: key);

  @override
  State<UserFoundPage> createState() => _UserFoundPageState();
}

class _UserFoundPageState extends State<UserFoundPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const UserFoundPageMob(),
      tablet: const UserFoundPageWeb(),
      desktop: const UserFoundPageWeb(),
    );
  }
}
