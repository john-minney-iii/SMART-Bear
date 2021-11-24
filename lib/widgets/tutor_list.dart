import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

generateTutorTiles(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs
      .map((doc) => _tutorListTile(context, doc))
      .toList();
}

Widget _tutorListTile(
    BuildContext context, QueryDocumentSnapshot<Object?> doc) {
  return Card(
      elevation: 0,
      color: Colors.blue,
      child: ListTile(
        title: Text(doc['email'], style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_right),
        onTap: () async {},
      ));
}
