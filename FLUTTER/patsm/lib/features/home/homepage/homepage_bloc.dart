import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/features/home/homepage/homepage_events.dart';
import 'package:patsm/features/home/homepage/homepage_state.dart';
import 'package:patsm/repos/home_repo.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState>{
  HomePageBloc({required this.appCubit, required this.homeRepo}) : super(HomePageState()){
    on<GetUser>(_getUser);
  }

  AppCubit appCubit;
  HomeRepo homeRepo;

  FutureOr<void> _getUser(GetUser event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      List<String> data = await homeRepo.getUser(event.username);

      if(data.isNotEmpty){

        log('result: ${data[0]}');

        if(data.length == 1){
          appCubit.userNotFound();
        }
        else if(data[0] == 'ok' || data[0] == 'ok'){
          appCubit.userFound(username: event.username);
        }
        else{
          appCubit.cannotScore();
        }
      }
    }
    catch (e){
      emit(state.copyWith(loading: false));
    }

    emit(state.copyWith(loading: false));
  }
}