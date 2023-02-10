import 'package:patsm/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patsm/repos/auth_repo.dart';
import 'package:patsm/user_details.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required this.authRepo}) : super(
            // ViewScoreAppState(
            //   data: [
            //     "high",
            //     "high",
            //     "vhigh",
            //     "vhigh",
            //     "high",
            //     "98",
            //     "88",
            //     "84",
            //     "84",
            //     "102",
            //     "SaiH0s",
            //     "1158466906711633921",
            //   ],
            //   max: 102,
            // ),

            LoginAppState()) {
    autoLogin();
  }

  AuthRepo authRepo;
  UserCredentials user = UserCredentials();
  bool isLogged = false;

  autoLogin() {
    String uid = authRepo.autoLogin();

    if (uid != '') {
      user = user.copyWith(userId: uid);
      isLogged = true;
      homepage();
    }
  }

  login() => emit(LoginAppState());
  signup() => emit(SignupAppState());
  homepage() => emit(HomePageAppState());
  userNotFound() => emit(UserNotFoundAppState());
  cannotScore() => emit(CannotScoreAppState());
  userFound({required String username}) =>
      emit(UserFoundAppState(username: username));
  logout() async {
    authRepo.logout();
    login();
  }

  viewScore({required List<String> data, required String id}) {
    double max = double.parse(data[5]);
    for (int i = 6; i < 9; i++) {
      if (double.parse(data[i]) > max) {
        max = double.parse(data[i]);
      }
    }
    emit(ViewScoreAppState(data: data, max: max, id: id));
  }

  updateScore({required String id, required List<String> score}) =>
      emit(UpdateScoreAppState(id: id, score: score));

  history() => emit(HistoryAppState());
}
