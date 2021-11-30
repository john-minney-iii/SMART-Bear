// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:smart_bear_tutor/login_view.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const SmartBearApp());
// }
//
// class SmartBearApp extends StatelessWidget {
//   const SmartBearApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         // Initialize FlutterFire
//         future: Firebase.initializeApp(),
//         builder: (context, snapshot) {
//           // Check for Errors
//           if (snapshot.hasError) {
//             // TODO: Add Error Screen
//           }
//
//           // Once complete, show the application
//           if (snapshot.connectionState == ConnectionState.done) {
//             return const MaterialApp(
//                 debugShowCheckedModeBanner: true, home: LoginView());
//           }
//           // Show a Default Loading Spinner
//           return const Center(child: CircularProgressIndicator());
//         });
//   }
// }
