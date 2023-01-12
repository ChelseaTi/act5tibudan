import 'dart:html';
import 'package:flutter/material.dart';

class ImageLoaded extends StatelessWidget {
  final File file;

  const ImageLoaded({ Key? key, required this.file,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 140.0,
        height: 140.0,
        child: ClipOval(
          child: Image.file(
            file,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}