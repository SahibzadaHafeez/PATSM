import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/auth/signup/signup_state.dart';
import 'package:patsm/features/auth/signup/signup_events.dart';
import 'package:patsm/repos/auth_repo.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>{
  SignupBloc({required this.appCubit, required this.authRepo}) : super(SignupState()){
    on<Signup>(_signup);
    on<ClearError>(_clearError);
  }

  AppCubit appCubit;
  AuthRepo authRepo;

  FutureOr<void> _signup(Signup event, Emitter<SignupState> emit) async {
    emit(state.copyWith(loading: true));

    try{
      UserCredential? creds = await authRepo.signup(email: event.email, password: event.pass);

      if(creds != null){
        appCubit.login();
      }
    }
    catch (e){
      emit(state.copyWith(error: e.toString()));
    }

    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _clearError(ClearError event, Emitter<SignupState> emit) {
    emit(state.copyWith(error: ''));
  }
}