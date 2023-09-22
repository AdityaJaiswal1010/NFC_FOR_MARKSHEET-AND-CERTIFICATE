import 'package:app/view/ViewAllMarksheet.dart';
import 'package:app/view/viewDetailRecord.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details(this.maildata, this.fname, this.lname, this.resultedvalue, this.phonenum, {Key? key}) : super(key: key);
  final String maildata;
  final String phonenum;
  final String fname;
  final String lname;
  final int resultedvalue;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  int fresult= 0;
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              // Icon(FontAwesomeIcons.nfcSymbol),
                            Image.asset('assets/tinkertech.jpg',fit: BoxFit.cover, height: 32),

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
  

  
}