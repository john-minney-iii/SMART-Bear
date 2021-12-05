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
  late bool _chatRoomOpen;

  @override
  void initState() {
    super.initState();
    _chatRoom = widget.chatRoom;
    _chatRoomOpen = _chatRoom.isOpen;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _messageController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: globalAppBar(context, 'Chat View', true, true),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sorry this chatroom is closed',
                style: TextStyle(
                  color: (_chatRoomOpen) ? Colors.white : Colors.red
                ),
              )
            ),
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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: TextFormField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          validator: (value) {
                            // TODO: any validation for message (char count)
                            if (value == null || value.isEmpty) {
                              return 'Please enter a message to send';
                            }
                            return null;
                          }))
                ],
              ),
            ),
            TextButton(
              child: const Text('Send Message'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _sendMessage(_messageController.text);
                  _messageController.text = '';
                }
              },
            )
          ],
        ));
  }

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
      content: const Text(
          "Sorry. You can't send messages to closed Chat Rooms."),
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
