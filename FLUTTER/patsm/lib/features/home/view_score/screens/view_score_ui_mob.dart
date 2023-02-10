import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/score_chart.dart';
import 'package:patsm/widgets/my_app_bar.dart';
import 'package:patsm/widgets/my_drawer.dart';

class ViewScorePageMob extends StatefulWidget {
  ViewScorePageMob({Key? key, required this.data, required this.max}) : super(key: key);

  List<String> data;
  double max;

  @override
  State<ViewScorePageMob> createState() => _ViewScorePageMobState();
}

class _ViewScorePageMobState extends State<ViewScorePageMob> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AppCubit>().homepage();
        return false;
      },
      child: Scaffold(
        appBar: MyAppBar(title: 'Personality Scores'),
        endDrawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              IntrinsicHeight(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).padding.top + kToolbarHeight + 40),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 35,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Personality Assessment',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.data[10],
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child:
                        ScoreChart(data: widget.data, max: widget.max, mob: true,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
