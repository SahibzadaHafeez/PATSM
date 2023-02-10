import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryRepo{

  
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getHistory({required String userId}) async {

    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];

    log('uid: $userId');
    final db = await FirebaseFirestore.instance.collection('history').get();

    for(int i = 0; i < db.docs.length; i++){
      if(db.docs[i].data().isNotEmpty){
        if(db.docs[i].data()['id'] == userId){
          data.add(db.docs[i]);
        }
      }
    }


    return data;
  }
}