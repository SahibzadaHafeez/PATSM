import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/features/auth/login/login_bloc.dart';
import 'package:patsm/features/auth/login/login_events.dart';
import 'package:patsm/features/auth/login/login_state.dart';

class LoginPageMob extends StatefulWidget {
  const LoginPageMob({Key? key}) : super(key: key);

  @override
  State<LoginPageMob> createState() => _LoginPageMobState();
}

class _LoginPageMobState extends State<LoginPageMob> {

  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, state) {
        if(state.error != ''){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error),
              duration: const Duration(milliseconds: 700),),
          );
          context.read<LoginBloc>().add(ClearError());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
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
                        context.watch<LoginBloc>().state.loading?
                        const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            :
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<LoginBloc>().add(Login(email: email.text.trim(),
                                  pass: pass.text.trim()));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xff5A429E),
                              ),
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        context.watch<LoginBloc>().state.loading?
                        const SizedBox()
                            :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'New here? ',
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                context.read<LoginBloc>().appCubit.signup();
                              },
                              child: const Text(
                                'Signup',
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
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
    );
  }
}
