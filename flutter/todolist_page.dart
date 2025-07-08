import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoItem {
  int? id;
  String title;
  bool isDone;

  TodoItem({this.id, required this.title, this.isDone = false});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      title: json['title'],
      isDone: json['is_done'] == 1 || json['is_done'] == true,
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoItem> _todos = [];
  final TextEditingController _textFieldController = TextEditingController();

  final String baseUrl =
      'http://localhost:3000/tasks'; // ใช้กับ Android Emulator

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _todos.clear();
          _todos.addAll(data.map((json) => TodoItem.fromJson(json)));
        });
      } else {
        print('Error fetching todos: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception fetching todos: $e');
    }
  }

  Future<void> _deleteTodo(int id) async {
    try {
      final url = Uri.parse('$baseUrl/$id');
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        await _fetchTodos(); // โหลดรายการใหม่หลังลบ
      } else {
        print('Error deleting todo: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception deleting todo: $e');
    }
  }

  // ฟังก์ชันเพิ่ม ToDo ผ่าน POST API
  Future<void> _addTodo(String title) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"title": title}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await _fetchTodos(); // โหลดรายการใหม่หลังเพิ่ม
      } else {
        print('Error adding todo: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception adding todo: $e');
    }
  }

// แสดง dialog ใส่ task ใหม่
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new task'),
          content: TextField(
            controller: _textFieldController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter task here...'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                _textFieldController.clear();
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('ADD'),
              onPressed: () async {
                final text = _textFieldController.text;
                if (text.isNotEmpty) {
                  Navigator.pop(context);
                  await _addTodo(text);
                  _textFieldController.clear();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'To-Do List',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton.icon(
                    onPressed: _showAddTaskDialog,
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Add Task',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];
                      return ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: null, // จะเพิ่ม API update ทีหลังได้
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: todo.isDone ? Colors.grey : Colors.black87,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
                          onPressed: () {
                            _deleteTodo(todo.id!);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
