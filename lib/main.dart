import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/sign_in_screen.dart';
import 'pages/forgot_password.dart';

void main() {
  // Aktifkan PathUrlStrategy untuk URL tanpa hash
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flicknext',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/sign-in': (context) => SignInScreen(),
        '/forgot-password': (context) => ForgotPasswordPage(),
      },
    );
  }
}
