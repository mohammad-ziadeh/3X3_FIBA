// pdf_downloader_mobile.dart
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

Future<void> platformDownloadFile(
  BuildContext context,
  String url,
  String filename,
) async {
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Storage permission denied')),
    );
    return;
  }

  try {
    final dir = await getExternalStorageDirectory();
    final path = '${dir?.path}/$filename';

    await Dio().download(url, path);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded to $path')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download failed: $e')),
    );
  }
}
