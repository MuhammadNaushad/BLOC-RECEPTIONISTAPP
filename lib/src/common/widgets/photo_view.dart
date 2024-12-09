import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MyPhotoView extends StatelessWidget {
  final File? filePath;
  final String newtwokImgPath;
  const MyPhotoView({Key? key, this.filePath, this.newtwokImgPath = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: newtwokImgPath == ''
            ? PhotoView(
                imageProvider: FileImage(filePath!),
              )
            : PhotoView(
                imageProvider: NetworkImage(newtwokImgPath),
              ));
  }
}
