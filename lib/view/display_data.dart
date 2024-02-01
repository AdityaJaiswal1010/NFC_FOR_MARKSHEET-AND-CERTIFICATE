import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayNfcData extends StatefulWidget {
  final List<String> detailInfo;
  final String uniqueRegNo;
  final Uint8List byteData;

  const DisplayNfcData(
      this.detailInfo, this.uniqueRegNo, this.byteData,
      {Key? key})
      : super(key: key);

  @override
  State<DisplayNfcData> createState() => _DisplayNfcDataState();
}

class _DisplayNfcDataState extends State<DisplayNfcData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Hero(
              tag: 'nfc_image',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.memory(
                  widget.byteData,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 30),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.detailInfo.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        widget.detailInfo[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
