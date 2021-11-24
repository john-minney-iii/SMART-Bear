import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/widgets/blue_call_to_action.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

class AskAQuestionView extends StatefulWidget {
  const AskAQuestionView({Key? key}) : super(key: key);

  @override
  _AskAQuestionViewState createState() => _AskAQuestionViewState();
}

class _AskAQuestionViewState extends State<AskAQuestionView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(context, 'Ask A Question', true, true),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _classController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Class',
                        hintText: 'Enter your class code (ie MATH350)'),
                    validator: (value) {
                      // TODO: validator for class code
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid class ID';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Subject',
                        hintText: 'Enter question subject'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subject for your question';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, left: 15.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Enter your question below:'))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: TextFormField(
                    // TODO: add char limit
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _questionController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Question',
                        hintText: 'Enter your Question Here'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Your Question Can\'t be Empty';
                      }
                      return null;
                    },
                  ),
                )
              ],
            ),
          ),
          blueCallToAction('Submit', _submitNewQuestion)
        ],
      ),
    );
  }

  void _submitNewQuestion() async {
    if (_formKey.currentState!.validate()) {
      Question _newQuestion = Question(
          questionBody: _questionController.text,
          classCode: _classController.text,
          questionSubject: _subjectController.text,
          questionDate: DateTime.now(),
          studentEmail: (currentUserEmail() != null)
              ? currentUserEmail()!
              : 'No Email Given',
          // TODO: figure out what the image id is going to be
          questionImageID1: '',
          questionImageID2: '');
      await submitQuestion(_newQuestion);
      moveToStudentDashboardReplacement(context);
    }
  }
}
