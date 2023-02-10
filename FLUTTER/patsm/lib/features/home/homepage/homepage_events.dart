abstract class HomePageEvent{}

class GetUser extends HomePageEvent{
  String username;

  GetUser({
    required this.username,
});
}