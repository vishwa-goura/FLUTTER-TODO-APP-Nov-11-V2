```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_app/models/report.dart';

class ReportService {
  final String apiUrl = "http://localhost:8000/api/reports";

  Future<List<Report>> getReports() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Report> reports = body.map((dynamic item) => Report.fromJson(item)).toList();
      return reports;
    } else {
      throw Exception("Failed to load reports");
    }
  }

  Future<Report> getReport(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return Report.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load report');
    }
  }

  Future<Report> createReport(Report report) async {
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': report.title,
        'description': report.description,
        'userId': report.userId.toString(),
      }),
    );

    if (response.statusCode == 201) {
      return Report.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create report');
    }
  }

  Future<Report> updateReport(Report report) async {
    final http.Response response = await http.put(
      Uri.parse('$apiUrl/${report.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': report.title,
        'description': report.description,
        'userId': report.userId.toString(),
      }),
    );

    if (response.statusCode == 200) {
      return Report.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update report');
    }
  }

  Future<void> deleteReport(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('$apiUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete report');
    }
  }
}
```