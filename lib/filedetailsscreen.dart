import 'dart:typed_data';

import 'package:flutter/material.dart';

// class FileDetailsScreen extends StatefulWidget {
//   final String fileTitle;
//   FileDetailsScreen({required this.fileTitle});

//   @override
//   _FileDetailsScreenState createState() => _FileDetailsScreenState();
// }

// class _FileDetailsScreenState extends State<FileDetailsScreen> {
//   TextEditingController _notesController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.fileTitle)),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("File: ${widget.fileTitle}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             TextField(
//               controller: _notesController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Add Notes',
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.forward),
//                   label: Text("Forward"),
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File Forwarded")));
//                     Navigator.pop(context);
//                   },
//                 ),
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.close, color: Colors.red),
//                   label: Text("Reject"),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File Rejected")));
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
//import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

class FileDetailsScreen extends StatefulWidget {
  final String fileTitle;
  final String assetPdfPath; // Path in assets (e.g., "assets/sample.pdf")

  FileDetailsScreen({required this.fileTitle, required this.assetPdfPath});

  @override
  _FileDetailsScreenState createState() => _FileDetailsScreenState();
}

class _FileDetailsScreenState extends State<FileDetailsScreen> {
  String? localPdfPath;
  TextEditingController _notesController = TextEditingController();
//   final pdfController = PdfController(
//   document: PdfDocument.openAsset('assets/flowchart.pdf'),
// );

  @override
  void initState() {
    super.initState();
    _loadAssetPdf();
  }

  Future<void> _loadAssetPdf() async {
    try {
      final ByteData data = await rootBundle.load(widget.assetPdfPath); // Load PDF from assets
      final List<int> bytes = data.buffer.asUint8List(); // Convert to bytes

      final tempDir = await getTemporaryDirectory(); // Get temp directory
      final tempFile = File("${tempDir.path}/temp.pdf"); // Create a temp file

      await tempFile.writeAsBytes(bytes, flush: true); // Write bytes to file

      setState(() {
        localPdfPath = tempFile.path; // Set the local PDF path
      });
    } catch (e) {
      print("Error loading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.fileTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("File: ${widget.fileTitle}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Show PDF if loaded
           // localPdfPath != null
                 Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                      // child: const PDFView(
                      //   filePath: "assets/flowchart.pdf",
                      //   enableSwipe: true,
                      //   swipeHorizontal: false,
                      //   autoSpacing: true,
                      //   pageSnap: true,
                      //   fitPolicy: FitPolicy.BOTH,
                      // ),
    //                   child: PdfView(
    //   controller: pdfController,
    // )
                    ),
                  ),
                //: Center(child: CircularProgressIndicator()), // Show loader while PDF loads
            const SizedBox(height: 10),

            // Notes Input
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add Notes',
              ),
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.forward),
                  label: const Text("Forward"),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("File Forwarded")));
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.close, color: Colors.red),
                  label: const Text("Reject"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("File Rejected")));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
