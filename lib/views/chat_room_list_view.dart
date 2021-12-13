import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

class ChatRoomListView extends StatefulWidget {
  const ChatRoomListView({Key? key}) : super(key: key);

  @override
  _ChatRoomListViewState createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends State<ChatRoomListView> {
  bool _isStudent = true;

  @override
  Widget build(BuildContext context) {
    final _id = currentUserUid();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: globalAppBar(context, 'Chat Rooms', true, true),
        body: StreamBuilder(
          stream: chatRoomStream(_id!),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return FutureBuilder(
                future: _userRoleSelector(),
                builder: (context, snapshot) {
                  return _noChatRoomsMessage();
                },
              );
            }
          },
        ));
  }

  Future<void> _userRoleSelector() async {
    final _role = await currentUserRole();
    setState(() {
      _isStudent = (_role == 'Student');
    });
  }

  Widget _noChatRoomsMessage() {
    print(currentUserRole());
    return Container(
        child: Center(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        (_isStudent)
            ? 'You don\'nt have any open chat rooms. A tutor will answer your open questions as soon as possible'
            : 'You haven\'nt been assigned to any new questions.',
        textAlign: TextAlign.center,
      ),
    )));
  }
}
