import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:smart_bear_tutor/login_view.dart';

class DashboardStudentPage extends StatefulWidget {
  const DashboardStudentPage({Key? key}) : super(key: key);

  @override
  _DashboardStudentPageState createState() => _DashboardStudentPageState();
}


class _DashboardStudentPageState extends State<DashboardStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          children: <Widget>[

            Column(
                children: <Widget>[
                  AppBar(
                      toolbarHeight: 30,
                      title: Text(
                          'Want to become a tutor',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          )), // ToDo:Pull users name.
                      backgroundColor: Colors.amber,
                      actions: <Widget>[
                        InkWell(
                            child: Text(
                                'Click Here',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                )),
                            onTap: () => launch('https://www.unco.edu/tutoring/resources-forms/become-a-peer-tutor-or-si-leader.aspx')
                        ),
                      ]),
                ]),

            Row(
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
                    margin: EdgeInsets.fromLTRB(20.0, 10.0, 30.0, 10.0),
                    width: 250, //Pushes text to another line with a width limit
                    child: Text(
                        'Welcome                                     Add Users Full Name',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ]),

            Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Divider(
                        color: Colors.black
                    ),
                  ),
                ]),

            Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            )),
                      )),
                ]),

            Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey, width: 4.0),
                            ),
                            child: RaisedButton.icon(
                              onPressed: () async {
                                final url = 'https://www.unco.edu/tutoring/#tutortrac';
                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false,);
                                }
                                else{
                                  throw 'Could not launch $url'; // ToDo:Pull error message popup in app instead of console.
                                }
                              },
                              label: Text('Appointments'), // ToDo: Place text above icon
                              icon: Icon(
                                Icons.event,
                                size: 50.0,
                              ),
                              color: Colors.lightBlue[100],
                            ),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey, width: 4.0),
                            ),
                            child: RaisedButton.icon(
                              onPressed: () async {
                                final url = 'https://github.com/flutter/gallery/';
                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false,);
                                }
                                else{
                                  throw 'Could not launch $url'; // ToDo:Pull error message popup in app instead of console.
                                }
                              },
                              icon: Icon(
                                Icons.emoji_people,
                                size: 50.0,
                              ),
                              label: Text('Tutor Availability'),
                              color: Colors.lightBlue[100],
                            ),
                          ),
                        ]),
                  ),
                ]),

            Column(
                children: <Widget>[
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
                            child: RaisedButton.icon(
                              onPressed: () async {
                                final url = 'https://github.com/flutter/gallery/';
                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false,);
                                }
                                else{
                                  throw 'Could not launch $url'; // ToDo:Pull error message popup in app instead of console.
                                }
                              },
                              icon: Icon(
                                Icons.help,
                                size: 50.0,
                              ),
                              label: Text('Ask A Question'),
                              color: Colors.lightBlue[100],
                            ),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey, width: 4.0),
                            ),
                            child: RaisedButton.icon(
                              onPressed: () async {
                                final url = 'https://github.com/flutter/gallery/';
                                if (await canLaunch(url)) {
                                  await launch(url, forceSafariVC: false,);
                                }
                                else{
                                  throw 'Could not launch $url'; // ToDo:Pull error message popup in app instead of console.
                                }
                              },
                              icon: Icon(
                                Icons.mail,
                                size: 50.0,
                              ),
                              label: Text('FAQ'),
                              color: Colors.lightBlue[100],
                            ),
                          ),
                        ]),
                  ),
                ]),

            Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Divider(
                        color: Colors.black
                    ),
                  ),
                ]),

            Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 4.0),
                    ),
                    child: RaisedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      icon: Icon(
                        Icons.settings,
                        size: 50.0,
                      ),
                      label: Text('Settings'),
                      color: Colors.lightBlue[100],
                    ),
                  ),
                ]),

          ],
        )
    );
  }
}


