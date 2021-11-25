import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/models/message.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';
import 'package:smart_bear_tutor/widgets/messages_list.dart';

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
        appBar: globalAppBar(context, 'Chat View', true, true),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: messagesStream(_chatRoom),
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
        message: 'This is a test message',
        timestamp: DateTime.now());
    createMessage(_testMessage);
  }
}
