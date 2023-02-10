import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/home/user_found/user_found_events.dart';
import 'package:patsm/features/home/user_found/user_found_state.dart';
import 'package:patsm/repos/home_repo.dart';

class UserFoundBloc extends Bloc<UserFoundEvent, UserFoundState> {
  UserFoundBloc({
    required this.appCubit,
    required this.homeRepo,
    required this.username,
  }) : super(UserFoundState()){
    on<GetScore>(_getScore);
  }

  AppCubit appCubit;
  HomeRepo homeRepo;
  String username;

  FutureOr<void> _getScore(event, Emitter<UserFoundState> emit) async {
    emit(state.copyWith(loading: true));

    try {
      List<String> score = await homeRepo.getScore(username: username);

      if (score.isNotEmpty) {
        String id = await homeRepo.saveScore(userId: appCubit.user.userId, score: score);
        emit(state.copyWith(loading: false));
        appCubit.viewScore(data: score, id: id);
      }
    }
    catch (e){
      emit(state.copyWith(loading: false));
    }
  }
}
