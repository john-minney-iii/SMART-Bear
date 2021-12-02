import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

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
    );
  }
}
