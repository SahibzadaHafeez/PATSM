class UserFoundState {
  bool loading;

  UserFoundState({
    this.loading = false,
  });

  UserFoundState copyWith({
    bool? loading,
  }) {
    return UserFoundState(
      loading: loading ?? this.loading,
    );
  }
}
