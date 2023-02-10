import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/widgets/my_app_bar.dart';
import 'package:patsm/widgets/my_drawer.dart';

class UserNotFoundPageMob extends StatelessWidget {
  const UserNotFoundPageMob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AppCubit>().homepage();
        return false;
      },
      child: Scaffold(
        appBar: MyAppBar(title: 'User Not Found'),
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
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35),
                      const FittedBox(
                        child: Text(
                          'User Not Found',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const FittedBox(
                        child: Text(
                          'The account you requested was not found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const FittedBox(
                        child: Text(
                          'Would you like to try again for another account',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff5A429E))),
                          onPressed: () {
                            context.read<AppCubit>().homepage();
                          },
                          child: const Text('Try Again'),
                        ),
                      ),
                      const SizedBox(height: 20),
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
