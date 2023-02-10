import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/features/auth/login/login_bloc.dart';
import 'package:patsm/features/auth/login/login_events.dart';
import 'package:patsm/features/auth/login/login_state.dart';

class LoginPageWeb extends StatefulWidget {
  const LoginPageWeb({Key? key}) : super(key: key);

  @override
  State<LoginPageWeb> createState() => _LoginPageWebState();
}

class _LoginPageWebState extends State<LoginPageWeb> {
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                          SizedBox(height: MediaQuery.of(context).size.height*0.2),
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
                          context.watch<LoginBloc>().state.loading?
                          const CircularProgressIndicator(
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
                              autofocus: true,
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
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<LoginBloc>().appCubit.signup();
                                },
                                child: const Text(
                                  'Signup',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
