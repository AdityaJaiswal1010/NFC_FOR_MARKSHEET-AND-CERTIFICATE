import 'dart:typed_data';

import 'package:app/view/pdfview.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
class DisplayNfcData extends StatefulWidget {
  final List<String> detailInfo;
  final String uniqueRegNo;
  final Uint8List byteData;
  const DisplayNfcData(this.detailInfo, this.uniqueRegNo, this.byteData, {Key? key}) : super(key: key);

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.memory(
            widget.byteData,
            width: 550,
            height: 200,
          ),
          SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.detailInfo.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(widget.detailInfo[index]),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}
