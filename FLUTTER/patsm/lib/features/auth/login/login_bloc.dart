import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/auth/login/login_events.dart';
import 'package:patsm/features/auth/login/login_state.dart';
import 'package:patsm/repos/auth_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authRepo, required this.appCubit})
      : super(LoginState()){
    on<Login>(_login);
    on<ClearError>(_clearError);
  }

  AppCubit appCubit;
  AuthRepo authRepo;

  FutureOr<void> _login(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loading: true));

    try{
      UserCredential? creds = await authRepo.login(email: event.email, pass: event.pass);

      if(creds != null){
        appCubit.user = appCubit.user.copyWith(userId: creds.user!.uid);
        appCubit.homepage();
      }
    }
    catch (e){
      emit(state.copyWith(error: e.toString()));
    }

    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _clearError(ClearError event, Emitter<LoginState> emit) {
    emit(state.copyWith(error: ''));
  }
}
