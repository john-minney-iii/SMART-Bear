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
  final String _student = 'Student';
  final String _admin = 'Admin';
  final String _tutor = 'Tutor';
  String _role = 'Student'; // Default to student

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(context, 'Register', true, false),
      body: Column(
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
                      return null;
                    },
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ListTile(
                          title: Text(_student),
                          leading: Radio(
                              value: _student,
                              groupValue: _role,
                              onChanged: (value) {
                                setState(() {
                                  _role = value.toString();
                                });
                              },
                              activeColor: Colors.blue)),
                      ListTile(
                          title: Text(_tutor),
                          leading: Radio(
                              value: _tutor,
                              groupValue: _role,
                              onChanged: (value) {
                                setState(() {
                                  _role = value.toString();
                                });
                              },
                              activeColor: Colors.blue)),
                      ListTile(
                          title: Text(_admin),
                          leading: Radio(
                              value: _admin,
                              groupValue: _role,
                              onChanged: (value) {
                                setState(() {
                                  _role = value.toString();
                                });
                              },
                              activeColor: Colors.blue))
                    ],
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
    );
  }

  void _register() async {
    final User? user = (await getCurrentAuth().createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;
    if (user != null) {
      setState(() {});
      createUser(user, _role);
      if (_role == _student || _role == _tutor) {
        moveToStudentDashboardReplacement(context);
      } else if (_role == _admin) {
        moveToAdminDashboardReplacement(context);
      }
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
