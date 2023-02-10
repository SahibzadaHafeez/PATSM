import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/features/auth/signup/signup_bloc.dart';
import 'package:patsm/features/auth/signup/signup_events.dart';
import 'package:patsm/features/auth/signup/signup_state.dart';

class SignupPageMob extends StatefulWidget {
  const SignupPageMob({Key? key}) : super(key: key);

  @override
  State<SignupPageMob> createState() => _SignupPageMobState();
}

class _SignupPageMobState extends State<SignupPageMob> {
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (BuildContext context, state) {
        if(state.error != ''){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error),
              duration: const Duration(milliseconds: 700),),
          );
          context.read<SignupBloc>().add(ClearError());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification? overscroll) {
              overscroll!.disallowIndicator();
              return true;
            },
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
                        SizedBox(height: MediaQuery.of(context).size.height*0.25),
                        const SizedBox(height: 20),
                        TextField(
                          controller: email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                          onChanged: (email) {},
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: pass,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                          ),
                          onChanged: (pass) {},
                        ),
                        const SizedBox(height: 40),
                        const Spacer(),
                        context.watch<SignupBloc>().state.loading?
                        const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            :
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<SignupBloc>().add(Signup(email: email.text.trim(),
                              pass: pass.text.trim()));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xff5A429E),
                              ),
                            ),
                            child: const Text('Signup'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        context.watch<SignupBloc>().state.loading?
                        const SizedBox()
                            :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                context.read<SignupBloc>().appCubit.login();
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
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
      ),
    );
  }
}
