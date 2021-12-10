import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/widgets/blue_call_to_action.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';
import 'package:smart_bear_tutor/widgets/red_call_to_action.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({Key? key, required this.user}) : super(key: key);

  final QueryDocumentSnapshot<Object?> user;

  @override
  _EditAccountViewState createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  late QueryDocumentSnapshot<Object?> _user;
  final String _student = 'Student';
  final String _admin = 'Admin';
  final String _tutor = 'Tutor';
  String _role = '';

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _role = widget.user['role'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:
            globalAppBar(context, 'Edit ${_user['role']} Account', true, true),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                'Email: ${_user['email']}',
                style: const TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: SizedBox(
                  height: 169.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ListTile(
                            title: Text(_student),
                            leading: Radio(
                                value: _student,
                                groupValue: _role,
                                onChanged: (value) {
                                  setState(() {
                                    _role = value.toString();
                                  });
                                },
                                activeColor: Colors.blue)),
                        ListTile(
                            title: Text(_tutor),
                            leading: Radio(
                                value: _tutor,
                                groupValue: _role,
                                onChanged: (value) {
                                  setState(() {
                                    _role = value.toString();
                                  });
                                },
                                activeColor: Colors.blue)),
                        ListTile(
                            title: Text(_admin),
                            leading: Radio(
                                value: _admin,
                                groupValue: _role,
                                onChanged: (value) {
                                  setState(() {
                                    _role = value.toString();
                                  });
                                },
                                activeColor: Colors.blue)),
                      ])),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Center(child: blueCallToAction('Update', _updateUser)),
            ),
            Center(child: redCallToAction('Delete User', _deleteUser))
          ],
        ));
  }

  void _updateUser() async {
    final _response = await updateUserRole(_user['id'], _role);
    if (_response) {
      moveToManageUsersView(context);
    }
  }

  void _deleteUser() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(_user['id'])
        .delete();
  }
}
