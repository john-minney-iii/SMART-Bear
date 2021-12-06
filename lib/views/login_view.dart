import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/api/user_auth.dart';
import 'package:smart_bear_tutor/routes/routes.dart';
import 'package:smart_bear_tutor/widgets/blue_call_to_action.dart';
import 'package:smart_bear_tutor/widgets/global_app_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loginFail = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _checkUserLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: globalAppBar(context, 'Login', false, false),
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 60.0),
                        Image.asset(
                          'assets/unco-bear-logo.png',
                          height: 125.0,
                          width: 125.0,
                        ),
                        const Text('SMART BEAR App',
                            style:
                                TextStyle(color: Colors.black, fontSize: 24.0)),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Text(
                                  'Invalid Email or Password. Please try again.',
                                  style: TextStyle(
                                      color: (_loginFail)
                                          ? Colors.red
                                          : Colors.white)),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Email',
                                      hintText: 'Enter a valid email'),
                                  validator: (value) {
                                    // TODO: email validation
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      hintText: 'Enter a secure password'),
                                  obscureText: true,
                                  validator: (value) {
                                    // TODO: password validation
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        blueCallToAction('Login', _login),
                        const SizedBox(height: 50.0),
                        TextButton(
                          onPressed: () {
                            moveToRegisterView(context);
                          },
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: 'New User? ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: 'Create new Account.',
                                style: TextStyle(
                                    color: const Color(0xff173f5f),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold))
                          ])),
                        )
                      ],
                    ),
                  ),
                ));
          }
          return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()));
        });
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      bool _loginResponse = await signInWithEmailAndPassword(
          context, _emailController.text, _passwordController.text);
      if (!_loginResponse) {
        setState(() {
          _loginFail = true;
        });
      }
    }
  }

  Future<void> _checkUserLogin() async {
    if (isUserAuth()) {
      moveToUserDashboardReplacement(context);
    }
  }
}
