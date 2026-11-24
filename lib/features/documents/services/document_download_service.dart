import 'dart:io';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';

import '../models/document.dart';
import '../../../core/network/worker_client.dart';
import '../../../core/platform/platform_support.dart';

class DocumentDownloadService {
  DocumentDownloadService._();
  static final DocumentDownloadService instance = DocumentDownloadService._();

  Future<void> downloadDocument(
    BuildContext context,
    Document document, {
    Uint8List? bytes,
    File? file,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Downloading...')),
    );
    try {
      Uint8List fileBytes = bytes ?? Uint8List(0);
      File? fileToSave = file;

      if (fileBytes.isEmpty && fileToSave == null) {
        final objectPath = document.filePath ?? 'documents/${document.id}.pdf';
        fileBytes = await WorkerClient.instance.getBytes(objectPath);
      }

      final fileName = _sanitizeFilename(document.title);

      String? savedPath;
      if (PlatformSupport.isWindows && fileToSave != null) {
        savedPath = await _saveWithDialog(fileToSave, fileName);
      } else if (PlatformSupport.isWindows && fileBytes.isNotEmpty) {
        final tempFile = await _writeTempFile(fileBytes, fileName);
        savedPath = await _saveWithDialog(tempFile, fileName);
        await tempFile.delete();
      } else {
        savedPath = await FileSaver.instance.saveAs(
          name: fileName,
          bytes: fileBytes.isNotEmpty ? fileBytes : null,
          file: fileToSave,
          fileExtension: 'pdf',
          mimeType: MimeType.pdf,
        );
      }

      if (!context.mounted) return;
      if (savedPath == null) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved "$fileName.pdf"')),
      );
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not download document.\n$error')),
      );
    }
  }

  Future<String?> _saveWithDialog(File file, String suggestedName) async {
    try {
      return await FileSaver.instance.saveAs(
        name: suggestedName,
        file: file,
        fileExtension: 'pdf',
        mimeType: MimeType.pdf,
      );
    } catch (e) {
      return null;
    }
  }

  Future<File> _writeTempFile(Uint8List bytes, String name) async {
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/$name.pdf');
    await tempFile.writeAsBytes(bytes);
    return tempFile;
  }

  String _sanitizeFilename(String title) {
    final sanitized = title
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '_')
        .trim()
        .replaceAll(RegExp(r'^\.+|\.+$'), '');
    return sanitized.isEmpty ? 'document' : sanitized;
  }
}