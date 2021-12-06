import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

generateUserTiles(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs.map((doc) => _userListTile(context, doc)).toList();
}

Widget _userListTile(BuildContext context, QueryDocumentSnapshot<Object?> doc) {
  Color _boxColor = const Color(0xff173f5f);
  Color _textIconColor = Colors.white;
  return Card(
      elevation: 0,
      color: _boxColor,
      child: ListTile(
          title: Text(doc['email'], style: TextStyle(color: _textIconColor)),
          trailing: Icon(Icons.edit_outlined, color: _textIconColor),
          onTap: () async {
            moveToEditAccountView(context, doc);
          }));
}
