import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _success;
  late String _userEmail;
  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Column(children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 100),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'Enter a valid email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'Enter a secure password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        )),
                    CheckboxListTile(
                      title: const Text('Admin?'),
                      value: _isAdmin,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAdmin = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    Center(
                        child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _register();
                                }
                              },
                              child: const Text('Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25)),
                            )))
                  ])),
          const SizedBox(height: 25),
          TextButton(
              onPressed: () {
                moveToLoginViewReplacement(context);
              },
              child: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: 'Already a User? ',
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: 'Login.',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold))
              ])))
        ]));
  }

  void _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email!;
      });
      _createUserDocument(user, _emailController.text, _isAdmin, user.uid);
      moveToTempDashboard(context);
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  Future<void> _createUserDocument(
      User user, String email, bool isAdmin, String id) async {
    FirebaseFirestore.instance
        .collection('User')
        .doc(user.uid)
        .set({'email': email, 'admin': isAdmin, 'id': id});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
