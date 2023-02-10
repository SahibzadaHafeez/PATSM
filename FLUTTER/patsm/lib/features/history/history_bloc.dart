import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/history/history_events.dart';
import 'package:patsm/features/history/history_state.dart';
import 'package:patsm/repos/history_repo.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({
    required this.appCubit,
    required this.historyRepo,
  }) : super(HistoryState(data: [], scores: [], max: [])) {
    on<LoadData>(_loadData);
  }

  AppCubit appCubit;
  HistoryRepo historyRepo;

  FutureOr<void> _loadData(LoadData event, Emitter<HistoryState> emit) async {
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
          await historyRepo.getHistory(userId: appCubit.user.userId);

      if (data.isNotEmpty) {
        List<List<String>> scores = [];
        List<double> maxScores = [];
        for (int i = 0; i < data.length; i++) {
          scores.add(
            [
              data[i].data()['n_cat'],
              data[i].data()['e_cat'],
              data[i].data()['o_cat'],
              data[i].data()['a_cat'],
              data[i].data()['c_cat'],
              data[i].data()['n'],
              data[i].data()['e'],
              data[i].data()['o'],
              data[i].data()['a'],
              data[i].data()['c'],
            ],
          );
        }

        for(int i = 0; i < scores.length; i++){
          double max = double.parse(scores[i][5]);
          for(int j = 6; j < 10; j++){
            if(double.parse(scores[i][j]) > max){
              max = double.parse(scores[i][j]);
            }
          }

          maxScores.add(max);
        }

        emit(state.copyWith(data: data, scores: scores, max: maxScores));
      }
    } catch (e) {
      emit(state.copyWith(loading: false));
    }

    emit(state.copyWith(loading: false));
  }
}
