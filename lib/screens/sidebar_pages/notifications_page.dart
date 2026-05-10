import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(Icons.notifications, color: Colors.white),
            ),
            title: Text('Notification #$index'),
            subtitle: const Text('This is a sample notification message.'),
            trailing: const Text('2h ago'),
          );
        },
      ),
    );
  }
}
