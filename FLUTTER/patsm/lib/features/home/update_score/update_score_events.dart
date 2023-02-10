abstract class UpdateScoreEvent{}

class UpdateScore extends UpdateScoreEvent{
  List<String> updatedScore;

  UpdateScore({required this.updatedScore});
}