class HomePageState {
  bool loading;

  HomePageState({
    this.loading = false,
  });

  HomePageState copyWith({
    bool? loading,
  }) {
    return HomePageState(
      loading: loading ?? this.loading,
    );
  }
}
