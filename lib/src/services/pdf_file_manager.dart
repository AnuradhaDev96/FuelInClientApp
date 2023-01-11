import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'dart:html' as html;

class PdfFileManager {

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    // mobile specific
    final directory =await getApplicationDocumentsDirectory();
    final file  = File("${directory.path}/$name");

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future<html.AnchorElement> webViewDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    // WEB specific
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    var anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'pdf.pdf';
    html.document.body?.children.add(anchor);

    return anchor;
  }

  // static Future openDocument(File file) async {
  //   final url = file.path;
  //
  //   await OpenFile.open(url);
  // }
}