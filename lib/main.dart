import 'package:flutter/material.dart';
import 'package:ofiicefile/createissuescreen.dart';

import 'alearscreen.dart';
import 'officerdashbord.dart';

void main() {
  runApp(TaskTrackingApp());
}

class TaskTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Officer Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: AlertsScreen(),
      home: CreateIssueScreen(),
      //home: OfficerDashboard(),
    );
  }
}

