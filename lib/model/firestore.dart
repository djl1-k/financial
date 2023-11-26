
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices{

  static final FireStoreServices _singleton = FireStoreServices._internal();

  factory FireStoreServices() {
    return _singleton;
  }

  FireStoreServices._internal();

  final CollectionReference records = 
    FirebaseFirestore.instance.collection('records');

  //Create
  Future<void> addRecord(String description, num amount){
    return records.add({
      'description' : description,
      'amount' : amount,
      'timestamp': Timestamp.fromDate(DateTime.now()),
    }
    );
  }

  //Read
  Stream<QuerySnapshot> getRecordStream() {
    final recordStream = FirebaseFirestore.instance
      .collection('records')
      .orderBy('timestamp', descending: true)
      .snapshots();
    return recordStream; 
  }

  //Update
  Future<void> updateRecord(String docId, String newDescription, num newAmount) {
    return records.doc(docId).update({
      'description': newDescription,
      'amount': newAmount,
      'timestamp': Timestamp.fromDate(DateTime.now())
    });
  }

  //Delete
  Future<void> deleteRecord(String docId) {
    return records.doc(docId).delete();
  }

  //Get a single record based on docId
  Future<DocumentSnapshot> getRecord(String docId) {
    return FirebaseFirestore.instance.collection('records').doc(docId).get();
  }
}


