import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/widgets/blue_call_to_action.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

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
            Container(
                height: 50.0,
                width: 250.0,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextButton(
                  child: Text(
                    'Delete User',
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  onPressed: () {
                    _showDeleteUserAlertDialog(context);
                  },
                ))
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

  void _showDeleteUserAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        _deleteUser();
        Navigator.of(context, rootNavigator: true).pop('dialog');
        moveToManageUsersView(context);
      },
    );

    Widget cancelButton = TextButton(
      child: const Text('Cancel'),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("You are about to delete a user."),
      content: Text(
          "Are you sure you want to delete this user. This can't be undone."),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
