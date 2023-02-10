import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/widgets/my_app_bar.dart';

class CannotScorePageWeb extends StatelessWidget {
  const CannotScorePageWeb({Key? key}) : super(key: key);

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
              width: MediaQuery.of(context).size.width * 0.4,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FittedBox(
                            child: Text(
                              'Cannot do personality assessment',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const FittedBox(
                            child: Text(
                              'Cannot apply personality assessment on this profile (not enough data)',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const FittedBox(
                            child: Text(
                              'Would you like to try again for another account',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            height: 40,
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
