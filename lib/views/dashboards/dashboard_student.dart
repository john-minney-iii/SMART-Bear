import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:smart_bear_tutor/views/student_faq_view.dart';
import 'package:smart_bear_tutor/views/ask_a_question_view.dart';

class DashboardStudentPage extends StatefulWidget {
  const DashboardStudentPage({Key? key}) : super(key: key);

  @override
  _DashboardStudentPageState createState() => _DashboardStudentPageState();
}

class _DashboardStudentPageState extends State<DashboardStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Want to become a tutor or SI leader?  ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    InkWell(
                        child: Text('Click Here',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () => launch(
                            'https://www.unco.edu/tutoring/resources-forms/become-a-peer-tutor-or-si-leader.aspx')),
                  ]),
              backgroundColor: Colors.amber,
            )),
        body: Column(
          children: <Widget>[
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
                child: Text('Welcome, Student!',
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
                    child:
                        Text('Logout', style: TextStyle(color: Colors.black))),
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
                    child: Text('Student Dashboard',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        )),
                  )),
            ]),
            Column(children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueGrey, width: 4.0),
                        ),
                        child: RaisedButton(
                          onPressed: () async {
                            final url =
                                'https://www.unco.edu/tutoring/#tutortrac';
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceSafariVC: false,
                              );
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text('Appointments',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Icon(
                                  Icons.event,
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
                          border:
                              Border.all(color: Colors.blueGrey, width: 4.0),
                        ),
                        child: RaisedButton(
                          onPressed: () async {
                            final url =
                                'https://www.unco.edu/tutoring/course-offerings/individual-tutoring-courses.aspx';
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceSafariVC: false,
                              );
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text('Tutor Availability',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Icon(
                                  Icons.emoji_people,
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
                margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueGrey, width: 4.0),
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
                          border:
                              Border.all(color: Colors.blueGrey, width: 4.0),
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
