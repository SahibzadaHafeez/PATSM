import 'package:flutter/material.dart';
import 'package:patsm/features/home/view_score/screens/view_score_ui_mob.dart';
import 'package:patsm/features/home/view_score/screens/view_score_ui_web.dart';
import 'package:responsive_builder/responsive_builder.dart';


class ViewScorePage extends StatefulWidget {
  ViewScorePage({super.key, required this.data, required this.max, required this.id,});
  List<String> data;
  double max;
  String id;

  @override
  State<ViewScorePage> createState() => _ViewScorePageState();
}

class _ViewScorePageState extends State<ViewScorePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ViewScorePageMob(data: widget.data, max: widget.max),
      tablet: ViewScorePageWeb(data: widget.data, max: widget.max, id: widget.id,),
      desktop: ViewScorePageWeb(data: widget.data, max: widget.max, id: widget.id,),
    );
  }
}
