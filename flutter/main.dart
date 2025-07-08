import 'package:flutter/material.dart';
import 'login_page.dart';
import 'todolist_page.dart'; // เปลี่ยนจาก contacts_page.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/todolist': (context) => const TodoListPage(), // เปลี่ยน route
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
