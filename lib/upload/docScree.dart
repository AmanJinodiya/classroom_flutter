import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentScreen extends StatelessWidget {
  final String documentUrl;

  DocumentScreen({required this.documentUrl});

  Future<void> _openDocument() async {
    if (await canLaunch(documentUrl)) {
      await launch(documentUrl);
    } else {
      throw 'Could not launch $documentUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open Document'),
          onPressed: _openDocument,
        ),
      ),
    );
  }
}
