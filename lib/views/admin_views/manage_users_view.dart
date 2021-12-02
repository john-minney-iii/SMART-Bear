import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';
import 'package:smart_bear_tutor/widgets/user_list.dart';

class ManageUsersView extends StatefulWidget {
  const ManageUsersView({Key? key}) : super(key: key);

  @override
  _ManageUsersViewState createState() => _ManageUsersViewState();
}

class _ManageUsersViewState extends State<ManageUsersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(context, 'Manage Users', true, true),
      body: StreamBuilder(
        stream: userStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(children: generateUserTiles(context, snapshot));
        },
      ),
    );
  }
}
