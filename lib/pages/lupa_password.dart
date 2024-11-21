import 'package:flutter/material.dart';

class LupaPasswordPage extends StatefulWidget {
  @override
  _LupaPasswordPageState createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  final _emailController = TextEditingController();
  final _allowedEmail = "rendy@jogja.co.id"; // Email spesifik yang diizinkan
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.black, // Warna latar belakang hitam
        titleTextStyle: TextStyle(
          color: Colors.white, // Warna teks putih
          fontSize: 20, // Ukuran font teks
          fontWeight: FontWeight.bold, // Menebalkan teks
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your email to reset your password",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                errorText: _errorMessage, // Tampilkan pesan error jika ada
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validasi email
                if (_emailController.text == _allowedEmail) {
                  // Tampilkan pesan sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Password reset link has been sent to your email."),
                    ),
                  );
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  // Tampilkan error jika email tidak cocok
                  setState(() {
                    _errorMessage = "Email is not valid or not registered.";
                  });
                }
              },
              child: Text('Send Reset Link'),
            ),
            TextButton(
              onPressed: () {
                // Kembali ke halaman login
                Navigator.pushReplacementNamed(context, '/sign-in');
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
