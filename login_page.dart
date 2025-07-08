import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C75D3), // สีพื้นหลังสีน้ำเงิน
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // หัวข้อ LOGIN
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

              // ช่องกรอก Username
              TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
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

              // ช่องกรอก Password
              TextField(
                obscureText: true, // ทำให้เป็น text รหัสผ่าน (แสดงเป็นจุด)
                decoration: InputDecoration(
                  hintText: 'Password',
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

              // ปุ่ม LOG IN
              ElevatedButton(
                onPressed: () {
                  // เมื่อกดปุ่มจะไปยังหน้า To-Do List
                  Navigator.pushReplacementNamed(
                      context, '/todolist'); // เปลี่ยนจาก '/contacts'
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
