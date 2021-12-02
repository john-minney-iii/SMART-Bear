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
  String _selectedRole = 'Student'; // Either Student, Admin, or Tutor
  final _studentRole = 'Student';
  final _tutorRole = 'Tutor';
  final _adminRole = 'Admin';
  final Map<String, dynamic> _streams = {
    'Student': studentStream(),
    'Tutor': tutorStream(),
    'Admin': adminStream()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(context, 'Manage Users', true, true),
      body: StreamBuilder(
        stream: _streams[_selectedRole],
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(children: generateUserTiles(context, snapshot));
        },
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
        color: Colors.grey,
        height: 55.0,
        width: double.infinity,
        child: IntrinsicHeight(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        _switchRole(_studentRole);
                      },
                      child: const Text('Students'),
                      style: ElevatedButton.styleFrom(
                          primary: (_selectedRole == _studentRole)
                              ? Colors.blue
                              : Colors.grey,
                          textStyle: const TextStyle(color: Colors.black),
                          elevation:
                              (_selectedRole == _studentRole) ? 2.0 : 0)),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        _switchRole(_tutorRole);
                      },
                      child: const Text('Tutors'),
                      style: ElevatedButton.styleFrom(
                          primary: (_selectedRole == _tutorRole)
                              ? Colors.blue
                              : Colors.grey,
                          textStyle: const TextStyle(color: Colors.black),
                          elevation: (_selectedRole == _tutorRole) ? 2.0 : 0)),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        _switchRole(_adminRole);
                      },
                      child: const Text('Admins'),
                      style: ElevatedButton.styleFrom(
                          primary: (_selectedRole == _adminRole)
                              ? Colors.blue
                              : Colors.grey,
                          textStyle: const TextStyle(color: Colors.black),
                          elevation: (_selectedRole == _adminRole) ? 2.0 : 0)),
                ),
              ]),
        ));
  }

  void _switchRole(String _role) {
    setState(() {
      _selectedRole = _role;
    });
  }
}
