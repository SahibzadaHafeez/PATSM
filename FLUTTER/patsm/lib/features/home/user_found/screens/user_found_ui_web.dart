import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/home/user_found/user_found_bloc.dart';
import 'package:patsm/features/home/user_found/user_found_events.dart';
import 'package:patsm/widgets/my_app_bar.dart';

class UserFoundPageWeb extends StatefulWidget {
  const UserFoundPageWeb({Key? key}) : super(key: key);

  @override
  State<UserFoundPageWeb> createState() => _UserFoundPageWebState();
}

class _UserFoundPageWebState extends State<UserFoundPageWeb> {
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
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  IntrinsicHeight(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).padding.top + kToolbarHeight + 80),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          context.watch<UserFoundBloc>().state.loading?
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                          :
                          SizedBox(
                            height: 40,
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
