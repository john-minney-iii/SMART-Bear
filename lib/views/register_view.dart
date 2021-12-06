import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/firebase_api.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/widgets/blue_call_to_action.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final String _student = 'Student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(context, 'Register', true, false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 100),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter a valid email'),
                        validator: (value) {
                          // TODO: add email validation
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter a secure password'),
                      obscureText: true,
                      validator: (value) {
                        // TODO: password and password conf, password validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value != _passwordConfirmationController.text) {
                          return 'Please make sure your passwords match';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
                    child: TextFormField(
                      controller: _passwordConfirmationController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Re-Enter Password',
                          hintText: 'Re-Enter Password to Confirm'),
                      obscureText: true,
                      validator: (value) {
                        // TODO: password and password conf, password validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password again';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50.0),
            Center(child: blueCallToAction('Register', _register)),
            const SizedBox(height: 50.0),
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
          ],
        ),
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final User? user = (await getCurrentAuth().createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text))
          .user;
      if (user != null) {
        setState(() {});
        createUser(user, _student);
        _showRegisterAlertDialog();
      } else {
        setState(() {});
      }
    }
  }

  void _showRegisterAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        moveToStudentDashboardReplacement(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("You have been registered!"),
      content: const Text(
          "You have been registered as a student. If you are a tutor or a staff member, speak with an admin and they will be able to upgrade your role."),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
