/* import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ExcelDownloadScreen extends StatefulWidget {
  final String fileUrl;

  ExcelDownloadScreen({required this.fileUrl});

  @override
  _ExcelDownloadScreenState createState() => _ExcelDownloadScreenState();
}

class _ExcelDownloadScreenState extends State<ExcelDownloadScreen> {
  late http.Client client;
  late bool downloading;
  late String progress;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    downloading = false;
    progress = '';
  }

  var openResult = 'Unknown';
  Future<void> downloadFile(String url) async {
    final response = await client.get(Uri.parse(url));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentDirectory.path}/example.xlsx');

    print('Document Directory: ${documentDirectory.path}');
    print('File Path: ${file.path}');

    await file.writeAsBytes(response.bodyBytes);
    const filePath = '/storage/emulated/0/Download/flutter.png';
    final result = await OpenFilex.open(filePath);

    setState(() {
      openResult = "type=${result.type}  message=${result.message}";
    });
    if (await file.exists()) {
      print('File saved successfully.');
    } else {
      print('Error saving file.');
    }
  }

  Future<void> openFile() async {
    const filePath = '/storage/emulated/0/Download/flutter.png';
    final result = await OpenFilex.open(filePath);

    setState(() {
      openResult = "type=${result.type}  message=${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excel Download'),
      ),
      body: Center(
        child: downloading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(progress),
                ],
              )
            : ElevatedButton(
                onPressed: () async {
                  setState(() {
                    downloading = true;
                    progress = 'Downloading...';
                  });

                  await downloadFile(widget.fileUrl);

                  setState(() {
                    downloading = false;
                    progress = 'Download complete!';
                  });
                },
                child: Text('Download Excel'),
              ),
      ),
    );
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: ExcelDownloadScreen(
      fileUrl:
          // "https://docs.google.com/spreadsheets/d/11ZdlkJ0iozYiimVKAZdipb-3UIWlghWw/edit#gid=1190864163"
          'http://172.105.41.135/bansal-dashboard/public/storage/exports/appointment_658e60e29c8bf.xlsx',
    ),
  ));
}
 */