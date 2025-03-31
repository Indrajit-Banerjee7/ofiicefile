import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  // Sample data for alerts, reminders, and system messages.
  final List<AlertItem> alerts = [
    AlertItem(
      title: "Reminder",
      message: "Task 'Submit Report' is due in 2 hours.",
      icon: Icons.alarm,
      time: "10:30 AM",
    ),
    AlertItem(
      title: "System Message",
      message: "New update available. Please restart the app.",
      icon: Icons.system_update,
      time: "09:00 AM",
    ),
    AlertItem(
      title: "Alert",
      message: "Task 'Review Document' has been rejected.",
      icon: Icons.warning,
      time: "Yesterday",
    ),
  ];

  AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alerts & Reminders"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(alert.icon, color: Colors.blue, size: 32),
              title: Text(
                alert.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(alert.message),
              trailing: Text(alert.time, style: const TextStyle(fontSize: 12)),
            ),
          );
        },
      ),
    );
  }
}

class AlertItem {
  final String title;
  final String message;
  final IconData icon;
  final String time;

  AlertItem({
    required this.title,
    required this.message,
    required this.icon,
    required this.time,
  });
}
