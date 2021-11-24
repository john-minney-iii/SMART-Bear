import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

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
        appBar: globalAppBar(context, 'Student Dashboard', false, true));
  }
}
