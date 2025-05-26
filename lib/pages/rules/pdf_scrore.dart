// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:html' as html;

class Document {
  final String name;
  final String url;
  final String updated;

  Document({required this.name, required this.url, required this.updated});
}

class ScoreList extends StatelessWidget {
  final List<Document> documents = [
    Document(
      name: 'FIBA 3x3 Statisticians Manual',
      url:
          'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      updated: '01/03/2025',
    ),
    Document(
      name: 'FIBA 3x3 Basketball Rules - Full version',
      url:
          'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
      updated: '20/02/2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final doc = documents[index];
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text(
                doc.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Updated: ${doc.updated}'),
              trailing: Icon(Icons.download),
              onTap: () => downloadFile(context, doc.url, '${doc.name}.pdf'),
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Future<void> downloadFile(
    BuildContext context,
    String url,
    String filename,
  ) async {
    if (kIsWeb) {
      final anchor =
          html.AnchorElement(href: url)
            ..setAttribute("download", filename)
            ..click();
    } else {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Storage permission denied')));
        return;
      }

      try {
        final dir = await getExternalStorageDirectory();
        final path = '${dir?.path}/$filename';

        await Dio().download(url, path);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Downloaded to $path')));
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
      }
    }
  }
}
