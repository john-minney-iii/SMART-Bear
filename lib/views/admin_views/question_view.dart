import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/widgets/blue_call_to_action.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';
import 'package:smart_bear_tutor/widgets/red_call_to_action.dart';

class QuestionView extends StatefulWidget {
  const QuestionView(
      {Key? key, required this.question, required this.authorEmail})
      : super(key: key);

  final Question question;
  final String authorEmail;

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  late Question _question;
  late String _authorEmail;

  @override
  void initState() {
    _question = widget.question;
    _authorEmail = widget.authorEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: globalAppBar(context, 'Question', true, true),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Student Email:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              Align(alignment: Alignment.centerLeft, child: Text(_authorEmail)),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Class Code:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(_question.classCode)),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Subject:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(_question.subject)),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Question:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft, child: Text(_question.body)),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Image:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: _showQuestionImage(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                    child:
                        blueCallToAction('Assign Question', _assignOnPressed)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                    child:
                        redCallToAction('Decline Question', _declineOnPressed)),
              )
            ],
          ),
        ));
  }

  Widget _showQuestionImage() {
    return FutureBuilder(
      future: _getDownloadLink(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Image.network(snapshot.data.toString(),
                width: 150, height: 150);
          } else {
            return const Text('No Attached Image');
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<String> _getDownloadLink() async {
    return await FirebaseStorage.instance
        .ref()
        .child(_question.imagePath)
        .getDownloadURL();
  }

  void _assignOnPressed() {
    // TODO: assign question to tutor
    moveToTutorListView(context, _question);
  }

  void _declineOnPressed() {
    // TODO: decline question
  }
}
