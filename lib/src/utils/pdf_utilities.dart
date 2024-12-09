import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:http/http.dart' as http;

class PDFUtilities {
  Future<void> printPDF(String URL) async {
    var datas = await http.get(Uri.parse(URL));
    await Printing.layoutPdf(onLayout: (_) => datas.bodyBytes);
  }

  /// download file function
  Future downloadFile({
    required String url,
    required String filename,
    required String mobileNo,
  }) async {
    try {
      HttpClient client = HttpClient();
      List<int> downloadData = [];
      debugPrint(mobileNo);
      debugPrint(filename);
      debugPrint(url);
      Directory downloadDirectory;

      if (Platform.isIOS) {
        downloadDirectory = await getApplicationDocumentsDirectory();
      } else {
        downloadDirectory = Directory('/storage/emulated/0/Download');
        if (!await downloadDirectory.exists())
          downloadDirectory = (await getExternalStorageDirectory())!;
      }

      String filePathName = "${downloadDirectory.path}/$filename";
      File savedFile = File(filePathName);
      bool fileExists = await savedFile.exists();

      if (fileExists) {
        /*  ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text("File already downloaded"))); */
        client.getUrl(Uri.parse(url)).then(
          (HttpClientRequest request) {
            return request.close();
          },
        ).then(
          (HttpClientResponse response) {
            response.listen((d) => downloadData.addAll(d), onDone: () async {
              savedFile.writeAsBytes(downloadData);
              //  downloadedFile = savedFile;
              await WhatsappShare.shareFile(
                phone: mobileNo,
                filePath: [savedFile.path],
              );
            });
          },
        );
      } else {
        client.getUrl(Uri.parse(url)).then(
          (HttpClientRequest request) {
            return request.close();
          },
        ).then(
          (HttpClientResponse response) {
            response.listen((d) => downloadData.addAll(d), onDone: () async {
              savedFile.writeAsBytes(downloadData);
              //  downloadedFile = savedFile;
              await WhatsappShare.shareFile(
                phone: mobileNo,
                filePath: [savedFile.path],
              );
            });
          },
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong, Please try again"),
        ),
      );
    }
  }
}
