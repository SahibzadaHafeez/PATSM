import 'package:flutter/material.dart';
import 'package:patsm/features/home/cannot_score/screens/cannot_score_ui_mob.dart';
import 'package:patsm/features/home/cannot_score/screens/cannot_score_ui_web.dart';
import 'package:responsive_builder/responsive_builder.dart';


class CannotScorePage extends StatefulWidget {
  const CannotScorePage({Key? key}) : super(key: key);

  @override
  State<CannotScorePage> createState() => _CannotScorePageState();
}

class _CannotScorePageState extends State<CannotScorePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const CannotScorePageMob(),
      tablet: const CannotScorePageWeb(),
      desktop: const CannotScorePageWeb(),
    );
  }
}
