```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_app/models/Project.dart';

class ProjectService {
  final String apiUrl = "http://localhost:8000/api/projects";

  Future<List<Project>> getProjects() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((project) => new Project.fromJson(project)).toList();
    } else {
      throw Exception('Failed to load projects from API');
    }
  }

  Future<void> createProject(Project project) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(project));

    if (response.statusCode != 201) {
      throw Exception('Failed to create project');
    }
  }

  Future<void> updateProject(String id, Project project) async {
    final response = await http.put(Uri.parse('$apiUrl/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(project));

    if (response.statusCode != 200) {
      throw Exception('Failed to update project');
    }
  }

  Future<void> deleteProject(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete project');
    }
  }
}
```