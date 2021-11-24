import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/views/admin_dashboard_view.dart';
import 'package:smart_bear_tutor/views/login_view.dart';
import 'package:smart_bear_tutor/views/register_view.dart';
import 'package:smart_bear_tutor/views/student_dashboard_view.dart';

void moveToLoginViewReplacement(BuildContext context) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginView()));

void moveToRegisterView(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const RegisterView()));

void moveToStudentDashboardReplacement(BuildContext context) =>
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const StudentDashboardView()));

void moveToAdminDashboardReplacement(BuildContext context) =>
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const AdminDashboardView()));
