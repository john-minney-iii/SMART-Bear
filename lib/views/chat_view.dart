import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/models/message.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';
import 'package:smart_bear_tutor/widgets/messages_list.dart';

// TODO: add an auto scroll to the msgs

class ChatView extends StatefulWidget {
  const ChatView({Key? key, required this.chatRoom}) : super(key: key);

  final ChatRoom chatRoom;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatRoom _chatRoom;
  late bool _chatRoomOpen;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final _scrollController = ScrollController();
  String _role = '';

  @override
  void initState() {
    super.initState();
    _chatRoom = widget.chatRoom;
    _chatRoomOpen = _chatRoom.isOpen;
  }

  @override
  Widget build(BuildContext context) {
    // After 1 second, scroll to the bottom of the SingleScrollChild
    Timer(
        Duration(seconds: 1),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: globalAppBar(context, 'Chat View', true, true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sorry this chatroom is closed',
                    style: TextStyle(
                        color: (_chatRoomOpen) ? Colors.white : Colors.red),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 550.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: SingleChildScrollView(
                    controller: _scrollController,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: _messageComposer(),
              )
            ],
          ),
        ));
  }

  Widget _messageComposer() {
    return Container(
        height: 70.0,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: Row(
            children: <Widget>[
              FutureBuilder(
                future: _getUserRole(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _closeChatRoomIconButton();
                  }
                  return Container();
                },
              ),
              Expanded(
                child: TextFormField(
                    controller: _messageController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    validator: (value) {
                      // TODO: any validation for message (char count)
                      if (value == null || value.isEmpty) {
                        return 'Please enter a message to send';
                      }
                      return null;
                    }),
              ),
              IconButton(
                icon: Icon(Icons.send),
                color: Colors.blue,
                iconSize: 25.0,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _sendMessage(_messageController.text);
                    _messageController.text = '';
                  }
                },
              )
            ],
          ),
        ));
  }

  Widget _closeChatRoomIconButton() {
    if (_role == 'Tutor') {
      return IconButton(
        icon: Icon(Icons.close),
        color: Colors.blue,
        iconSize: 25.0,
        onPressed: () async {
          _showCloseChatroomConfirmAlertDialog();
        },
      );
    }
    return Container();
  }

  Future<void> _getUserRole() async => _role = await currentUserRole();

  void _sendMessage(String message) {
    if (_chatRoomOpen) {
      final _authId = currentUserUid();
      final _message = Message(
          authorId: _authId!,
          chatRoomId: _chatRoom.id,
          message: message,
          timestamp: DateTime.now());
      createMessage(_message);
    } else {
      _showChatRoomClosedAlertDialog();
    }
  }

  void _showChatRoomClosedAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("This ChatRoom is Closed"),
      content:
          const Text("Sorry. You can't send messages to closed Chat Rooms."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showCloseChatroomConfirmAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        await closeChatRoom(_chatRoom);
        setState(() {
          _chatRoomOpen = false;
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("You are about to close this chatroom"),
      content: const Text("Once it is closed it can't be reopened"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
