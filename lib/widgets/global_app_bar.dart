import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

AppBar globalAppBar(
    BuildContext context, String title, bool applyLeading, bool includeLogout) {
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.blue,
    automaticallyImplyLeading: (applyLeading) ? true : false,
    actions: <Widget>[
      Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Center(
            child: TextButton(
                onPressed: () async {
                  await signOutCurrentUser();
                  moveToLoginViewReplacement(context);
                },
                child: Text('Logout',
                    style: TextStyle(
                        color: (includeLogout) ? Colors.white : Colors.blue))),
          ))
    ],
  );
}
