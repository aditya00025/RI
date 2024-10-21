import 'package:flutter03/firebase_options.dart';
import 'package:flutter03/pages/login/login.dart';
import 'package:flutter03/pages/signup/signup.dart'; // Signup import
import 'package:flutter03/pages/forgot_password/forgot_password.dart'; // Forgot Password import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with your Firebase options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Add routing for easy navigation
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),  // Login Page
        '/signup': (context) => SignupPage(),  // Signup Page
        '/forgot_password': (context) => ForgotPasswordPage(),  // Forgot Password Page
      },
    );
  }
}
