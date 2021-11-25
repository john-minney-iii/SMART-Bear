import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDashboardView extends StatefulWidget {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  _StudentDashboardViewState createState() => _StudentDashboardViewState();
}

class _StudentDashboardViewState extends State<StudentDashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(context, 'Student Dashboard', false, true),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              child: const Text('Appointments'),
              onPressed: _appointmentsOnPressed,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              child: const Text('Tutor Availability'),
              onPressed: _tutorAvailabilityOnPressed,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              child: const Text('Ask a Question'),
              onPressed: _askQuestionOnPressed,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              child: const Text('Chat Rooms'),
              onPressed: _chatRoomsOnPressed,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              child: const Text('FAQ'),
              onPressed: _faqOnPressed,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              child: const Text('Settings'),
              onPressed: _settingsOnPressed,
            ),
          ),
        ],
      ),
    );
  }

  void _appointmentsOnPressed() async {
    // redirect user to web page
    const _url = 'https://www.unco.edu/tutoring/#tutortrac';
    if (await canLaunch(_url)) {
      await launch(_url, forceSafariVC: false);
    } else {
      throw 'Could Not Launch $_url';
    }
  }

  void _chatRoomsOnPressed() async {
    moveToChatRoomListView(context);
  }

  void _tutorAvailabilityOnPressed() {
    // TODO: move to tutor availability web page
  }

  void _askQuestionOnPressed() {
    moveToAskAQuestionView(context);
  }

  void _faqOnPressed() {
    // TODO: move to FAQ view
  }

  void _settingsOnPressed() {
    // TODO: move to settings view
  }
}
