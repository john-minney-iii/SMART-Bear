import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({Key? key, required this.user}) : super(key: key);

  final QueryDocumentSnapshot<Object?> user;

  @override
  _EditAccountViewState createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  late QueryDocumentSnapshot<Object?> _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          globalAppBar(context, 'Edit ${_user['role']} Account', true, true),
    );
  }
}
