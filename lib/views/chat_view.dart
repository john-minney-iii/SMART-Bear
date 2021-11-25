import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

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
    );
  }
}
