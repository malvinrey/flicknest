import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App with Multiple Pages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Halaman utama pertama
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/sign-in': (context) => SignInScreen(),

      },
    );
  }
}
