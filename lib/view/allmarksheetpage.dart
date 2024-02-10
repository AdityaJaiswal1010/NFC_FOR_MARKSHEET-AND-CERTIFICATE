import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:app/view/pdfview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class AllMarksheetPage extends StatefulWidget {
  final List<String> allSubjects;
  final List<String> allSubjectCode;
  final List<String> allSubjectMarks;
  final List<String> allSubjectGrade;
  final List<String> detailInfo;
  final Uint8List byteData;
  final List<String> allAtt;
  final List<String> allSem;

  const AllMarksheetPage(
      this.allSubjectCode,
      this.allSubjectMarks,
      this.allSubjectGrade,
      this.allSubjects,
      this.detailInfo,
      this.byteData,
      this.allAtt,
      this.allSem, {
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
        title: Text('CONSOLIDATED GRADE CARD'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Student Detail',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepPurple),
              ),
              SizedBox(height: 20),
              _buildDetailInfo(),
              SizedBox(height: 20),
              Text(
                'Result',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.deepPurple),
              ),
              SizedBox(height: 20),
              _buildResultTable(),
              SizedBox(height: 20),
              Text('Medium of instruction - English'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
Widget _buildDetailInfo() {
  // Assuming that each piece of information is separated by a dash "-"
  // and the detailInfo list is structured accordingly.
  List<Widget> rows = [];
  for (int i = 0; i < widget.detailInfo.length; i += 3) {
    List<Widget> cells = [];
    for (int j = 0; j < 3; j++) {
      // Check if the index is within bounds of the list
      if (i + j < widget.detailInfo.length) {
        var detailParts = widget.detailInfo[i + j].split('-');
        if (detailParts.length >= 2) {
          cells.add(
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: RichText(
                  text: TextSpan(
                    text: '${detailParts[0]}: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: detailParts.sublist(1).join('-'),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      } else {
        cells.add(Expanded(child: Container())); // Empty expanded widget
      }
    }
    rows.add(Row(children: cells));
  }
  return Column(children: rows);
}

  Widget _buildResultTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            _buildTableHeader('Sem'),
            _buildTableHeader('Subject Code'),
            _buildTableHeader('Subject Title'),
            _buildTableHeader('Credit'),
            _buildTableHeader('Grade'),
            _buildTableHeader('ATT Code'),
          ],
        ),
        for (int i = 0; i < widget.allSubjects.length; i++)
          TableRow(
            decoration: BoxDecoration(
              color: i % 2 == 0 ? Colors.grey.shade100 : null,
            ),
            children: [
              _buildTableCell(widget.allSem[i]),
              _buildTableCell(widget.allSubjectCode[i]),
              _buildTableCell(widget.allSubjects[i]),
              _buildTableCell(widget.allSubjectMarks[i]),
              _buildTableCell(widget.allSubjectGrade[i]),
              _buildTableCell(widget.allAtt[i]),
            ],
          ),
      ],
    );
  }

  Widget _buildTableHeader(String title) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(text),
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













// child: Table(
//   border: TableBorder.all(),
//   children: [
//     TableRow(children: [
//       TableCell(
//         child: Container(
//           width: 150, // Adjust the width as needed
//           child: Center(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Text(
//                 'Subject Title',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//       ),
//       TableCell(
//         child: Container(
//           width: 100, // Adjust the width as needed
//           child: Center(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Text(
//                 'Code',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//       ),
//       TableCell(
//         child: Container(
//           width: 100, // Adjust the width as needed
//           child: Center(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Text(
//                 'Grades',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//       ),
//       TableCell(
//         child: Container(
//           width: 100, // Adjust the width as needed
//           child: Center(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Text(
//                 'Credit',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ]),
//     for (int i = 0; i < widget.allSubjects.length; i++)
//       TableRow(children: [
//         TableCell(
//           child: Container(
//             width: 150, // Adjust the width as needed
//             child: Center(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Text(
//                   widget.allSubjects[i],
//                   style: TextStyle(fontWeight: FontWeight.normal),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         TableCell(
//           child: Container(
//             width: 100, // Adjust the width as needed
//             child: Center(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Text(
//                   widget.allSubjectCode[i],
//                   style: TextStyle(fontWeight: FontWeight.normal),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         TableCell(
//           child: Container(
//             width: 100, // Adjust the width as needed
//             child: Center(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Text(
//                   widget.allSubjectMarks[i],
//                   style: TextStyle(fontWeight: FontWeight.normal),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         TableCell(
//           child: Container(
//             width: 100, // Adjust the width as needed
//             child: Center(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Text(
//                   widget.allSubjectGrade[i],
//                   style: TextStyle(fontWeight: FontWeight.normal),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ]),
//   ],
// ),
