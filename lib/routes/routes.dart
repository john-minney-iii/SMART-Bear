import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
import 'package:smart_bear_tutor/views/admin_views/tutor_list_view.dart';
import 'package:smart_bear_tutor/views/admin_views/user_management/edit_account_view.dart';
import 'package:smart_bear_tutor/views/ask_a_question_view.dart';
import 'package:smart_bear_tutor/views/chat_room_list_view.dart';
import 'package:smart_bear_tutor/views/chat_view.dart';
import 'package:smart_bear_tutor/views/dashboards/dashboard_student.dart';
import 'package:smart_bear_tutor/views/dashboards/admin_dashboard_view.dart';
import 'package:smart_bear_tutor/views/admin_views/admin_faq_view.dart';
import 'package:smart_bear_tutor/views/admin_views/manage_questions_view.dart';
import 'package:smart_bear_tutor/views/dashboards/tutor_dashboard.dart';
import 'package:smart_bear_tutor/views/login_view.dart';
import 'package:smart_bear_tutor/views/admin_views/question_view.dart';
import 'package:smart_bear_tutor/views/register_view.dart';
import 'package:smart_bear_tutor/views/student_faq_view.dart';
import 'package:smart_bear_tutor/views/admin_views/user_management/manage_users_view.dart';

void moveToLoginViewReplacement(BuildContext context) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginView()));

void moveToRegisterView(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const RegisterView()));

void moveToStudentDashboardReplacement(BuildContext context) =>
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const DashboardStudentPage()));

void moveToTutorDashboardReplacement(BuildContext context) =>
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const TutorDashboard()));

void moveToUserDashboardReplacement(BuildContext context) async {
  final _role = await currentUserRole();
  if (_role == 'Tutor') {
    moveToTutorDashboardReplacement(context);
  } else if (_role == 'Admin') {
    moveToAdminDashboardReplacement(context);
  } else if (_role == 'Student') {
    moveToStudentDashboardReplacement(context);
  }
}

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

void moveToTutorListView(
        BuildContext context, Question question) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TutorListView(question: question)));

void moveToChatRoomListView(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const ChatRoomListView()));

void moveToChatView(BuildContext context, ChatRoom chatRoom) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ChatView(chatRoom: chatRoom)));

void moveToAdminFAQView(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const AdminFAQView()));

void moveToStudentFAQView(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const StudentFAQView()));

void moveToManageUsersView(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const ManageUsersView()));

void moveToEditAccountView(
        BuildContext context, QueryDocumentSnapshot<Object?> user) =>
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditAccountView(user: user)));
