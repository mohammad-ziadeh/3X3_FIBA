// pdf_downloader.dart
import 'package:flutter/material.dart';

import 'pdf_downloader_stub.dart'
    if (dart.library.html) 'pdf_downloader_web.dart'
    if (dart.library.io) 'pdf_downloader_mobile.dart';

Future<void> downloadFile(BuildContext context, String url, String filename) {
  return platformDownloadFile(context, url, filename);
}
