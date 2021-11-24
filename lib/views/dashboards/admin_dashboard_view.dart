import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  _AdminDashboardViewState createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: globalAppBar(context, 'Admin Dashboard', false, true),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                child: const Text('Manage Questions'),
                onPressed: _manageQuestionsOnPressed,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                child: const Text('Manage Tutor Availability'),
                onPressed: _manageTutorAvailability,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                child: const Text('Manage Users'),
                onPressed: _manageUsersOnPressed,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                child: const Text('Manage FAQ'),
                onPressed: _manageFaqOnPressed,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                child: const Text('Send Notification'),
                onPressed: _sendNotificationsOnPressed,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                child: const Text('Settings'),
                onPressed: _settingsOnPressed,
              ),
            )
          ],
        ));
  }

  void _manageQuestionsOnPressed() {
    // TODO: whatever else is needed ig
    moveToManageQuestionsView(context);
  }

  void _manageTutorAvailability() {
    // TODO: manage tutor availability
  }

  void _manageUsersOnPressed() {
    // TODO: manage users
  }

  void _manageFaqOnPressed() {
    // TODO: manage faq
  }

  void _sendNotificationsOnPressed() {
    // TODO: send notifications
  }

  void _settingsOnPressed() {
    // TODO: settings view
  }
}
