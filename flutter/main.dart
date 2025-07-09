import 'package:flutter/material.dart';
import 'todolist_page.dart'; // นำเข้า todolist_page โดยตรง

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
      home: const TodoListPage(), //  TodoListPage
      debugShowCheckedModeBanner: false,
    );
  }
}
