import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

import 'firebase_api.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseAuth getCurrentAuth() => _auth;

Future<void> signOutCurrentUser() async => await _auth.signOut();

Future<bool> signInWithEmailAndPassword(
    BuildContext context, String email, String password) async {
  try {
    final User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      final _userAccount = await getUserAccount(user.uid);

      if (_userAccount.role == 'Student') {
        moveToStudentDashboardReplacement(context);
      } else if (_userAccount.role == 'Admin') {
        moveToAdminDashboardReplacement(context);
      } else if (_userAccount.role == 'Tutor') {
        moveToTutorDashboardReplacement(context);
      }
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<String> currentUserRole() async {
  final _user = await getUserAccount(_auth.currentUser!.uid);
  return _user.role;
}

String? currentUserUid() =>
    (_auth.currentUser != null) ? _auth.currentUser!.uid : null;

String? currentUserEmail() =>
    (_auth.currentUser != null) ? _auth.currentUser!.email : null;

bool isUserAuth() => (_auth.currentUser != null) ? true : false;
