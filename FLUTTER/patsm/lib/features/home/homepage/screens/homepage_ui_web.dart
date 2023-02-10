import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/features/home/homepage/homepage_bloc.dart';
import 'package:patsm/features/home/homepage/homepage_events.dart';
import 'package:patsm/widgets/my_app_bar.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  final username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.white.withOpacity(0.09),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Image.asset(
                    'images/img.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: const Color(0xff9384BD),
                  child: ListView(
                    children: [
                      IntrinsicHeight(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).padding.top +
                                    kToolbarHeight),
                          ),
                          child: context.watch<HomePageBloc>().state.loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const FittedBox(
                                      child: Text(
                                        'Enter Twitter Username',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: TextField(
                                        controller: username,
                                        decoration: const InputDecoration(
                                          hintText: 'username',
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xff5A429E)),
                                      ),
                                      onPressed: () {
                                        context.read<HomePageBloc>().add(
                                              GetUser(
                                                username: username.text.trim(),
                                              ),
                                            );
                                        username.clear();
                                      },
                                      child: const Text('Find User'),
                                    ),
                                  ],
                                ),
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
    );
  }
}
