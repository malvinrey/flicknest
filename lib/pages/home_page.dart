import 'package:flutter/material.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Using a custom header instead of the default AppBar
      body: Column(
        children: [
          Header(), // Custom Header (remove this line if not needed)
          Expanded(
            child: Center(
              child: Text(
                'Welcome to the Home Page!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Footer(), // Custom Footer
        ],
      ),
    );
  }
}
