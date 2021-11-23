import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/views/tutor_create_message.dart';


class TutorQuestionListView extends StatefulWidget {
  const TutorQuestionListView({Key? key}) : super(key: key);

  @override
  _TutorQuestionListViewState createState() =>
      _TutorQuestionListViewState();
}

class _TutorQuestionListViewState
    extends State<TutorQuestionListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
        body: ListView(
          children: <Widget>[
          Container(
            child: Text(
              'Questions',
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
                  horizontal: 0, vertical: 0),
              height: 0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TutorCreateMessageView()),
                  );
                },

                child: Text('Insert Class: \nInsert student question preview',
                  textAlign: TextAlign.left),
              ),
            )


        ]
      ),
    );
  }
}
AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    shadowColor: Colors.white,
    elevation: 0,
    title:
    ElevatedButton.icon(
      onPressed: () {
        //TODO: go back to whichever page is before this
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
