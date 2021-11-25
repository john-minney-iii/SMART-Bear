import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
import 'package:smart_bear_tutor/models/user_account_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference _userCollectionRef = _firestore.collection('User');
final CollectionReference _questionCollectionRef =
    _firestore.collection('Question');
final CollectionReference _chatRoomCollectionRef =
    _firestore.collection('ChatRoom');

Future<void> createUser(User user, String role) async {
  _userCollectionRef
      .doc(user.uid)
      .set({'email': user.email, 'role': role, 'id': user.uid});
}

Future<UserAccount> getUserAccount(String id) async {
  final _data = await _userCollectionRef.doc(id).get();
  return UserAccount(
      role: _data['role'], email: _data['email'], id: _data['id']);
}

Future<String> getUserEmailById(String id) async {
  final _data = await _userCollectionRef.doc(id).get();
  return _data['email'];
}

Future<void> submitQuestion(Question question) async {
  if (isUserAuth()) {
    await _questionCollectionRef.add(question.getJson());
  }
  return;
}

Future<void> assignQuestionToTutor(Question question, UserAccount user) async {
  final _data = await _questionCollectionRef
      .where('authorId', isEqualTo: question.authorId)
      .get();
  final _id = _data.docs.first.id;
  ChatRoom _chatRoom = ChatRoom(
      id: question.authorId + '_' + user.id,
      userIds: [question.authorId, user.id],
      isOpen: true);
  await createChatRoom(_chatRoom);
  await _questionCollectionRef
      .doc(_id)
      .update({'answered': true, 'tutorId': user.id});
}

Future<void> createChatRoom(ChatRoom chatRoom) async {
  await _chatRoomCollectionRef.add(chatRoom.getJson());
}

Stream<QuerySnapshot<Object?>> unAnsweredQuestionsStream() =>
    _questionCollectionRef.where('answered', isEqualTo: false).snapshots();

Stream<QuerySnapshot<Object?>> tutorStream() =>
    _userCollectionRef.where('role', isEqualTo: 'Tutor').snapshots();

Stream<QuerySnapshot<Object?>> chatRoomStream(String id) =>
    _chatRoomCollectionRef.where('Users', arrayContains: id).snapshots();
