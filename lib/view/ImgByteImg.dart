

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class BytecodeToImage extends StatefulWidget {
  @override
  _BytecodeToImageState createState() => _BytecodeToImageState();
}

class _BytecodeToImageState extends State<BytecodeToImage> {
  late Uint8List _bytecode;
  late img.Image _image;

  @override
  void initState() {
    super.initState();
    _loadBytecode();
  }

  Future<void> _loadBytecode() async {
    ByteData bytecodeData = await rootBundle.load('assets/My_Gallery.jpg');
    _bytecode = bytecodeData.buffer.asUint8List();
    String _bytestring=imageToBase64(_bytecode);
    print("------------------------");
    int counter=0;
    for(int i=0;i<_bytecode.length;i++)
    {
      if(_bytecode[i]==0)
      {
        counter++;
      }
    }
    print(_bytecode.toString());
    print(_bytecode.length);
    print(_bytecode.lengthInBytes);
    print("AS String"+_bytestring.length.toString());
    print(counter);
    print('------------------------');
    _convertBytecodeToImage();
  }
  String imageToBase64(Uint8List imageBytes) {
  String base64String = base64Encode(imageBytes);
  return base64String;
}
  void _convertBytecodeToImage() {
    setState(() {
          _image = img.decodeImage(_bytecode)!;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bytecode to Image'),
      ),
      body: Center(
        child: _image != null
            ? Column(
              children: [
                Image.memory(
                    img.encodePng(_image),
                    fit: BoxFit.contain,
                  ),
                  Text(_bytecode.toString().length.toString()),
                  Text(_bytecode.length.toString()),
                  Text(_bytecode.lengthInBytes.toString())
              ],
            )
            : CircularProgressIndicator(),
      ),
    );
  }
}








