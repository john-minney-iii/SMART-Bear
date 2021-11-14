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

String? currentUserUid() =>
    (_auth.currentUser != null) ? _auth.currentUser!.uid : null;

bool isUserAuth() => (_auth.currentUser != null) ? true : false;
