import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/features/history/history_bloc.dart';
import 'package:patsm/features/history/history_events.dart';
import 'package:patsm/features/history/history_state.dart';
import 'package:patsm/features/score_chart.dart';
import 'package:patsm/widgets/my_app_bar.dart';

class HistoryPageWeb extends StatefulWidget {
  const HistoryPageWeb({Key? key}) : super(key: key);

  @override
  State<HistoryPageWeb> createState() => _HistoryPageWebState();
}

class _HistoryPageWebState extends State<HistoryPageWeb> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(LoadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: context.watch<HistoryBloc>().state.loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      child: Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(20),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          state.data[index].data()['username'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<HistoryBloc>()
                                        .appCubit
                                        .updateScore(
                                          id: context
                                              .read<HistoryBloc>()
                                              .state
                                              .data[index]
                                              .id,
                                          score: context
                                              .read<HistoryBloc>()
                                              .state
                                              .scores[index],
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
                              height: 200,
                              child: ScoreChart(
                                data: state.scores[index],
                                max: state.max[index],
                                mob: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
