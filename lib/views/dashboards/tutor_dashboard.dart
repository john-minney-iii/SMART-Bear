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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        const SizedBox(height: 40.0),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
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
            child: Text('Welcome, Tutor!',
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Center(
            child: TextButton(
                onPressed: () async {
                  await signOutCurrentUser();
                  moveToLoginViewReplacement(context);
                },
                child: Text('Logout', style: TextStyle(color: Colors.black))),
          )
        ]),
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
                      border: Border.all(color: Colors.blueGrey, width: 4.0),
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
                          children: const <Widget>[
                            Text('Ask A Question',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Icon(
                              Icons.help,
                              size: 50.0,
                            ),
                          ]),
                      color: Colors.lightBlue[100],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 4.0),
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
                          children: const <Widget>[
                            Text('FAQ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Icon(
                              Icons.mail,
                              size: 50.0,
                            ),
                          ]),
                      color: Colors.lightBlue[100],
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
              border: Border.all(color: Colors.blueGrey, width: 4.0),
            ),
            child: RaisedButton.icon(
              onPressed: () async {
                moveToChatRoomListView(context);
              },
              icon: Icon(
                Icons.drafts_outlined,
                size: 50.0,
              ),
              label: Text('My Conversations'),
              color: Colors.lightBlue[100],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey, width: 4.0),
            ),
            child: RaisedButton.icon(
              onPressed: () async {
                final url =
                    'https://www.unco.edu/tutoring/pdf/night-time-drop-in-course-offerings.pdf';
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                  );
                } else {
                  throw 'Could not launch $url';
                }
              },
              icon: Icon(
                Icons.nights_stay,
                size: 50.0,
              ),
              label: Text('After Hours Support'),
              color: Colors.lightBlue[100],
            ),
          ),
        ]),
      ],
    ));
  }
}
