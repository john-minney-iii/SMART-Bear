import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/widgets/chat_bubble.dart';

generateMessageTiles(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((doc) => _messageListTile(doc)).toList();
}

Widget _messageListTile(QueryDocumentSnapshot<Object?> doc) {
  final _id = currentUserUid();
  bool _isCurrentUser = (doc['AuthorId'] == _id);
  return ChatBubble(text: doc['Message'], isCurrentUser: _isCurrentUser);
}
