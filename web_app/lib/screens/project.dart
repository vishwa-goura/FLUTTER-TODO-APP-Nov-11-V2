```dart
import 'package:flutter/material.dart';
import 'package:web_app/services/project.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final ProjectService _projectService = ProjectService();
  List<ProjectSchema> _projects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  void _loadProjects() async {
    List<ProjectSchema> projects = await _projectService.getProjects();
    setState(() {
      _projects = projects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_projects[index].name),
            subtitle: Text(_projects[index].description),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _projectService.deleteProject(_projects[index].id);
                _loadProjects();
              },
            ),
            onTap: () {
              Navigator.pushNamed(context, '/projectDetail', arguments: _projects[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/createProject').then((_) => _loadProjects());
        },
      ),
    );
  }
}
```