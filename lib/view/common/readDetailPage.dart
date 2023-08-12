import 'package:app/view/ViewAllMarksheet.dart';
import 'package:app/view/common/form_row.dart';
import 'package:app/view/viewDetailRecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadRecordDetail extends StatefulWidget {
  ReadRecordDetail(this.ndefWidgets, this.maildata, this.fname, this.lname, this.phonenum, this.rrrr, this.resultedvalue, {Key? key}) : super(key: key);
  List<Widget> ndefWidgets;
  String maildata;
  int resultedvalue;
  Future<int> rrrr;
   String fname;
    String lname;
   String phonenum;
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
              Icon(FontAwesomeIcons.nfcSymbol),
              Text('  Details' ,textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
      body: 
        
        
             Column(
               children: [
                // getData(widget.rrrr),
                (widget.resultedvalue==1)?
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
      
      
            
      
            ElevatedButton(
                  
            child: Text('View Detail Record',style: TextStyle(fontSize: 50),),
            style: ElevatedButton.styleFrom(
                  // primary: Color(0xFF00E5FF),
                  fixedSize: Size(250, 250)
                  
            ),
            onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                                builder: (context) => viewDetailRecord(widget.maildata, widget.fname, widget.lname, widget.phonenum)));
                  // linkToPage(maildata, fname, lname, phonenum);
            },
          ),
          SizedBox(height: 50,),
          ElevatedButton(
            child: Text('View All Marksheets',style: TextStyle(fontSize: 50),),
            style: ElevatedButton.styleFrom(
                  // primary: Color(0xFF00E5FF),
                  fixedSize: Size(250, 250)
            ),
            onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ViewAllMarksheet(widget.maildata, widget.fname, widget.lname, widget.phonenum)));
                  // linkToPage(maildata, fname, lname, phonenum);
            },
          ),
        ],
          ):Column(
            children: [Text('Invalid Card',style: TextStyle(fontSize: 50),)],
          )
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

