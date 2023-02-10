import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/home/user_found/user_found_bloc.dart';
import 'package:patsm/features/home/user_found/user_found_events.dart';
import 'package:patsm/widgets/my_app_bar.dart';
import 'package:patsm/widgets/my_drawer.dart';

class UserFoundPageMob extends StatefulWidget {
  const UserFoundPageMob({Key? key}) : super(key: key);

  @override
  State<UserFoundPageMob> createState() => _UserFoundPageMobState();
}

class _UserFoundPageMobState extends State<UserFoundPageMob> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AppCubit>().homepage();
        return false;
      },
      child: Scaffold(
        appBar: MyAppBar(title: 'Home'),
        endDrawer: const MyDrawer(),
        body: ListView(
          children: [
            IntrinsicHeight(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.top + kToolbarHeight),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.17),
                      const CircleAvatar(
                        radius: 35,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'User Found',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            'The account you requested is found and is eligible for '
                                'an AI personality assessment. Would you like to get a prediction?',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Spacer(),
                      context.watch<UserFoundBloc>().state.loading?
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                          :
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<UserFoundBloc>().add(GetScore());
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xff5A429E),
                            ),
                          ),
                          child: const Text('Begin Assessment'),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
