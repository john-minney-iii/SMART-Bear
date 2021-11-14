import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_bear_tutor/models/user.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

final CollectionReference _userCollectionRef = _firestore.collection('User');

/// This will return a list of all users in the Firebase Database
/// It will convert the incoming json to local objects using
/// /models/user/UserAccount
Future<List<UserAccount>?> getUsers() async {
  if (isUserAuth()) {
    // Check that the user is logged in
    QuerySnapshot _userSnapshot = await _userCollectionRef.get();
    final _data = _userSnapshot.docs;
    var _userList =
        List.filled(0, UserAccount(admin: false, email: ''), growable: true);
    // Convert Users from json to local object
    for (var account in _data) {
      _userList
          .add(UserAccount(admin: account['admin'], email: account['email']));
    }
    return _userList;
  }
  return null;
}

CollectionReference getUserCollectionRef() => _userCollectionRef;
