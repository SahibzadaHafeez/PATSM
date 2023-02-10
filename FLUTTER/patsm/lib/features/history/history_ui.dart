import 'package:flutter/material.dart';
import 'package:patsm/features/history/screens/history_ui_mob.dart';
import 'package:patsm/features/history/screens/history_ui_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const HistoryPageMob(),
      tablet: const HistoryPageWeb(),
      desktop: const HistoryPageWeb(),
    );
  }
}
