import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

generateUserTiles(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((doc) => _userListTile(context, doc)).toList();
}

Widget _userListTile(BuildContext context, QueryDocumentSnapshot<Object?> doc) {
  return Card(
      elevation: 0,
      color: Colors.blue,
      child: ListTile(
          title:
              Text(doc['email'], style: const TextStyle(color: Colors.white)),
          trailing: const Icon(Icons.edit_outlined, color: Colors.white),
          onTap: () async {
            // TODO: move admin to user edit screen
          }));
}
