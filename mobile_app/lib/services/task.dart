```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app/models/task.dart';

class TaskService {
  final String apiUrl = "http://localhost:8000/api/tasks";

  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Task> tasks = body.map((dynamic item) => Task.fromJson(item)).toList();
      return tasks;
    } else {
      throw Exception("Failed to load tasks");
    }
  }

  Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task),
    );
    if (response.statusCode == 201) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create task");
    }
  }

  Future<Task> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${task.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task),
    );
    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update task");
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete task");
    }
  }
}
```