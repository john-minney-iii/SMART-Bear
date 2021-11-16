import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_bear_tutor/routes/routes.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _success;
  late String _userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Login'),
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              const Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Text('SMART Bear App',
                        style: TextStyle(color: Colors.black, fontSize: 24)),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter a valid email id as abc@domain.com'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a Valid Email';
                      }
                      return null;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 25.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Your Secure Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _signInWithEmailAndPassword();
                      }
                    },
                    child: const Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  )),
              const SizedBox(height: 50),
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
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold))
                ])),
              )
            ],
          ),
        ));
  }

  Future<void> _signInWithEmailAndPassword() async {
    // Log out the user just in case something weird happened.
    await _auth.signOut();
    final User? user = (await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email!;
      });
      // TODO: Move to dashboard view
      // Student goes to student
      // Admin goes to admin
      // Ect
      moveToTempDashboard(context);
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
