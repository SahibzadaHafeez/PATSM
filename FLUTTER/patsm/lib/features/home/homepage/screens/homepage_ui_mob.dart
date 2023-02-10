import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/features/home/homepage/homepage_bloc.dart';
import 'package:patsm/features/home/homepage/homepage_events.dart';
import 'package:patsm/widgets/my_app_bar.dart';
import 'package:patsm/widgets/my_drawer.dart';

class HomePageMob extends StatefulWidget {
  const HomePageMob({Key? key}) : super(key: key);

  @override
  State<HomePageMob> createState() => _HomePageMobState();
}

class _HomePageMobState extends State<HomePageMob> {
  final username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Home'),
      endDrawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            IntrinsicHeight(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.top + kToolbarHeight),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Image.asset(
                          'images/img.png',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          const Text(
                            'Enter Twitter Username',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: username,
                            decoration: const InputDecoration(
                              hintText: 'username',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (user) {},
                          ),
                          const SizedBox(height: 40),
                          const Spacer(),
                          context.watch<HomePageBloc>().state.loading
                              ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              :
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
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
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
