import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/models/message.dart';
import 'package:smart_bear_tutor/models/offered_class.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
import 'package:smart_bear_tutor/models/user_account_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference _userCollectionRef = _firestore.collection('User');
final CollectionReference _questionCollectionRef =
    _firestore.collection('Question');
final CollectionReference _chatRoomCollectionRef =
    _firestore.collection('ChatRoom');
final CollectionReference _messageCollectionRef =
    _firestore.collection('Message');
final CollectionReference _offeredClassCollectionRef =
    _firestore.collection('ClassesOffered');

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

Future<bool> checkUserQuestions(String id, String classCode) async {
  // This function checks to see if there is a question document with matching
  // user id and class code, to restrict one question per classcode.
  final _data = await _questionCollectionRef
      .where('authorId', isEqualTo: id)
      .where('classCode', isEqualTo: classCode)
      .get();
  return _data.docs.isNotEmpty;
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
      id: question.authorId +
          '_' +
          user.id +
          '_' +
          question.classCode +
          ' - ' +
          question.subject,
      userIds: [question.authorId, user.id],
      isOpen: true,
      subject: question.classCode + ' - ' + question.subject);
  await createChatRoom(_chatRoom);
  await _questionCollectionRef
      .doc(_id)
      .update({'answered': true, 'tutorId': user.id});
  // Send First Message to ChatRoom (question from student)
  final _message = Message(
      authorId: question.authorId,
      chatRoomId: _chatRoom.id,
      message: question.body,
      attachedImagePath: question.imagePath,
      timestamp: DateTime.now());
  createMessage(_message);
}

Future<bool> updateUserRole(String id, String role) async {
  try {
    await _userCollectionRef.doc(id).update({'role': role});
    return true;
  } catch (e) {
    return false;
  }
}

Future<List<OfferedClass>?> getOfferedClasses() async {
  final _data = await _offeredClassCollectionRef.get();
  final _classes = _data.docs;
  if (_classes.isNotEmpty) {
    return _classes
        .map((e) =>
            OfferedClass(classCode: e['ClassCode'], subject: e['Subject']))
        .toList();
  }
  return null;
}

Future<void> createChatRoom(ChatRoom chatRoom) async {
  await _chatRoomCollectionRef.add(chatRoom.getJson());
}

Future<void> closeChatRoom(ChatRoom chatRoom) async {
  final _data =
      await _chatRoomCollectionRef.where('Id', isEqualTo: chatRoom.id).get();
  await _chatRoomCollectionRef
      .doc(_data.docs.first.id)
      .update({'IsOpen': false});
}

Future<List<Message>?> getMessages(ChatRoom chatRoom) async {
  if (isUserAuth()) {
    QuerySnapshot _messageSnapshot = await _messageCollectionRef.get();
    final _data = _messageSnapshot.docs;
    var _messageList = List.filled(
        0,
        Message(
            authorId: '',
            chatRoomId: '',
            message: '',
            timestamp: DateTime.now(),
            attachedImagePath: ''),
        growable: true);
    for (var message in _data) {
      _messageList.add(Message(
          authorId: message['AuthorId'],
          chatRoomId: message['ChatRoomId'],
          message: message['Message'],
          timestamp: message['SentTimeStamp'],
          attachedImagePath: message['AttachedImagePath']));
    }
    return _messageList;
  }
  return null;
}

Future<void> createMessage(Message message) async {
  await _messageCollectionRef.add(message.getJson());
}

Stream<QuerySnapshot<Object?>> unAnsweredQuestionsStream() =>
    _questionCollectionRef
        .where('answered', isEqualTo: false)
        .orderBy('questionDate', descending: true)
        .snapshots();

Stream<QuerySnapshot<Object?>> userStream() => _userCollectionRef.snapshots();

Stream<QuerySnapshot<Object?>> studentStream() =>
    _userCollectionRef.where('role', isEqualTo: 'Student').snapshots();

Stream<QuerySnapshot<Object?>> tutorStream() =>
    _userCollectionRef.where('role', isEqualTo: 'Tutor').snapshots();

Stream<QuerySnapshot<Object?>> adminStream() =>
    _userCollectionRef.where('role', isEqualTo: 'Admin').snapshots();

Stream<QuerySnapshot<Object?>> chatRoomStream(String id) =>
    _chatRoomCollectionRef.where('Users', arrayContains: id).snapshots();

Stream<QuerySnapshot<Object?>> messagesStream(ChatRoom chatRoom) =>
    _messageCollectionRef
        .where('ChatRoomId', isEqualTo: chatRoom.id)
        .orderBy('SentTimeStamp', descending: false)
        .snapshots();
