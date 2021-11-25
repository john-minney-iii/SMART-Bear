import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

generateChatRoomTiles(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs
      .map((doc) => _chatRoomListTile(context, doc))
      .toList();
}

Widget _chatRoomListTile(
    BuildContext context, QueryDocumentSnapshot<Object?> doc) {
  return Card(
      elevation: 0,
      color: Colors.blue,
      child: ListTile(
        title: Text(doc['Id'], style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_right),
        onTap: () async {},
      ));
}
