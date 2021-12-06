import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../message_view.dart';

class DashboardTutorPage extends StatefulWidget {
  const DashboardTutorPage({Key? key}) : super(key: key);

  @override
  _DashboardTutorPageState createState() => _DashboardTutorPageState();
}

class _DashboardTutorPageState extends State<DashboardTutorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: <Widget>[
        Column(children: <Widget>[]),
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
        Column(children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Divider(color: Colors.black),
          ),
        ]),
        Column(children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Dashboard',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
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
                      border: Border.all(color: Colors.blueGrey, width: 4.0),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessageScreen()),
                        );
                      },
                      label: Text('Messages'), // ToDo: Place text above icon
                      icon: Icon(
                        Icons.help,
                        size: 50.0,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 4.0),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final url = 'https://github.com/flutter/gallery/';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceSafariVC: false,
                          );
                        } else {
                          throw 'Could not launch $url'; // ToDo:Pull error message popup in app instead of console.
                        }
                      },
                      icon: Icon(
                        Icons.mail,
                        size: 50.0,
                      ),
                      label: Text('FAQ'),
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
      ],
    ));
  }
}
