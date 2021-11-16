import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/models/question.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  // Form Variables
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Ask a Question'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: TextFormField(
                    controller: _classController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Class',
                        hintText: 'Enter Your Class Code (ie MATH350)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a Valid Class ID';
                      }
                      // TODO: add more class id validation
                      return null;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Subject',
                        hintText: 'Enter question Subject'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The Subject Can\'t be empty';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
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
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  child: const Text('Submit',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _submitNewQuestion();
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  void _submitNewQuestion() async {
    Question _testQuestion = Question(
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
    await submitQuestion(_testQuestion);
    moveToTempDashboard(context);
  }
}
