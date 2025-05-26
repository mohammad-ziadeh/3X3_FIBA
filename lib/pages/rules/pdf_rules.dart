import 'package:flutter/material.dart';
import 'package:fiba_3x3/pages/rules/pdf_downloader/pdf_downloader.dart';

class Document {
  final String name;
  final String url;
  final String updated;

  Document({required this.name, required this.url, required this.updated});
}

class PdfList extends StatelessWidget {
  final List<Document> documents = [
    Document(
      name: 'FIBA 3x3 RULES',
      url:
          'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      updated: '01/03/2025',
    ),
    Document(
      name: 'FIBA 3x3 RULES 2',
      url:
          'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
      updated: '20/02/2024',
    ),
  ];

  PdfList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final doc = documents[index];
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text(
                doc.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Updated: ${doc.updated}'),
              trailing: const Icon(Icons.download),
              onTap: () => downloadFile(context, doc.url, '${doc.name}.pdf'),
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }
}
