```dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  final String notificationUrl = "http://localhost:8000/api/notifications";

  Future<List> getNotifications() async {
    final response = await http.get(Uri.parse(notificationUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> createNotification(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(notificationUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create a notification');
    }
  }

  Future<void> deleteNotification(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('$notificationUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete a notification');
    }
  }
}
```