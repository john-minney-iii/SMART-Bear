import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<bool> signOutCurrentUser() async {
  try {
    await _auth.signOut();
    return true;
  } on Exception catch (_) {
    return false;
  }
}

bool isUserAuth() => (_auth.currentUser != null) ? true : false;