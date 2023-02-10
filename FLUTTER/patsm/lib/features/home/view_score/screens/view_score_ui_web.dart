import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/score_chart.dart';
import 'package:patsm/widgets/my_app_bar.dart';

class ViewScorePageWeb extends StatefulWidget {
  ViewScorePageWeb({
    Key? key,
    required this.data,
    required this.max,
    required this.id,
  }) : super(key: key);

  List<String> data;
  double max;
  String id;

  @override
  State<ViewScorePageWeb> createState() => _ViewScorePageWebState();
}

class _ViewScorePageWebState extends State<ViewScorePageWeb> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AppCubit>().homepage();
        return false;
      },
      child: Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                children: [
                  IntrinsicHeight(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).padding.top +
                                kToolbarHeight +
                                80),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
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
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<AppCubit>().updateScore(
                                        id: widget.id,
                                        score: widget.data,
                                      );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.blueAccent,
                                  ),
                                ),
                                child: const Text('Submit Updated Score'),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: ScoreChart(
                              data: widget.data,
                              max: widget.max,
                              mob: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
