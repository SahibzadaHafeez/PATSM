import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/features/auth/signup/signup_bloc.dart';
import 'package:patsm/features/auth/signup/signup_events.dart';
import 'package:patsm/features/auth/signup/signup_state.dart';

class SignupPageWeb extends StatefulWidget {
  const SignupPageWeb({Key? key}) : super(key: key);

  @override
  State<SignupPageWeb> createState() => _SignupPageWebState();
}

class _SignupPageWebState extends State<SignupPageWeb> {

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
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.4,
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
                            (MediaQuery.of(context).padding.top + kToolbarHeight + 60),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*0.15),
                          const SizedBox(height: 20),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width*0.2,
                              maxWidth: MediaQuery.of(context).size.width*0.2,
                            ),
                            child: TextField(
                              controller: email,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Email',
                              ),
                              onChanged: (email) {},
                            ),
                          ),
                          const SizedBox(height: 20),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width*0.2,
                              maxWidth: MediaQuery.of(context).size.width*0.2,
                            ),
                            child: TextField(
                              controller: pass,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Password',
                              ),
                              onChanged: (pass) {},
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Spacer(),
                          context.watch<SignupBloc>().state.loading?
                              const CircularProgressIndicator(
                                color: Colors.white,
                              )
                          :
                          Container(
                            width: double.infinity,
                            height: 40,
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width*0.2,
                              maxWidth: MediaQuery.of(context).size.width*0.2,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<SignupBloc>().add(
                                  Signup(email: email.text.trim(), pass: pass.text.trim())
                                );
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
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<SignupBloc>().appCubit.login();
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
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
