import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/util/push_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

import '../student_faq_view.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  _AdminDashboardViewState createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  Color _boxColor = const Color(0xff173f5f);
  Color _borderColor = const Color(0xFFFFB300);
  Color _textIconColor = Colors.white;
  final _borderWidth = 3.0;
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
    super.initState();
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 30.0, 10.0),
                  child: Image(
                    image: AssetImage('assets/unco-bear-letter-logo.png'),
                    //width: 80,
                    //height: 80,
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.10,
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 30.0, 10.0),
                  child: Text('Welcome, Admin!',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ]),
        ),
        Column(children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Divider(color: Colors.black),
          ),
        ]),
        Column(children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Admin Dashboard',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    )),
              )),
        ]),
        Column(children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: _borderColor, width: _borderWidth),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _manageQuestionsOnPressed();
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Manage Questions',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _textIconColor)),
                            Icon(Icons.help, size: 50.0, color: _textIconColor),
                          ]),
                      style: ElevatedButton.styleFrom(primary: _boxColor),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: _borderColor, width: _borderWidth),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentFAQView()),
                        );
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('FAQ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _textIconColor)),
                            Icon(Icons.mail, size: 50.0, color: _textIconColor),
                          ]),
                      style: ElevatedButton.styleFrom(primary: _boxColor),
                    ),
                  ),
                ]),
          ),
        ]),
        Column(children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: _borderColor, width: _borderWidth),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _manageUsersOnPressed();
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Manage Users',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _textIconColor)),
                            Icon(Icons.supervised_user_circle_sharp,
                                size: 50.0, color: _textIconColor),
                          ]),
                      style: ElevatedButton.styleFrom(primary: _boxColor),
                    ),
                  ),
                ]),
          ),
        ]),
        Column(children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Divider(color: Colors.black),
          ),
        ]),
        Column(children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: _borderColor, width: _borderWidth),
            ),
            child: ElevatedButton.icon(
              onPressed: () async {
                final url =
                    'https://console.firebase.google.com/project/smart-bear-f7c5d/notification/compose';
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                  );
                } else {
                  throw 'Could not launch $url'; // ToDo:Pull error message popup in app instead of console.
                }
              },
              icon: Icon(Icons.notifications_on_outlined,
                  size: 50.0, color: _textIconColor),
              label: Text('Send Notifications',
                  style: TextStyle(color: _textIconColor)),
              style: ElevatedButton.styleFrom(primary: _boxColor),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: _borderColor, width: _borderWidth),
            ),
            child: ElevatedButton.icon(
              onPressed: () async {
                await signOutCurrentUser();
                moveToLoginViewReplacement(context);
              },
              icon: Icon(const IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                  size: 50.0, color: _textIconColor),
              label: Text('Logout', style: TextStyle(color: _textIconColor)),
              style: ElevatedButton.styleFrom(primary: _boxColor),
            ),
          ),
        ]),
      ],
    ));
  }

  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 8.0),
  //             child: TextButton(
  //               child: const Text('Send Notification'),
  //               onPressed: _sendNotificationsOnPressed,
  //             ),
  //           ),

  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 8.0),
  //             child: TextButton(
  //               child: const Text('Settings'),
  //               onPressed: _settingsOnPressed,
  //             ),
  //           )

  void _manageQuestionsOnPressed() {
    // TODO: whatever else is needed ig
    moveToManageQuestionsView(context);
  }

  void _manageUsersOnPressed() {
    moveToManageUsersView(context);
  }
}
