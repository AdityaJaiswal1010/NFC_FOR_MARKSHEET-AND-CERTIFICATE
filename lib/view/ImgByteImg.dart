

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

class BytecodeToImage extends StatefulWidget {
  @override
  _BytecodeToImageState createState() => _BytecodeToImageState();
}

class _BytecodeToImageState extends State<BytecodeToImage> {
//   late Uint8List _bytecode;
//   late img.Image _image;

//   @override
//   void initState() {
//     super.initState();
//     _loadBytecode();
//   }

//   Future<void> _loadBytecode() async {
//     ByteData bytecodeData = await rootBundle.load('assets/My_Gallery.jpg');
//     _bytecode = bytecodeData.buffer.asUint8List();
//     String _bytestring=imageToBase64(_bytecode);
//     print("------------------------");
//     int counter=0;
//     for(int i=0;i<_bytecode.length;i++)
//     {
//       if(_bytecode[i]==0)
//       {
//         counter++;
//       }
//     }
//     // String temp=Image.asset('assets/My_Gallery.jpg').toString as String;
//     print(_bytecode.toString());
//     print(_bytecode.length);
//     print(_bytecode.lengthInBytes);
//     print("AS String"+_bytestring.length.toString());
//     print(counter);
//     print('------------------------');
//     _convertBytecodeToImage();
//   }
//   String imageToBase64(Uint8List imageBytes) {
//   String base64String = base64Encode(imageBytes);
//   return base64String;
// }
//   void _convertBytecodeToImage() {
//     setState(() {
//           _image = img.decodeImage(_bytecode)!;

//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bytecode to Image'),
//       ),
//       body: Center(
//         child: _image != null
//             ? Column(
//               children: [
//                 Image.memory(
//                     img.encodePng(_image),
//                     fit: BoxFit.contain,
//                   ),
//                   Text(_bytecode.toString().length.toString()),
//                   Text(_bytecode.length.toString()),
//                   Text(_bytecode.lengthInBytes.toString())
//               ],
//             )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }

  File? _selectedImage;
  List<int>? _imageBytes;

  Future<void> _pickImage() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );

  if (pickedFile != null && pickedFile.files.isNotEmpty) {
    File file = File(pickedFile.files.first.path!);
    
    Uint8List bytes = await file.readAsBytes();
    
    print("Original image size: ${bytes.length} bytes\n");
    print(bytes);
  } else {
    print("No image selected");
  }

  }
  

  // Future<List<int>?> _convertImageToBytes() async {
  //   if (_selectedImage != null) {
  //     // final Uint8List bytes = await _selectedImage!.readAsBytes();
  //     // setState(() {
  //     //   _imageBytes = bytes.toList();
  //     // });
  //     // print(_imageBytes);
  //     var openedFile = file.openSync(mode: FileMode.read);
  // var bytesRead = 0;
  // var buf = List<int>.filled(40, 0);

  // try {
  //   while (true) {
  //     var byteChunk = openedFile.readIntoSync(buf);
  //     if (byteChunk == 0) {
  //       break;
  //     }

  //     bytesRead += byteChunk;
  //   }
  // } finally {
  //   openedFile.closeSync();
  // }

  // print("Total bytes read = $bytesRead");
  //   }
  // }

  Future<void> _convertBytesToImage() async {
    if (_imageBytes != null) {
      final File imageFile = File("image.png");
      await imageFile.writeAsBytes(Uint8List.fromList(_imageBytes!));
      // return imageFile;
      // You can display the imageFile or use it as needed
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
            // _selectedImage != null
            //     ? Image.file(
            //         _selectedImage!,
            //         height: 150,
            //         width: 150,
            //         fit: BoxFit.cover,
            //       )
            //     : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Select Image"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertBytesToImage,
              child: Text("Convert Bytes to Image"),
            ),
          ],
        ),
      ),
    );
  }
}








