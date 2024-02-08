import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/view/display_data.dart';
import 'package:app/view/allmarksheetpage.dart';

class ReadRecordDetail extends StatelessWidget {
  final String uniqueRegNo;
  final List<String> allPersonalData;
  final String personalDetails;
  final List<List<String>> allSubjects;
  final List<List<String>> allSubjectCode;
  final List<List<String>> allSubjectMarks;
  final List<List<String>> allSubjectGrade;
  final List<String> allSubjectsCode;
  final List<String> allGrade;
  final List<String> allCredit;
  final List<String> decodedSubject;
  final List<Widget> ndefWidgets;
  final String maildata;
  final int resultedvalue;
  final Future<int> rrrr;
  final String fname;
  final String lname;
  final String phonenum;
  final Uint8List byteData;
  final List<String> allSem;
  final List<String> allAtt;

  ReadRecordDetail(
    this.ndefWidgets,
    this.maildata,
    this.fname,
    this.lname,
    this.phonenum,
    this.rrrr,
    this.resultedvalue,
    this.uniqueRegNo,
    this.allSubjects,
    this.allSubjectCode,
    this.allSubjectMarks,
    this.allSubjectGrade,
    this.personalDetails,
    this.byteData,
    this.allSubjectsCode,
    this.allGrade,
    this.allCredit,
    this.decodedSubject,
    this.allPersonalData, 
    this.allAtt,
    this.allSem,
     {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/xyz.png',
                width: 200,
              ),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => DisplayNfcData(
            //           allPersonalData,
            //           uniqueRegNo,
            //           byteData,
            //         ),
            //       ),
            //     );
            //   },
            //   child: Text(
            //     'Student\'s Personal Details',
            //     style: TextStyle(fontSize: 20, color: Colors.white),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.amber,
            //     minimumSize: Size(350, 150),
            //   ),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllMarksheetPage(
                      allSubjectsCode,
                      allGrade,
                      allCredit,
                      decodedSubject,
                      allPersonalData,
                      byteData,
                      allAtt,
                      allSem,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    'Transcripts',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    '(All Semesters)',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                minimumSize: Size(350, 150),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
