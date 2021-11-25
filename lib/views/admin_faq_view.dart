import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AdminFAQView extends StatefulWidget {
  const AdminFAQView({Key? key}) : super(key: key);


  @override
  State<AdminFAQView> createState() => _AdminFAQViewState();
}

class _AdminFAQViewState extends State<AdminFAQView> {

  late List<List<dynamic>> faqData;

  List<PlatformFile>? _paths;
  final String? _extension="csv";
  final FileType _pickingType = FileType.custom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    faqData  = List<List<dynamic>>.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){},
        ),
        title: const Text('Manage FAQ'),
        backgroundColor: const Color(0xff173f5f),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FAQListStatefulWidget()
              ),
            ),
            ButtonBar (
              alignment: MainAxisAlignment.center,
              children: <Widget> [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff173f5f), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: getCsv,
                  child: const Text('Download FAQ .csv file'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff173f5f), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: _openFileExplorer,
                  child: const Text('Upload FAQ .csv file'),
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  openFile(filepath) async
  {
    File f = File(filepath);
    final input = f.openRead();
    final fields = await input.transform(utf8.decoder).transform(const CsvToListConverter()).toList();
    setState(() {
      faqData=fields;
    });
  }

  void _openFileExplorer() async {
    _paths = (await FilePicker.platform.pickFiles(
      type: _pickingType,
      allowMultiple: false,
      allowedExtensions: (_extension?.isNotEmpty ?? false)
          ? _extension?.replaceAll(' ', '').split(',')
          : null,
    ))
        ?.files;
    if (!mounted) return;
    setState(() {
      openFile(_paths![0].path);
    });
  }

  getCsv() async {

    var status = await Permission.storage.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.storage
          .request()
          .isGranted) {
//store file in documents folder

        String dir = (await getExternalStorageDirectory())!.absolute.path + "/documents";
        String file = "$dir";

        File f = new File(file+"faq.csv");

// convert rows to String and write as csv file

        String csv = const ListToCsvConverter().convert(faqData);
        f.writeAsString(csv);
      } else {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
        ].request();
      }
    }
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
  final List<Item> _data = generateItems(8);

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