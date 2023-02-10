import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/features/home/update_score/update_score_bloc.dart';
import 'package:patsm/features/home/update_score/update_score_events.dart';

class UpdateScorePage extends StatefulWidget {
  const UpdateScorePage({Key? key}) : super(key: key);

  @override
  State<UpdateScorePage> createState() => _UpdateScorePageState();
}

class _UpdateScorePageState extends State<UpdateScorePage> {
  late final TextEditingController o;
  late final TextEditingController c;
  late final TextEditingController e;
  late final TextEditingController a;
  late final TextEditingController n;

  @override
  void initState() {
    super.initState();

    o = TextEditingController(text: context.read<UpdateScoreBloc>().score[7]);
    c = TextEditingController(text: context.read<UpdateScoreBloc>().score[9]);
    e = TextEditingController(text: context.read<UpdateScoreBloc>().score[6]);
    a = TextEditingController(text: context.read<UpdateScoreBloc>().score[8]);
    n = TextEditingController(text: context.read<UpdateScoreBloc>().score[5]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Score'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
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
                              60),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          'Enter Updated Score (between 0 and 120)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Openness',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: TextField(
                                controller: o,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                onChanged: (email) {},
                              ),
                            ),
                            const SizedBox(width: 30),
                            const Text(
                              'Current Score',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.watch<UpdateScoreBloc>().score[7],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Conscientiousness',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: TextField(
                                controller: c,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                onChanged: (email) {},
                              ),
                            ),
                            const SizedBox(width: 30),
                            const Text(
                              'Current Score',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.watch<UpdateScoreBloc>().score[9],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Extraversion',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: TextField(
                                controller: e,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                onChanged: (email) {},
                              ),
                            ),
                            const SizedBox(width: 30),
                            const Text(
                              'Current Score',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.watch<UpdateScoreBloc>().score[6],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Agreeableness',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: TextField(
                                controller: a,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                onChanged: (email) {},
                              ),
                            ),
                            const SizedBox(width: 30),
                            const Text(
                              'Current Score',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.watch<UpdateScoreBloc>().score[8],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Neuroticism',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: TextField(
                                controller: n,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                onChanged: (email) {},
                              ),
                            ),
                            const SizedBox(width: 30),
                            const Text(
                              'Current Score',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.watch<UpdateScoreBloc>().score[5],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 40),
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          height: 40,
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width * 0.2,
                            maxWidth: MediaQuery.of(context).size.width * 0.2,
                          ),
                          child: ElevatedButton(
                            autofocus: true,
                            onPressed: () {
                              if (int.parse(o.text.trim()) < 0 ||
                                  int.parse(o.text.trim()) > 120) {
                                return;
                              }
                              if (int.parse(c.text.trim()) < 0 ||
                                  int.parse(c.text.trim()) > 120) {
                                return;
                              }
                              if (int.parse(e.text.trim()) < 0 ||
                                  int.parse(e.text.trim()) > 120) {
                                return;
                              }
                              if (int.parse(a.text.trim()) < 0 ||
                                  int.parse(a.text.trim()) > 120) {
                                return;
                              }
                              if (int.parse(n.text.trim()) < 0 ||
                                  int.parse(n.text.trim()) > 120) {
                                return;
                              }

                              context.read<UpdateScoreBloc>().add(
                                    UpdateScore(
                                      updatedScore: [
                                        o.text.trim(),
                                        c.text.trim(),
                                        e.text.trim(),
                                        a.text.trim(),
                                        n.text.trim(),
                                      ],
                                    ),
                                  );
                              context
                                  .read<UpdateScoreBloc>()
                                  .appCubit
                                  .homepage();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xff5A429E),
                              ),
                            ),
                            child: const Text('Update'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
