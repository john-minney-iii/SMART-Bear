import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';
import 'package:smart_bear_tutor/widgets/tutor_list.dart';

class TutorListView extends StatefulWidget {
  const TutorListView({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  _TutorListViewState createState() => _TutorListViewState();
}

class _TutorListViewState extends State<TutorListView> {
  late Question _question;

  @override
  void initState() {
    super.initState();
    _question = widget.question;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: globalAppBar(context, 'Tutors', true, true),
        body: StreamBuilder(
          stream: tutorStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
                children: generateTutorTiles(context, snapshot, _question));
          },
        ));
  }
}
