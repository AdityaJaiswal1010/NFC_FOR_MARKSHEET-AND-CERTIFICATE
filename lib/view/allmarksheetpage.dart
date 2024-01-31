
import 'dart:io';
import 'dart:typed_data';

import 'package:app/view/pdfview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:flutter/material.dart';

class AllMarksheetPage extends StatefulWidget {
  final List<String> allSubjects;
  final List<String> allSubjectCode;
  final List<String> allSubjectMarks;
  final List<String> allSubjectGrade;

  const AllMarksheetPage(
    this.allSubjectCode,
    this.allSubjectMarks,
    this.allSubjectGrade,
    this.allSubjects, {
    Key? key,
  }) : super(key: key);

  @override
  State<AllMarksheetPage> createState() => _AllMarksheetPageState();
}

class _AllMarksheetPageState extends State<AllMarksheetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              Text('Transcripts'),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Image.asset('assets/xyz.png'),
              ),
              SizedBox(height: 30),
              Text(
                'Result',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 30),
            
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          color: Colors.grey.shade400,
                          child: Center(
                            child: Text(
                              'Subject',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          color: Colors.grey.shade400,
                          child: Center(
                            child: Text(
                              'Code',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          color: Colors.grey.shade400,
                          child: Center(
                            child: Text(
                              'Marks',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          color: Colors.grey.shade400,
                          child: Center(
                            child: Text(
                              'Grade',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    for (int ticker = 0; ticker < widget.allSubjects.length; ticker++)
                      TableRow(
                        children: [
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Center(child: Text(widget.allSubjects[ticker])),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Center(child: Text(widget.allSubjectCode[ticker])),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Center(child: Text(widget.allSubjectMarks[ticker])),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Center(child: Text(widget.allSubjectGrade[ticker])),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 30),
             
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class View extends StatefulWidget {
  final String url;
  final String sem_no;
  const View(this.url, this.sem_no, {Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    secureScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marksheet - ${widget.sem_no}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(80),
              panEnabled: false,
              scaleEnabled: true,
              minScale: 1.0,
              maxScale: 2.2,
              child: Image.network(widget.url, fit: BoxFit.fitWidth),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Add this line to navigate back
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}
