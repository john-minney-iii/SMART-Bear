import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

/// Used to format DateTime on Card
final DateFormat formatter = DateFormat('MM/d');

/// This will get a list of un-answered questions
generateUnAnsweredQuestionTiles(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs
      .map((doc) => _questionListTile(context, doc))
      .toList();
}

Widget _questionListTile(
    BuildContext context, QueryDocumentSnapshot<Object?> doc) {
  final _formattedDate =
      formatter.format((doc['QuestionDate'] as Timestamp).toDate());
  final _cardTitle = _formattedDate + ' - ' + doc['ClassCode'];
  return Card(
      elevation: 0,
      color: Colors.blue,
      child: ListTile(
        title: Text(_cardTitle, style: const TextStyle(color: Colors.white)),
        subtitle: Text(doc['QuestionSubject'],
            style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          moveToQuestionView(context);
        },
      ));
}
