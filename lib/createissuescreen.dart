import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// class CreateIssueScreen extends StatefulWidget {
//   @override
//   _CreateIssueScreenState createState() => _CreateIssueScreenState();
// }

// class _CreateIssueScreenState extends State<CreateIssueScreen> {
//   File? selectedPdf;
//   List<String> assignedOfficers = [];
//   List<String> availableOfficers = ["Officer A", "Officer B", "Officer C", "Officer D"];
//   String? selectedOfficer;

//   /// Picks a PDF file from storage
//   Future<void> pickPdfFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       setState(() {
//         selectedPdf = File(result.files.single.path!);
//       });
//     }
//   }

//   /// Assigns an officer from the dropdown
//   void assignOfficer() {
//     if (selectedOfficer != null && !assignedOfficers.contains(selectedOfficer)) {
//       setState(() {
//         assignedOfficers.add(selectedOfficer!);
//         selectedOfficer = null;
//       });
//     }
//   }

//   /// Submits the issue
//   void submitIssue() {
//     if (selectedPdf == null || assignedOfficers.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please upload a PDF and assign at least one officer.")));
//       return;
//     }

//     // Perform the issue creation logic (API call, Firestore, etc.)
//     print("Issue Created!");
//     print("PDF: ${selectedPdf!.path}");
//     print("Assigned Officers: ${assignedOfficers.join(", ")}");

//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Issue Submitted Successfully!")));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Create Issue")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // PDF Upload Button
//             ElevatedButton.icon(
//               icon: Icon(Icons.upload_file),
//               label: Text("Upload PDF"),
//               onPressed: pickPdfFile,
//             ),

//             // Show selected PDF file
//             if (selectedPdf != null)
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 child: Text("Selected PDF: ${selectedPdf!.path.split('/').last}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               ),

//             SizedBox(height: 20),

//             // Assign Officer Dropdown
//             Row(
//               children: [
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     value: selectedOfficer,
//                     hint: Text("Select an Officer"),
//                     onChanged: (value) => setState(() => selectedOfficer = value),
//                     items: availableOfficers.map((officer) {
//                       return DropdownMenuItem(value: officer, child: Text(officer));
//                     }).toList(),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.add),
//                   label: Text("Assign"),
//                   onPressed: assignOfficer,
//                 ),
//               ],
//             ),

//             SizedBox(height: 20),

//             // Display Assigned Officers in Order
//             if (assignedOfficers.isNotEmpty)
//               Wrap(
//                 spacing: 8,
//                 children: assignedOfficers.map((officer) {
//                   return Chip(
//                     label: Text(officer),
//                     deleteIcon: Icon(Icons.close),
//                     onDeleted: () {
//                       setState(() {
//                         assignedOfficers.remove(officer);
//                       });
//                     },
//                   );
//                 }).toList(),
//               ),

//             SizedBox(height: 20),

//             // Submit Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: submitIssue,
//                 child: Text("Submit Issue", style: TextStyle(fontSize: 18)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateIssueScreen extends StatefulWidget {
  @override
  _CreateIssueScreenState createState() => _CreateIssueScreenState();
}

class _CreateIssueScreenState extends State<CreateIssueScreen> {
  File? selectedPdf;
  List<String> assignedOfficers = [];
  List<String> availableOfficers = ["Officer A", "Officer B", "Officer C", "Officer D"];
  String? selectedOfficer;

  String? selectedDepartment;
  List<String> departments = ["HR", "IT", "Finance", "Operations"];

  TextEditingController issueNameController = TextEditingController();
  TextEditingController issueDescriptionController = TextEditingController();

  /// Picks a PDF file from storage
  Future<void> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedPdf = File(result.files.single.path!);
      });
    }
  }

  /// Assigns an officer from the dropdown
  void assignOfficer() {
    if (selectedOfficer != null && !assignedOfficers.contains(selectedOfficer)) {
      setState(() {
        assignedOfficers.add(selectedOfficer!);
        selectedOfficer = null;
      });
    }
  }

  /// Submits the issue
  void submitIssue() {
    if (selectedPdf == null ||
        assignedOfficers.isEmpty ||
        issueNameController.text.isEmpty ||
        issueDescriptionController.text.isEmpty ||
        selectedDepartment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields and upload a PDF.")),
      );
      return;
    }

    // Perform the issue creation logic (API call, Firestore, etc.)
    print("Issue Created!");
    print("Issue Name: ${issueNameController.text}");
    print("Issue Description: ${issueDescriptionController.text}");
    print("Department: $selectedDepartment");
    print("PDF: ${selectedPdf!.path}");
    print("Assigned Officers: ${assignedOfficers.join(", ")}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Issue Submitted Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Issue")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Issue Name Input
              TextFormField(
                controller: issueNameController,
                decoration: InputDecoration(
                  labelText: "Issue Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              // Issue Description Input
              TextFormField(
                controller: issueDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Issue Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              // Department Dropdown
              DropdownButtonFormField<String>(
                value: selectedDepartment,
                hint: Text("Select Department"),
                onChanged: (value) => setState(() => selectedDepartment = value),
                items: departments.map((dept) {
                  return DropdownMenuItem(value: dept, child: Text(dept));
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // PDF Upload Button
              ElevatedButton.icon(
                icon: Icon(Icons.upload_file),
                label: Text("Upload PDF"),
                onPressed: pickPdfFile,
              ),

              // Show selected PDF file
              if (selectedPdf != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Selected PDF: ${selectedPdf!.path.split('/').last}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

              SizedBox(height: 20),

              // Assign Officer Dropdown
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedOfficer,
                      hint: Text("Select an Officer"),
                      onChanged: (value) => setState(() => selectedOfficer = value),
                      items: availableOfficers.map((officer) {
                        return DropdownMenuItem(value: officer, child: Text(officer));
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text("Assign"),
                    onPressed: assignOfficer,
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Display Assigned Officers in Order
              if (assignedOfficers.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: assignedOfficers.map((officer) {
                    return Chip(
                      label: Text(officer),
                      deleteIcon: Icon(Icons.close),
                      onDeleted: () {
                        setState(() {
                          assignedOfficers.remove(officer);
                        });
                      },
                    );
                  }).toList(),
                ),

              SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: submitIssue,
                  child: Text("Submit Issue", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
