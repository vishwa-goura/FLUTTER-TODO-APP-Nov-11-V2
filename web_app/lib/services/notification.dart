```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  final String apiUrl = "http://localhost:8000/api/notifications";

  Future<List> getNotifications() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> createNotification(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create notification');
    }
  }

  Future<void> updateNotification(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update notification');
    }
  }

  Future<void> deleteNotification(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete notification');
    }
  }
}
```