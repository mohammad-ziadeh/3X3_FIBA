// pdf_downloader_web.dart
// ignore: avoid_web_libraries_in_flutter
// ignore_for_file: unused_local_variable

import 'dart:html' as html;
import 'package:flutter/material.dart';

Future<void> platformDownloadFile(
  BuildContext context,
  String url,
  String filename,
) async {
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", filename)
    ..click();
}
