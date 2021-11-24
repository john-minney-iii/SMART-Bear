import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
import 'package:smart_bear_tutor/models/user_account_model.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

generateTutorTiles(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot,
    Question question) {
  return snapshot.data!.docs
      .map((doc) => _tutorListTile(context, doc, question))
      .toList();
}

Widget _tutorListTile(BuildContext context, QueryDocumentSnapshot<Object?> doc,
    Question question) {
  return Card(
      elevation: 0,
      color: Colors.blue,
      child: ListTile(
        title: Text(doc['email'], style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_right),
        onTap: () async {
          final _tutorAccount = UserAccount(
              role: doc['role'], email: doc['email'], id: doc['id']);
          await assignQuestionToTutor(question, _tutorAccount);
          moveToAdminDashboardReplacement(context);
        },
      ));
}
