import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/models/chatroom.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';

class UserAccountsView extends StatefulWidget {
  const UserAccountsView({Key? key}) : super(key: key);

  @override
  _UserAccountsViewState createState() => _UserAccountsViewState();
}

class _UserAccountsViewState extends State<UserAccountsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text('Users', style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              Builder(builder: (BuildContext context) {
                return TextButton(
                    child: const Text('Log Out',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      final _logOutCheck = await signOutCurrentUser();
                      if (_logOutCheck) {
                        moveToLoginViewLogout(context);
                      }
                    });
              })
            ]),
        body: StreamBuilder(
          // Get all users expect the placeholder and the current user
          stream: getUserCollectionRef()
              .where('id', isNotEqualTo: currentUserUid())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(children: _generateUserTiles(snapshot));
          },
        ));
  }

  _generateUserTiles(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((doc) => _accountListTile(doc)).toList();
  }

  Widget _accountListTile(QueryDocumentSnapshot<Object?> doc) {
    return ListTile(
      title: Text(doc['email']),
      onTap: () {
        _createChatRoom(currentUserUid()!, doc['id']);
        moveToChatView(context);
      },
    );
  }

  void _createChatRoom(String id, String id2) {
    ChatRoom _chatRoom = ChatRoom(userIds: [id, id2]);
    createChatRoom(_chatRoom);
  }
}
