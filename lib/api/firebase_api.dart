import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/models/question.dart';
import 'package:smart_bear_tutor/models/user.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

final CollectionReference _userCollectionRef = _firestore.collection('User');
final CollectionReference _questionCollectionRef =
    _firestore.collection('Question');
final CollectionReference _chatRoomCollectionRef =
    _firestore.collection('ChatRoom');

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

/// Submit a Question to the Firestore Database
Future<void> submitQuestion(Question question) async {
  if (isUserAuth()) {
    try {
      await _questionCollectionRef.add(question.getJson());
      return;
    } catch (_) {
      return;
    }
  }
  return;
}

Future<List<ChatRoom>?> getChatRooms() async {
  if (isUserAuth()) {
    // Check that the user is logged in
    QuerySnapshot _chatRoomSnapshot = await _chatRoomCollectionRef.get();
    final _data = _chatRoomSnapshot.docs;
    var _chatRoomList =
        List.filled(0, ChatRoom(id: '', userIds: [], isOpen: false), growable: true);
    // Convert Users from json to local object
    for (var room in _data) {
      _chatRoomList.add(
          ChatRoom(id: room['Id'], userIds: List.from(room['Users']), isOpen: room['IsOpen']));
    }
    return _chatRoomList;
  }
  return null;
}

Future<ChatRoom?> getChatRoomByUsers(String id, String id2) async {
  if (isUserAuth()) {
    QuerySnapshot _chatRoomSnapshot = await _chatRoomCollectionRef.get();
    final _data = _chatRoomSnapshot.docs;
    for (var room in _data) {
      List<String> userIds = [room['Users'][0], room['Users'][1]];
      if (userIds.contains(id) && userIds.contains(id2)) {
        return ChatRoom(id: room['Id'], userIds: userIds, isOpen: room['IsOpen']);
      }
    }
    return null;
  }
}

Future<void> createChatRoom(ChatRoom chatRoom) async {
  await _chatRoomCollectionRef.add(chatRoom.getJson());
}

CollectionReference getUserCollectionRef() => _userCollectionRef;
CollectionReference getChatRoomsCollectionRef() => _chatRoomCollectionRef;
