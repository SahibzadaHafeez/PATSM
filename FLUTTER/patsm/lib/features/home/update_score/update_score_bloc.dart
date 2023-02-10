import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/home/update_score/update_score_events.dart';
import 'package:patsm/features/home/update_score/update_score_state.dart';
import 'package:patsm/repos/home_repo.dart';

class UpdateScoreBloc extends Bloc<UpdateScoreEvent, UpdateScoreState> {
  UpdateScoreBloc({
    required this.homeRepo,
    required this.appCubit,
    required this.id,
    required this.score,
  }) : super(UpdateScoreState()) {
    on<UpdateScore>(_updateScore);
  }

  HomeRepo homeRepo;
  AppCubit appCubit;
  String id;
  List<String> score;

  FutureOr<void> _updateScore(
      UpdateScore event, Emitter<UpdateScoreState> emit) {
    log('Updating document: $id');
    homeRepo.updateScore(
        userId: appCubit.user.userId,
        datastoreID: id,
        updatedScore: event.updatedScore);
  }
}
