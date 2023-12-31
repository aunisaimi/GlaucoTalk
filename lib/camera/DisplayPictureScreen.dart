import 'dart:io';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  //final String imageUrl;
  final String imagePath;

  const DisplayPictureScreen({
    super.key,
    required this.imagePath,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(title: const Text('Display the Picture'),
      backgroundColor: Colors.black54,
      ),
      // The Image is stored as a file on the device. use the 'Image.file'
      // constructor with the given path to display the image
      body: Image.file(File(imagePath)),
    );
  }
}
