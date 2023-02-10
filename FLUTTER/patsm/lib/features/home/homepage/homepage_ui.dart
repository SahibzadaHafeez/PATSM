import 'package:flutter/material.dart';
import 'package:patsm/features/home/homepage/screens/homepage_ui_mob.dart';
import 'package:patsm/features/home/homepage/screens/homepage_ui_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const HomePageMob(),
      tablet: const HomePageWeb(),
      desktop: const HomePageWeb(),
    );
  }
}
