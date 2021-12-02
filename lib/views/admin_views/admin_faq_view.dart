import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminFAQView extends StatefulWidget {
  const AdminFAQView({Key? key}) : super(key: key);

  @override
  State<AdminFAQView> createState() => _AdminFAQViewState();
}

class _AdminFAQViewState extends State<AdminFAQView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            moveToAdminDashboardReplacement(context);
          },
        ),
        title: const Text('Manage FAQ'),
        backgroundColor: const Color(0xff173f5f),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10), child: FAQListStatefulWidget()),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class FAQListStatefulWidget extends StatefulWidget {
  const FAQListStatefulWidget({Key? key}) : super(key: key);

  @override
  State<FAQListStatefulWidget> createState() => _FAQListStatefulWidgetState();
}

/// This is the private State class that goes with FAQListStatefulWidget.
class _FAQListStatefulWidgetState extends State<FAQListStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: _buildPanel(context));
  }

  Widget _buildPanel(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('FAQ').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return const Text('Loading FAQ...');
          return ExpansionPanelList.radio(
            dividerColor: const Color(0xff173f5f),
            expandedHeaderPadding: const EdgeInsets.only(top: 16.0),
            children: snapshot.data.docs.map<ExpansionPanel>((document) {
              return ExpansionPanelRadio(
                value: document['QuestionNumber'],
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(document['Question']),
                  );
                },
                body: Container(
                  child: ListTile(
                    minVerticalPadding: 8,
                    title: Text(document['Answer']),
                  ),
                  decoration: const BoxDecoration(
                      border:
                          Border(top: BorderSide(color: Color(0xff173f5f)))),
                ),
              );
            }).toList(),
          );
        });
  }
}
