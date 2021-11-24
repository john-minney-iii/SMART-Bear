import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
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
      formatter.format((doc['questionDate'] as Timestamp).toDate());
  final _cardTitle = _formattedDate + ' - ' + doc['classCode'];
  return Card(
      elevation: 0,
      color: Colors.blue,
      child: ListTile(
        title: Text(_cardTitle, style: const TextStyle(color: Colors.white)),
        subtitle:
            Text(doc['subject'], style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_right),
        onTap: () async {
          final _tempQuestion = Question(
              authorId: doc['authorId'],
              classCode: doc['classCode'],
              questionDate: (doc['questionDate'] as Timestamp).toDate(),
              subject: doc['subject'],
              body: doc['body']);
          final _authorEmail = await getUserEmailById(doc['authorId']);
          moveToQuestionView(context, _tempQuestion, _authorEmail);
        },
      ));
}
