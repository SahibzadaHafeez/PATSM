class LoginState{
  bool loading;
  String error;

  LoginState({
    this.loading = false,
    this.error = '',
  });

  LoginState copyWith({
    bool? loading,
    String? error,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      error: error?? this.error,
    );
  }
}