import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/widgets/admin_question_list.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

class ManageQuestionsView extends StatefulWidget {
  const ManageQuestionsView({Key? key}) : super(key: key);

  @override
  _ManageQuestionsViewState createState() => _ManageQuestionsViewState();
}

class _ManageQuestionsViewState extends State<ManageQuestionsView> {
  // TODO: check if admin
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: globalAppBar(context, 'New Questions', true, true),
        body: StreamBuilder(
          stream: unAnsweredQuestionsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
                children: generateUnAnsweredQuestionTiles(snapshot));
          },
        ));
  }
}
