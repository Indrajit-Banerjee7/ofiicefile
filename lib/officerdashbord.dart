import 'package:flutter/material.dart';

import 'filedetailsscreen.dart';


class OfficerDashboard extends StatelessWidget {
  final List<Map<String, String>> files = [
    {"title": "Budget Approval", "status": "Pending"},
    {"title": "New Project Proposal", "status": "Pending"},
    {"title": "Policy Revision", "status": "Approved"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Officer Dashboard')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: files.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(files[index]['title']!, style: TextStyle(fontSize: 18)),
              subtitle: Text("Status: ${files[index]['status']}"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => FileDetailsScreen(fileTitle: files[index]['title']!, pdfPath: '',),
                //   ),
                // );
                Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => FileDetailsScreen(
      fileTitle: "Sample PDF",
      assetPdfPath: "assets/flowchart.pdf", // The asset file path
    ),
  ),
);
              },
            ),
          );
        },
      ),
    );
  }
}

