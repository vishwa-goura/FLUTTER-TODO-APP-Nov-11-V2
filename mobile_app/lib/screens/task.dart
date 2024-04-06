```dart
import 'package:flutter/material.dart';
import 'package:mobile_app/lib/services/task.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskService = TaskService();
  String _taskTitle;
  String _taskDescription;
  DateTime _taskDeadline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Task Title'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a task title';
                }
                return null;
              },
              onSaved: (value) {
                _taskTitle = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Task Description'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a task description';
                }
                return null;
              },
              onSaved: (value) {
                _taskDescription = value;
              },
            ),
            RaisedButton(
              child: Text('Select Deadline'),
              onPressed: () async {
                _taskDeadline = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
              },
            ),
            RaisedButton(
              child: Text('Create Task'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  _taskService.createTask(_taskTitle, _taskDescription, _taskDeadline);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
```