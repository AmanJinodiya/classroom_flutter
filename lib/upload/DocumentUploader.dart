import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DocumentUploader extends StatefulWidget {
  final String token;
  const DocumentUploader({required this.token});
  @override
  _DocumentUploaderState createState() => _DocumentUploaderState();
}

class _DocumentUploaderState extends State<DocumentUploader> {
  File? _selectedFile;

  Future<void> _pickFile() async {
    final pickedFile =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    setState(() {
      _selectedFile =
          pickedFile != null ? File(pickedFile.files.first.path!) : null;
    });
  }

  uploadFile(BuildContext context) async {
    // Get file from the device storage

    // Check if a file was selected
    if (_selectedFile == null) {
      return;
    }

    // Set up multipart request
    final url = Uri.parse('http://10.0.2.2:8000/submit_paper/');
    final headers = {'Authorization': 'Token ${widget.token}'};

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({'Authorization': 'Token ${widget.token}'});
    request.files.add(
      http.MultipartFile(
        'file',
        _selectedFile!.readAsBytes().asStream(),
        _selectedFile!.lengthSync(),
        filename: basename(_selectedFile!.path),
      ),
    );

    // Send multipart request
    try {
      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        print('File uploaded successfully!');
        // Do something with the response
      } else {
        print('File upload failed with status ${response.statusCode}.');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  void openWordDoc(String fileUrl) async {
    if (await canLaunch(fileUrl)) {
      await launch(fileUrl);
    } else {
      throw 'Could not launch $fileUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Uploader'),
      ),
      backgroundColor: const Color.fromARGB(255, 217, 234, 253),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedFile != null)
              Image.file(_selectedFile!)
            else
              const Icon(Icons.file_upload, size: 80),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // openWordDoc("http://127.0.0.1:8000/paper/5.docx");
                _pickFile();
              },
              child: const Text('Select Document'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _selectedFile == null ? null : () => uploadFile(context),
              child: const Text('Upload Document'),
            ),
          ],
        ),
      ),
    );
  }
}
