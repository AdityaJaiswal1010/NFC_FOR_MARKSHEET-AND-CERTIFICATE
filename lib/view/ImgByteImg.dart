import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BytecodeToImage extends StatefulWidget {
  @override
  _BytecodeToImageState createState() => _BytecodeToImageState();
}

class _BytecodeToImageState extends State<BytecodeToImage> {
  File? _selectedImage;
  List<int>? _imageBytes;
  late Uint8List byteData = Uint8List(0); // Initialize with an empty Uint8List

  Future<void> _pickImage() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (pickedFile != null && pickedFile.files.isNotEmpty) {
      File file = File(pickedFile.files.first.path!);

      Uint8List bytes = await file.readAsBytes();

      print("Original image size: ${bytes.length} bytes\n");
      String base64String = base64Encode(bytes);
      print("String ${base64String.length}");
      print(bytes);
      setState(() {
        _imageBytes = bytes;
        byteData = bytes;
      });
    } else {
      print("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Byte Converter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Select Image"),
            ),
            SizedBox(height: 20),
            if (_imageBytes != null)
              Image.memory(
                byteData,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}








