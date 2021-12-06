import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

generateChatRoomTiles(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs
      .map((doc) => _chatRoomListTile(context, doc))
      .toList();
}

Widget _chatRoomListTile(
    BuildContext context, QueryDocumentSnapshot<Object?> doc) {
  Color _boxColor = const Color(0xff173f5f);
  Color _textIconColor = Colors.white;

  return Card(
      elevation: 0,
      color: (doc['IsOpen']) ? _boxColor : Colors.grey,
      child: ListTile(
        title: Text(doc['Subject'], style: TextStyle(color: _textIconColor)),
        trailing: Icon(Icons.arrow_right, color: _textIconColor),
        onTap: () {
          ChatRoom _chatRoom = ChatRoom(
              id: doc['Id'],
              userIds: List.from(doc['Users']),
              isOpen: doc['IsOpen'],
              subject: doc['Subject']);
          moveToChatView(context, _chatRoom);
        },
      ));
}
