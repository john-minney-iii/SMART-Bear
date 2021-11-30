import 'package:flutter/material.dart';

class PushNotificationOptionsView extends StatefulWidget {
  const PushNotificationOptionsView({Key? key}) : super(key: key);

  @override
  _PushNotificationOptionsViewState createState() =>
      _PushNotificationOptionsViewState();
}

class _PushNotificationOptionsViewState
    extends State<PushNotificationOptionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                  child: Image(
                image: AssetImage('assets/unco-bear-letter-logo.png'),
                width: 250,
                height: 250,
              ))),
          Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: <Widget>[
                  const Center(
                    child: Text('Would you like to receive a push',
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  const Center(
                    child: Text('notifications for job alerts and',
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  const Center(
                    child: Text('upcoming events?',
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // TODO: Turn on Notifications for User
                              },
                              child: const Text('Yes',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            )),
                        const SizedBox(width: 25.0),
                        Container(
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // TODO: Turn off Notifications for User
                              },
                              child: const Text('No',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ))
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
