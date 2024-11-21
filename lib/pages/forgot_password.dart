import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Background header hitam
        title: Text(
          "Lupa Password",
          style: TextStyle(color: Colors.white), // Teks putih
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Ikon panah putih
          onPressed: () {
            // Navigasi ke halaman Sign In
            Navigator.popAndPushNamed(context, '/sign-in');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tambahkan logo di atas tulisan
              Image.asset(
                'assets/images/logo.png',
                height: 100, // Sesuaikan ukuran logo
                width: 100,
              ),
              SizedBox(height: 20), // Jarak antara logo dan teks
              Text(
                "Lupa Password?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Warna teks hitam
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Masukkan email yang kamu gunakan ketika mendaftar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700], // Warna teks deskripsi tetap abu-abu
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Masukkan emailmu di sini',
                  labelStyle:
                      TextStyle(color: Colors.black), // Warna label hitam
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 2), // Border hitam saat fokus
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Warna tombol hitam
                  foregroundColor: Colors.white, // Warna teks tombol putih
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  // Logika pengiriman link reset password
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Link reset password telah dikirim!'),
                  ));
                },
                child: Text('Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
