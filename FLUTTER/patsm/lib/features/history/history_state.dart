import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryState {
  bool loading;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> data;
  List<List<String>> scores;
  List<double> max;

  HistoryState({
    this.loading = true,
    required this.data,
    required this.scores,
    required this.max,
  });

  HistoryState copyWith({
    bool? loading,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? data,
    List<List<String>>? scores,
    List<double>? max,
  }) {
    return HistoryState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      scores: scores ?? this.scores,
      max: max ?? this.max,
    );
  }
}
