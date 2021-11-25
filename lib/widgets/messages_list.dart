import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';

generateMessageTiles(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((doc) => _messageListTile(doc)).toList();
}

Widget _messageListTile(QueryDocumentSnapshot<Object?> doc) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Align(
        alignment: (doc['AuthorId'] == currentUserUid())
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: Text('${doc['Message']}'),
          ),
        ),
      ));
}
