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
import 'package:flutter/material.dart';import 'dart:io';
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
    this.allSubjects, this.detailInfo, this.byteData, this.allAtt, this.allSem, {
    Key? key,
  }) : super(key: key);

  @override
  State<AllMarksheetPage> createState() => _AllMarksheetPageState();
}

class _AllMarksheetPageState extends State<AllMarksheetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONSOLIDATED GRADE CARD'),
        centerTitle: true,
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
                    // fit: BoxFit.cover,
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
              // SizedBox(height: 30),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  // child: Container(
                  //   padding: EdgeInsets.all(16.0),
                  //   child: Image.asset(
                  //     'assets/xyz.png',
                  //     width: 200,
                  //   ),
                  // ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Result',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            'Sem',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Subject Title',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Code',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Grades',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Credit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'ATT Code',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]),
                    for (int i = 0; i < widget.allSubjects.length; i++)
                      TableRow(children: [
                        TableCell(
                          child:
                              Center(child: Text(widget.allSem[i])),
                        ),
                        TableCell(
                          child:
                              Center(child: Text(widget.allSubjects[i])),
                        ),
                        TableCell(
                          child:
                              Center(child: Text(widget.allSubjectCode[i])),
                        ),
                        TableCell(
                          child:
                              Center(child: Text(widget.allSubjectMarks[i])),
                        ),
                        TableCell(
                          child:
                              Center(child: Text(widget.allSubjectGrade[i])),
                        ),
                        TableCell(
                          child:
                              Center(child: Text(widget.allAtt[i])),
                        ),
                      ]),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Medium of instruction - English'),
              SizedBox(height: 20),
              SlideTransition(
                position: _slideAnimation,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back'),
                ),
              ),
              SizedBox(height: 20),
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
