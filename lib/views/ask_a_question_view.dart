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

  void _showAlreadyAskedAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("You've already asked a question for this class."),
      content: const Text(
          "Please make an appointment with UNC Tutoring Services to get further help."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showSuccessfulAlertDialog() {
    // set up the button
    Widget thanksButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        moveToStudentDashboardReplacement(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Question Successfully Sent!'),
      content: const Text(
          'Your question will be assigned to a tutor as soon as possible. We encourage you to please schedule an appointment at your earliest convenience for further tutoring assistance! We are located in the lower level of Michener Library. Please access our website Tutorial Services - University of Northern Colorado (unco.edu) to schedule an appointment with our tutors!'),
      actions: [
        thanksButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _submitNewQuestion() async {
    if (_formKey.currentState!.validate()) {
      final _userId = currentUserUid();
      if (await checkUserQuestions(_userId!, _classController.text)) {
        _showAlreadyAskedAlertDialog();
        return;
      }
      Question _newQuestion = Question(
          authorId: _userId,
          classCode: _classController.text.toUpperCase(),
          questionDate: DateTime.now(),
          subject: _subjectController.text,
          body: _questionController.text);
      await submitQuestion(_newQuestion);
      _showSuccessfulAlertDialog();
    }
  }
}
