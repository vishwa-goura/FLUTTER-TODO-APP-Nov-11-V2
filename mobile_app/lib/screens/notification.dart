```dart
import 'package:flutter/material.dart';
import 'package:mobile_app/lib/services/notification.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Notification Title'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _notificationService.title = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Notification Body'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a body';
                }
                return null;
              },
              onSaved: (value) {
                _notificationService.body = value;
              },
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  _notificationService.sendNotification();
                }
              },
              child: Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
```