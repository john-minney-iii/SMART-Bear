import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

class StudentFAQView extends StatefulWidget {
  const StudentFAQView({Key? key}) : super(key: key);


  @override
  State<StudentFAQView> createState() => _StudentFAQViewState();
}

class _StudentFAQViewState extends State<StudentFAQView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            moveToStudentDashboardReplacement(context);
          },
        ),
        title: const Text('FAQ'),
        backgroundColor: const Color(0xff173f5f),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FAQListStatefulWidget()
              ),
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
  final List<Item> _data = generateItems(20);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      dividerColor: const Color(0xff173f5f),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
              const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Question $index title',
      expandedValue: 'This is item number $index',
    );
  });
}