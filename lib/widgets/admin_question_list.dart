import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This will get a list of un-answered questions
generateUnAnsweredQuestionTiles(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((doc) => _questionListTile(doc)).toList();
}

Widget _questionListTile(QueryDocumentSnapshot<Object?> doc) {
  return ListTile(
    title: Text(doc['QuestionSubject']),
  );
}
