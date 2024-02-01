import 'package:dscc_project/TextRecognition.dart';
import 'package:dscc_project/pages/AddStudent.dart';
import 'package:dscc_project/pages/DataTable.dart';
import 'package:dscc_project/pages/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dscc_project/pages/LoginPage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(
              30,
              88,
              241,
              1,
            )),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/display': (context) => DisplayAllScreen(),
        '/scan': (context) => const TextRecognitionPage(),
        '/addStudent': (context) => AddStudentPage(),
      },
    );
  }
}
