// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_bear_tutor/api/user_auth.dart';
// import 'package:smart_bear_tutor/routes/routes.dart';
// import 'package:smart_bear_tutor/util/messaging/messaging_util.dart';
//
// generateUserTiles(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//   return snapshot.data!.docs
//       .map((doc) => _accountListTile(context, doc))
//       .toList();
// }
//
// Widget _accountListTile(
//     BuildContext context, QueryDocumentSnapshot<Object?> doc) {
//   return ListTile(
//     title: Text(doc['email']),
//     onTap: () async {
//       final _chatRoom =
//           await accountListTileOnTap(currentUserUid()!, doc['id']);
//       moveToChatView(context, _chatRoom);
//     },
//   );
// }
