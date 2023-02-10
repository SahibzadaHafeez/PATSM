import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:patsm/models/get_user_request.dart';

class HomeRepo {
  Future<List<String>> getUser(String username) async {
    List<String> ret = [];

    GetUserRequest model = GetUserRequest(username: username);

    log('user: ${model.username}');

    var url = Uri.parse('http://127.0.0.1:8080/getuser');
    log(json.encode(model));
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(model),
    );

    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decoded = json.decode(data);

        ret = List<String>.from(decoded as List);
      } else {
        log('hello: ${response.statusCode}');
      }
    } catch (e) {
      log('fail: $e');
    }

    return ret;
  }

  Future<List<String>> getScore({required String username}) async {
    List<String> score = [];

    GetUserRequest model = GetUserRequest(username: username);

    log(username);

    var url = Uri.parse('http://127.0.0.1:8080/getscore');
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(model),
    );

    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decoded = json.decode(data);

        score = List<String>.from(decoded as List);
      } else {
        log('hello: ${response.statusCode}');
      }
    } catch (e) {
      log('fail: $e');
    }

    return score;
  }

  Future<String> saveScore(
      {required String userId, required List<String> score}) async {
    log(score[1]);
    final data = <String, String>{
      "id": userId,
      "username": score[10],
      "n": score[5],
      "e": score[6],
      "o": score[7],
      "a": score[8],
      "c": score[9],
      "n_cat": score[0],
      "e_cat": score[1],
      "o_cat": score[2],
      "a_cat": score[3],
      "c_cat": score[4],
    };

    var id = await FirebaseFirestore.instance.collection("history").add(data);
    return id.id;
  }

  void updateScore(
      {required String userId,
      required String datastoreID,
      required List<String> updatedScore}) {
    FirebaseFirestore.instance.collection('history').doc(datastoreID).update({
      'updated_o': updatedScore[0],
      'updated_c': updatedScore[1],
      'updated_e': updatedScore[2],
      'updated_a': updatedScore[3],
      'updated_n': updatedScore[4],
    });
  }
}
