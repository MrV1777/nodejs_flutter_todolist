import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C75D3), // Set background color (blue)
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Title: LOGIN
              const Text(
                'LOGIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 48.0),

              // Username TextField
              TextField(
                decoration: InputDecoration(
                  hintText: 'Username', // Placeholder text
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                ),
              ),
              const SizedBox(height: 16.0),

              // Password TextField (obscure text for security)
              TextField(
                obscureText: true, // Hide input characters
                decoration: InputDecoration(
                  hintText: 'Password', // Placeholder text
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                ),
              ),
              const SizedBox(height: 32.0),

              // LOG IN Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the To-Do List page when pressed
                  Navigator.pushReplacementNamed(context, '/todolist');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E59A8),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'LOG IN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
