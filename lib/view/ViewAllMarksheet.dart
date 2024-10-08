import 'dart:async';

import 'package:app/view/allmarksheetpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewAllMarksheet extends StatefulWidget {
  final List<List<String>> allSubjects;
  final List<List<String>> allSubjectCode;
  final List<List<String>> allSubjectMarks;
  final List<List<String>> allSubjectGrade;
  const ViewAllMarksheet(this.allSubjects, this.allSubjectCode, this.allSubjectMarks, this.allSubjectGrade, 
      {Key? key})
      : super(key: key);

  @override
  State<ViewAllMarksheet> createState() => _ViewAllMarksheetState();
}

class _ViewAllMarksheetState extends State<ViewAllMarksheet> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      linkToPage();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Row(
          children: [
            // Image.asset('assets/tinkertech.jpg', fit: BoxFit.cover, height: 32),
            Text('Marksheets'),
          ],
        )),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       fit: BoxFit.cover,
        //       image: NetworkImage(
        //           "https://i.pinimg.com/564x/b0/4c/c6/b04cc64b420bdcedee3cc48160abc3f5.jpg")),
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   "assets/tinkertech.jpg",
              //   gaplessPlayback: true,
              //   fit: BoxFit.fill,
              //   height: 300,
              //   width: 300,
              // ),
              // Icon(FontAwesomeIcons.tasks),
              SizedBox(
                width: 20,
              ),
              Text(
                "Preparing Detail Record",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   "Reg No",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(
                height: 35,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> linkToPage() async {
    // print('-----------------------');
    // print(maildata.toString());
    // String refid = maildata.toString().trim();
    // var resultData =
    //     await FirebaseFirestore.instance.collection('users').doc(refid).get();
    // Map<String, dynamic> m = resultData.data()!;
    // List<dynamic> childidList = m['childid'];
    // print(childidList);
    // List<String> allcgpi = [];
    // List<dynamic> refmarksheet = m['allmarksheet'];
    // List<String> allMarkSheet = [];
    // for (var i = 0; i < refmarksheet.length.toInt(); i++) {
    //   setState(() {
    //     allMarkSheet.add(refmarksheet[i.toInt()].toString());
    //   });
    // }
    // print(childidList.length.toInt());
    // for (var i = 0; i < childidList.length.toInt(); i++) {
    //   var r = await FirebaseFirestore.instance
    //       .collection('forms')
    //       .doc(childidList[i].toString().trim())
    //       .get();
    //   Map<String, dynamic> mdata = r.data()!;
    //   if (allcgpi.length == childidList.length.toInt()) break;
    //   setState(() {
    //     allcgpi.add(mdata['sgpi'].toString());
    //   });
    // }
    // print('before');
    // print(allcgpi);
    // print('after');
    // print('---------------');
    // print(allMarkSheet);
    // Navigator.push(
        // context,
        // MaterialPageRoute(
          // builder: (context) => AllMarksheetPage(widget.allSubjects,widget.allSubjectCode,widget.allSubjectMarks,widget.allSubjectGrade),
        // )
        // );
  }
}
