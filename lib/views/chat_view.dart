import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/models/message.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key, required this.chatRoom}) : super(key: key);

  final ChatRoom chatRoom;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatRoom _chatRoom;

  @override
  void initState() {
    super.initState();
    _chatRoom = widget.chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Chat View', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return TextButton(
                  child: const Text('Log Out',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    final _logOutCheck = await signOutCurrentUser();
                    if (_logOutCheck) {
                      moveToLoginViewLogout(context);
                    }
                  });
            })
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: getMessageCollectionRef()
                    .where('ChatRoomId', isEqualTo: _chatRoom.id)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(children: generateMessageTiles(snapshot));
                },
              ),
            ),
            TextButton(
              child: const Text('Send Message'),
              onPressed: () {
                _sendTestMessage();
              },
            )
          ],
        ));
  }

  void _sendTestMessage() {
    final _authId = currentUserUid();
    final _testMessage = Message(
        authorId: _authId!,
        chatRoomId: _chatRoom.id,
        message: 'This is a Test Message',
        timestamp: DateTime.now());
    createMessage(_testMessage);
  }

  generateMessageTiles(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((doc) => _messageListTile(doc)).toList();
  }

  Widget _messageListTile(QueryDocumentSnapshot<Object?> doc) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Align(
          alignment: (doc['AuthorId'] == currentUserUid())
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('${doc['Message']}'),
            ),
          ),
        ));
  }
}
