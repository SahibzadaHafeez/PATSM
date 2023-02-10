class UserCredentials {
  String userId;

  UserCredentials({
    this.userId = '',
  });

  UserCredentials copyWith({
    String? userId,
  }) {
    return UserCredentials(
      userId: userId ?? this.userId,
    );
  }
}
