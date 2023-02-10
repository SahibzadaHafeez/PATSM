class GetUserRequest {
  GetUserRequest({
    required this.username,
  });
  late final String username;

  GetUserRequest.fromJson(Map<String, dynamic> json){
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    return data;
  }
}