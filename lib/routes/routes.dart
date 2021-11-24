import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
import 'package:smart_bear_tutor/views/ask_a_question_view.dart';
import 'package:smart_bear_tutor/views/dashboards/admin_dashboard_view.dart';
import 'package:smart_bear_tutor/views/admin_views/manage_questions_view.dart';
import 'package:smart_bear_tutor/views/login_view.dart';
import 'package:smart_bear_tutor/views/admin_views/question_view.dart';
import 'package:smart_bear_tutor/views/register_view.dart';
import 'package:smart_bear_tutor/views/dashboards/student_dashboard_view.dart';

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

void moveToAskAQuestionView(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const AskAQuestionView()));

void moveToManageQuestionsView(BuildContext context) => Navigator.push(context,
    MaterialPageRoute(builder: (context) => const ManageQuestionsView()));

void moveToQuestionView(
        BuildContext context, Question question, String authorEmail) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuestionView(question: question, authorEmail: authorEmail)));
