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
              (widget.detailInfo[0].toLowerCase().contains('folio'))?Text(widget.detailInfo[0]):Text(''),
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
  TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black54,
    fontSize: 14,
  );
  TextStyle dataStyle = TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.black54,
    fontSize: 14,
  );

  // Calculate the number of columns based on the maximum items per row
  int columns = 3;
  List<TableRow> tableRows = [];
  for (int i = 0; i < widget.detailInfo.length; i += columns) {
    List<Widget> cells = [];
    for (int j = 0; j < columns; j++) {
      if (i + j < widget.detailInfo.length) {
        var detailParts = widget.detailInfo[i + j].split('-');
        if (detailParts.length >= 2) {
          cells.add(
            Container(
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
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: RichText(
                text: TextSpan(
                  text: '${detailParts[0]}: ',
                  style: titleStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: detailParts.sublist(1).join('-'),
                      style: dataStyle,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          // Ensure empty cells are added if there's no data
          cells.add(Container());
        }
      } else {
        // Add empty containers to ensure the structure remains intact
        cells.add(Container());
      }
    }
    tableRows.add(TableRow(children: cells));
  }

  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: tableRows,
  );
}


Widget _buildResultTable() {
  List<TableRow> rows = [
    TableRow(
      decoration: BoxDecoration(color: Colors.deepPurple.shade100),
      children: [
        _buildTableHeader('Sem'),
        _buildTableHeader('Subject Code'),
        _buildTableHeader('Subject Title'),
        _buildTableHeader('Credit'),
        _buildTableHeader('Grade'),
        _buildTableHeader('ATT Code'),
      ],
    ),
  ];

  String? previousSem;
  for (int i = 0; i < widget.allSubjects.length; i++) {
    // Check if the semester has changed and it's not the first entry
    if (previousSem != null && widget.allSem[i] != previousSem) {
      // Add a divider row that spans all columns
      rows.add(_buildDividerRow(6)); // Assuming you have 6 columns
    }
    // Add the regular data row
    rows.add(
      TableRow(
        decoration: BoxDecoration(
          color: i % 2 == 0 ? Colors.grey.shade100 : null,
        ),
        children: [
          _buildTableCell(widget.allSem[i]),
          _buildTableCell(widget.allSubjectCode[i]),
          _buildTableCell(widget.allSubjects[i]),
          _buildTableCell(widget.allSubjectMarks[i]), // Assuming this is the Credit column
          _buildTableCell(widget.allSubjectGrade[i]), // Assuming this is the Grade column
          _buildTableCell(widget.allAtt[i]), // Assuming this is the ATT Code column
        ],
      ),
    );
    previousSem = widget.allSem[i];
  }

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
    children: rows,
  );
}

TableRow _buildDividerRow(int numberOfColumns) {
  return TableRow(
    children: List.generate(
      numberOfColumns,
      (_) => TableCell(
        child: Container(
          height: 2, // Increase the thickness of the divider line
          color: Colors.black87, // Use a darker shade for the divider line
        ),
      ),
    ),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(width: 2, color: Colors.black87), // Make the top border thicker and darker
      ),
    ),
  );
}




 Widget _buildTableHeader(String title) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isGrade = false}) {
    Color? textColor;
    if (isGrade && text == 'A') {
      textColor = Colors.green;  // Example of conditional formatting
    }

    return TableCell(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(color: textColor),
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










