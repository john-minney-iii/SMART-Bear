import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/views/tutor_question_list.dart';

class TutorCreateMessageView extends StatefulWidget {
  const TutorCreateMessageView({Key? key}) : super(key: key);

  @override
  _TutorCreateMessageViewState createState() =>
      _TutorCreateMessageViewState();
}

class _TutorCreateMessageViewState
    extends State<TutorCreateMessageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          children: <Widget>[
            Container(
                child: Text(
                  'Student Question',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 0, vertical: 0),
              height: 0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 25),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                color: Colors.black,
                ),
              ),
                child: Text(
                  'Insert student question here',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 0,
                ),

                ElevatedButton.icon(
                  onPressed: () {

                  },

                  icon: Icon(Icons.camera_alt),
                  label: Text('Camera'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      elevation: 1.0,

                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)
                      ),

                ),
                ElevatedButton.icon(
                  onPressed: () {
                    //Todo: Add function
                  },

                  icon: Icon(Icons.panorama_outlined ),
                  label: Text('Gallery'),
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.bottomLeft,
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      elevation: 1.0,

                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)
                  ),

                ),
                ElevatedButton.icon(
                  onPressed: () {
                    //ToDo: Add function
                  },

                  icon: Icon(Icons.add_comment_outlined ),
                  label: Text('Textbox'),
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.bottomLeft,
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      elevation: 1.0,

                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)
                  ),

                ),

              ]
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Message',
              ),
            ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 90, vertical: 45),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    sure(context);
                  },

                  icon: Icon(Icons.send),
                  label: Text('Send'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      elevation: 1.0,
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)
                  ),
                ),
              ]
          )
        ]
      ),

    );
  }
  void sure(BuildContext context)
  {
    var alertDialog = AlertDialog(
      content: Text("Please make sure all parts of the question have been answered. You will not be able to reply to the student again."),
      actions: <Widget>[
        RaisedButton(
          color: Colors.red, // background
          textColor: Colors.black, // foreground
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Back'),
        ),
        RaisedButton(
          color: Colors.blue, // background
          textColor: Colors.white, // foreground
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Send'),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      }
    );
  }
  }

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    title:
    ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TutorQuestionListView()),
        );
      },

      icon: Icon(
          Icons.arrow_back,
          color: Colors.black),
      label: Text(''),
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          elevation: 0,

          textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold)
      ),

    ),
    backgroundColor: Colors.white,
    actions: [
      Image(
        image: AssetImage('assets/unco-bear-letter-logo.png'),
      ),
    ],

  );
}

