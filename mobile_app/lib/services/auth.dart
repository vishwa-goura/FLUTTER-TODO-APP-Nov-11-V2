```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app/lib/models/user.dart';

class AuthService {
  final String apiUrl = "http://localhost:8000/api";

  Future<bool> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: {"Accept": "Application/json"},
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {"Accept": "Application/json"},
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<User> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/user'),
      headers: {"Accept": "Application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<bool> updateUserProfile(User user, String token) async {
    final response = await http.put(
      Uri.parse('$apiUrl/user'),
      headers: {"Accept": "Application/json", "Authorization": "Bearer $token"},
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
```