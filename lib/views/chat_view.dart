import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key, required this.chatRoom}) : super(key: key);

  final ChatRoom chatRoom;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
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
        body: Container());
  }
}
