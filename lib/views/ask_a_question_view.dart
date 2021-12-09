import 'dart:core';
import 'dart:io' as IO;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/models/offered_class.dart';
import 'package:smart_bear_tutor/models/question_model.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/widgets/blue_call_to_action.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as Path;

class AskAQuestionView extends StatefulWidget {
  const AskAQuestionView({Key? key}) : super(key: key);

  @override
  _AskAQuestionViewState createState() => _AskAQuestionViewState();
}

class _AskAQuestionViewState extends State<AskAQuestionView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  // Dictionary of offered classes and their codes
  final Map<String, List<int>> _offeredClassesMap = {};
  // Lists to fill out the dropdown buttons
  final List<String> _offeredSubjects = [];
  late List<int> _offeredCodes = [];
  // Chosen Data for Class Code
  late String _selectedSubject = ''; // ie. MATH, CS, BACS, ect
  late int _selectedCode = 0; // ie. 101, 350, ect
  final _picker = ImagePicker();
  IO.File? _imageFile = null;
  String _filePath = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _gatherOfferedClasses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _askAQuestionViewWidget();
        }
        return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Future<void> _gatherOfferedClasses() async {
    if (_offeredSubjects.isEmpty) {
      List<OfferedClass>? _offeredClasses = await getOfferedClasses();
      // Create List of class subjects
      if (_offeredClasses != null && _offeredClasses.isNotEmpty) {
        _offeredSubjects.add(''); // Initialize the list with an empty value
        for (OfferedClass _class in _offeredClasses) {
          // Create the dictionary of class subjects and codes
          if (_offeredClassesMap.containsKey(_class.subject)) {
            _offeredClassesMap[_class.subject]!.add(_class.classCode);
          } else {
            _offeredSubjects.add(_class.subject);
            _offeredClassesMap[_class.subject] = [_class.classCode];
          }
        }
      }
    }
  }

  void _dynamicClassCodeDropDown(String subject) {
    _offeredCodes.removeRange(0, _offeredCodes.length);
    final _subjectCodes = _offeredClassesMap[subject] as List<int>;
    _subjectCodes.add(0);
    _subjectCodes.sort();
    setState(() {
      _offeredCodes = _subjectCodes;
    });
  }

  Widget _askAQuestionViewWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(context, 'Ask A Question', true, true),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Dropdown for Class Subjects
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: SizedBox(
                            width: 170.0,
                            child: DropdownButtonFormField<String>(
                                value: _selectedSubject,
                                items: _offeredSubjects.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCode = 0;
                                    _selectedSubject = value!;
                                    _dynamicClassCodeDropDown(value);
                                  });
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Class Subject',
                                    hintText:
                                        'Enter your class subject (ie MATH)')),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: SizedBox(
                            width: 170.0,
                            child: DropdownButtonFormField<int>(
                                value: _selectedCode,
                                items: _offeredCodes.map((int value) {
                                  return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString()));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCode = value!;
                                  });
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Class Code',
                                    hintText:
                                        'Enter your class code (ie 101)')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: TextFormField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Subject',
                          hintText: 'Enter question subject'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a subject for your question';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 15.0),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text('Enter your question below:'))),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 10.0),
                    child: TextFormField(
                      // TODO: add char limit
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 5,
                      controller: _questionController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Question',
                          hintText: 'Enter your Question Here'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Your Question Can\'t be Empty';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
            ),
            _showAttachedImage(),
            Padding(
                padding: const EdgeInsets.only(bottom: 10.0, left: 15.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Attach File (optional)'))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                    color: const Color(0xff173f5f),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.camera_alt_outlined),
                        iconSize: 45.0,
                        color: Colors.white,
                        tooltip: 'Use Camera',
                        onPressed: () async {
                          // TODO: allow user to take a picture
                          await _pickImageCamera();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.image),
                        iconSize: 45.0,
                        color: Colors.white,
                        tooltip: 'Choose From Gallery',
                        onPressed: () async {
                          // TODO: allow user to choose a picture from their gallery
                          await _pickImageGallery();
                        },
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: blueCallToAction('Submit', _submitNewQuestion),
            )
          ],
        ),
      ),
    );
  }

  Widget _showAttachedImage() {
    if (_imageFile != null) {
      return Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: Image.file(
            _imageFile!,
            width: 150,
            height: 150,
          ));
    }
    return Container();
  }

  void _showAlreadyAskedAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("You've already asked a question for this class."),
      content: const Text(
          "Please make an appointment with UNC Tutoring Services to get further help."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showSuccessfulAlertDialog() {
    // set up the button
    Widget thanksButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        moveToUserDashboardReplacement(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Question Successfully Sent!'),
      content: RichText(
        text: TextSpan(children: [
          TextSpan(
              text:
                  'We encourage you to please schedule an appointment at your earliest convenience for further tutoring assistance! We are located in the lower level of Michener Library. Please access our website ',
              style: TextStyle(color: Colors.black)),
          TextSpan(
              text:
                  'Tutorial Services - University of Northern Colorado (unco.edu)',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
              recognizer: new TapGestureRecognizer()
                ..onTap = () => _moveToTutorialServicesSite())
        ]),
      ),
      actions: [
        thanksButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _moveToTutorialServicesSite() async {
    final url = 'https://www.unco.edu/tutoring/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void _submitNewQuestion() async {
    if (_formKey.currentState!.validate()) {
      await _uploadImageToFirebase(context);
      final _class = _selectedSubject + _selectedCode.toString();
      final _userId = currentUserUid();
      if (await checkUserQuestions(_userId!, _class)) {
        _showAlreadyAskedAlertDialog();
        return;
      }
      Question _newQuestion = Question(
          authorId: _userId,
          classCode: _class,
          questionDate: DateTime.now(),
          subject: _subjectController.text,
          body: _questionController.text,
          imagePath: _filePath);
      await submitQuestion(_newQuestion);
      _showSuccessfulAlertDialog();
    }
  }

  Future<void> _pickImageCamera() async {
    final _pickedImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = IO.File(_pickedImage!.path);
    });
  }

  Future<void> _pickImageGallery() async {
    final _pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = IO.File(_pickedImage!.path);
    });
  }

  Future _uploadImageToFirebase(BuildContext context) async {
    if (_imageFile != null) {
      String fileName = Path.basename(_imageFile!.path);
      final firebaseStorageRef =
          FirebaseStorage.instance.ref().child('questionUploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
      setState(() {
        _filePath = 'questionUploads/${Path.basename(_imageFile!.path)}';
      });
    }
    return;
  }
}
