```dart
import 'package:flutter/material.dart';
import 'package:mobile_app/lib/services/report.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportService _reportService = ReportService();
  List<ReportSchema> _reports = [];

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  void _loadReports() async {
    List<ReportSchema> reports = await _reportService.getReports();
    setState(() {
      _reports = reports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: ListView.builder(
        itemCount: _reports.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_reports[index].title),
            subtitle: Text('Generated on: ${_reports[index].dateGenerated}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportDetailScreen(report: _reports[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ReportDetailScreen extends StatelessWidget {
  final ReportSchema report;

  ReportDetailScreen({Key key, @required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(report.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(report.content),
      ),
    );
  }
}
```