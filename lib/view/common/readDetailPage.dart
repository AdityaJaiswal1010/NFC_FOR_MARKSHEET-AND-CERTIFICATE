import 'dart:typed_data';

import 'package:app/view/ViewAllMarksheet.dart';
import 'package:app/view/allmarksheetpage.dart';
import 'package:app/view/common/form_row.dart';
import 'package:app/view/display_data.dart';
import 'package:app/view/viewDetailRecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadRecordDetail extends StatefulWidget {
  ReadRecordDetail(this.ndefWidgets, this.maildata, this.fname, this.lname, this.phonenum, this.rrrr, this.resultedvalue,this.uniqueRegNo,this.allSubjects,this.allSubjectCode,this.allSubjectMarks,this.allSubjectGrade, this.personalDetails, this.byteData, {Key? key}) : super(key: key);
  String uniqueRegNo;
  String personalDetails;
  List<List<String>> allSubjects;
  List<List<String>> allSubjectCode;
  List<List<String>> allSubjectMarks; 
  List<List<String>> allSubjectGrade;
  List<Widget> ndefWidgets;
  String maildata;
  int resultedvalue;
  Future<int> rrrr;
   String fname;
    String lname;
   String phonenum;
   Uint8List byteData;
  @override
  State<ReadRecordDetail> createState() => _ReadRecordDetailState();
}

class _ReadRecordDetailState extends State<ReadRecordDetail> {
  @override
  int fresult= 0;
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              // Icon(FontAwesomeIcons.nfcSymbol),
                            // Image.asset('assets/tinkertech.jpg',fit: BoxFit.cover, height: 32),

              Text('  Details' ,textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
      body: 
        
        
             Column(
               children: [
                // getData(widget.rrrr),



                // Authentication step
                // (widget.resultedvalue==1)?
                 Column(
        children: [
          
         
         
          // FormSection(
          //   header: Text('TAG'),
          //   children: tagWidgets,
          // ),
          
          if (widget.ndefWidgets.isNotEmpty)
            FormSection(
                  header: Text('TAG'),
                  children: widget.ndefWidgets,
          //     if(callFlag==1){
          //   linkToPage(maildata,fname,lname,phonenum);
          //   setState(() {
          //     callFlag=0;
          //   });
            
          // }
            ),
      
      
            
      
            Container(
              width: 500,
            height: 300,
              child: ElevatedButton(
                  
              child: Text('Student\'s Personal Details',style: TextStyle(fontSize: 50,color: Colors.black,),textAlign: TextAlign.center,),
              style: ElevatedButton.styleFrom(
                    // primary: Color(0xFF00E5FF),
                    backgroundColor: Colors.amber,
                    fixedSize: Size(250, 250)
                    
              ),
              onPressed: () {
                List<String> detailInfo=[];
                String tempInfo='';
                int count=0;
                for(int i=0;i<widget.personalDetails.length;i++)
                {
                  if(widget.personalDetails[i]==',')
                  {
                    detailInfo.add(tempInfo);
                    
                    tempInfo='';
                    continue;
                  }
                  
                  tempInfo+=widget.personalDetails[i];
                  
                }
                if(tempInfo!='')
                {
                  detailInfo.add(tempInfo);
                  
                }
            
                
                    Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DisplayNfcData(detailInfo,widget.uniqueRegNo,widget.byteData)));
                                  //splash page 5 sec link
                                  // viewDetailRecord(widget.maildata, widget.fname, widget.lname, widget.phonenum,detailInfo,widget.uniqueRegNo)));
                    
                    
                    
                    
                    
                    
                    // linkToPage(maildata, fname, lname, phonenum);
              },
                      ),
            ),
          SizedBox(height: 50,),
          Container(
            width: 500,
            height: 300,
            child: ElevatedButton(
              
              child: Column(
                
                children: [
                  SizedBox(height: 100,),
                  Text('Transcripts',style: TextStyle(fontSize: 50,color: Colors.black),textAlign: TextAlign.center,),
                                  Text('(All Semesters)',style: TextStyle(fontSize: 40,color: Colors.black),textAlign: TextAlign.center,),
          
                ],
              ),
              style: ElevatedButton.styleFrom(
                    // primary: Color(0xFF00E5FF),
                    backgroundColor: Colors.amber,
                    fixedSize: Size(250, 250)
              ),
              onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => AllMarksheetPage(widget.allSubjects,widget.allSubjectCode,widget.allSubjectMarks,widget.allSubjectGrade)));
                                  
                                  // link to 5 sec splash
                                  // ViewAllMarksheet(widget.allSubjects,widget.allSubjectCode,widget.allSubjectMarks,widget.allSubjectGrade)));
                    // linkToPage(maildata, fname, lname, phonenum);
              },
            ),
          ),
        ],
          )
          // :Column(
          //   children: [Text('Invalid Card',style: TextStyle(fontSize: 50),)],
          // )
               ],
             )
          
          
        
      );
    
    
  }
  
   getData(Future<int> rrrr) {
    setState(() async {
      fresult=await widget.rrrr;
    });
  }
  
}

