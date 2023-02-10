import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/features/history/history_bloc.dart';
import 'package:patsm/features/history/history_events.dart';
import 'package:patsm/features/history/history_state.dart';
import 'package:patsm/features/score_chart.dart';
import 'package:patsm/widgets/my_app_bar.dart';
import 'package:patsm/widgets/my_drawer.dart';

class HistoryPageMob extends StatefulWidget {
  const HistoryPageMob({Key? key}) : super(key: key);

  @override
  State<HistoryPageMob> createState() => _HistoryPageMobState();
}

class _HistoryPageMobState extends State<HistoryPageMob> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(LoadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'History'),
      endDrawer: const MyDrawer(),
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
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 300,
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
                              children: [
                                const CircleAvatar(
                                  radius: 35,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FittedBox(
                                      child: Text(
                                        'Personality Assessment',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
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
                            SizedBox(
                              height: 150,
                              child: ScoreChart(
                                data: state.scores[index],
                                max: state.max[index],
                                mob: true,
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
