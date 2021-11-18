import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/login_view.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/push_notification_option.dart';
import 'package:smart_bear_tutor/register_view.dart';
import 'package:smart_bear_tutor/views/chat_view.dart';
import 'package:smart_bear_tutor/views/question_view.dart';
import 'package:smart_bear_tutor/views/temp_dashboard.dart';
import 'package:smart_bear_tutor/views/user_accounts_view.dart';

void moveToLoginViewReplacement(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginView()));
}

void moveToLoginViewLogout(context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (route) => false);
}

void moveToPushNotificationView(context) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const PushNotificationOptionsView()));
}

void moveToRegisterView(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const RegisterView()));
}

void moveToUserAccountsView(context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const UserAccountsView()));
}

void moveToChatView(context, ChatRoom chatRoom) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ChatView(chatRoom: chatRoom)));
}

void moveToTempDashboard(BuildContext context) => Navigator.push(context,
    MaterialPageRoute(builder: (context) => const TempDashboardView()));

void moveToQuestionView(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const QuestionView()));
