abstract class AppState {}

class SignupAppState extends AppState {}

class LoginAppState extends AppState {}

class HomePageAppState extends AppState {}

class UserNotFoundAppState extends AppState {}

class CannotScoreAppState extends AppState {}

class UserFoundAppState extends AppState {
  String username;

  UserFoundAppState({
    required this.username,
  });
}

class ViewScoreAppState extends AppState {
  List<String> data;
  double max;
  String id;

  ViewScoreAppState({
    required this.data,
    required this.max,
    required this.id,
  });
}

class UpdateScoreAppState extends AppState{
  String id;
  List<String> score;

  UpdateScoreAppState({required this.id, required this.score});
}

class HistoryAppState extends AppState{}