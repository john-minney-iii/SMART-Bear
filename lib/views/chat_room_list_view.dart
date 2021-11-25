import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/widgets/chat_rooms_list.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

class ChatRoomListView extends StatefulWidget {
  const ChatRoomListView({Key? key}) : super(key: key);

  @override
  _ChatRoomListViewState createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends State<ChatRoomListView> {
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
            }
            return ListView(children: generateChatRoomTiles(context, snapshot));
          },
        ));
  }
}
