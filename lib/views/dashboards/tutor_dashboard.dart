import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ask_a_question_view.dart';
import '../student_faq_view.dart';

class TutorDashboard extends StatefulWidget {
  const TutorDashboard({Key? key}) : super(key: key);

  @override
  _TutorDashboardState createState() => _TutorDashboardState();
}

class _TutorDashboardState extends State<TutorDashboard> {
  Color _boxColor = const Color(0xff173f5f);
  Color _borderColor = const Color(0xFFFFB300);
  Color _textIconColor = Colors.white;
  final _borderWidth = 3.0;

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
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.10,
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 30.0, 10.0),
                  child: Text('Welcome, Student!',
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
                child: Text('Tutor Dashboard',
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
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AskAQuestionView()),
                        );
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Ask A Question',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _textIconColor)),
                            Icon(Icons.help, size: 50.0, color: _textIconColor),
                          ]),
                      color: _boxColor,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: _borderColor, width: _borderWidth),
                    ),
                    child: RaisedButton(
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
                      color: _boxColor,
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
            child: RaisedButton.icon(
              onPressed: () async {
                moveToChatRoomListView(context);
              },
              icon: Icon(Icons.drafts_outlined,
                  size: 50.0, color: _textIconColor),
              label: Text('My Conversations',
                  style: TextStyle(color: _textIconColor)),
              color: _boxColor,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: _borderColor, width: _borderWidth),
            ),
            child: RaisedButton.icon(
              onPressed: () async {
                await signOutCurrentUser();
                moveToLoginViewReplacement(context);
              },
              icon: Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                  size: 50.0, color: _textIconColor),
              label: Text('Logout', style: TextStyle(color: _textIconColor)),
              color: _boxColor,
            ),
          ),
        ]),
      ],
    ));
  }
}
