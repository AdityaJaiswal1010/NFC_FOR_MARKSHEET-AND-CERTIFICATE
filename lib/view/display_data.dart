import 'package:app/view/pdfview.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayNfcData extends StatefulWidget {
  final Map<String, dynamic> m;
  final List<String> allMarksheet;
  final String maildata;
  final List<String> allcgpi;
  final String fname;
  final String phonenum;
  const DisplayNfcData(this.m, this.maildata, this.allcgpi, this.fname, this.phonenum,this.allMarksheet, {Key? key}) : super(key: key);

  @override
  State<DisplayNfcData> createState() => _DisplayNfcDataState();
}

class _DisplayNfcDataState extends State<DisplayNfcData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Personal Detail') ,),
      body: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Text('Reg_No - ',style: TextStyle(fontSize: 25),),
                  
                  Text(widget.fname,style: TextStyle(fontSize: 25),),
                  // Text(widget.allMarksheet[0].toString()),

              
              // ElevatedButton(onPressed:() {
                
              // }, child: Text('Sem 1'))
                ],
                
              ),
              SizedBox(height: 20,),
              Row(children: [
                Text('Prn No- ',style: TextStyle(fontSize: 25),),
              Text(widget.m['prn'].toString(),style: TextStyle(fontSize: 25),),

              
              ],),
              SizedBox(height: 20,),
              Row(children: [
                

              Text('Seat_No- ',style: TextStyle(fontSize: 25),),
              Text(widget.phonenum,style: TextStyle(fontSize: 25),),
              
              ],),
              SizedBox(height: 20,),
              Row(children: [
               
              Text('Exam Year- ',style: TextStyle(fontSize: 25),),
              Text(widget.m['exam_year'].toString(),style: TextStyle(fontSize: 25),),
              
              ],),
              SizedBox(height: 20,),
              Row(children: [
                
              Text('Exam Month- ',style: TextStyle(fontSize: 25),),
              Text(widget.m['exam_month'].toString(),style: TextStyle(fontSize: 25),),
              
              ],),
              SizedBox(height: 20,),
              Row(children: [
                
              Text('Candidates Name- ',style: TextStyle(fontSize: 25),),
              Text(widget.m['candidate_name'],style: TextStyle(fontSize: 25),),
            
              ],),
              
              SizedBox(height: 20,),
              Row(children: [
               
              Text('Fathers Name- ',style: TextStyle(fontSize: 25),),
              Text(widget.m['father_name'],style: TextStyle(fontSize: 25),),
              ],),
              SizedBox(height: 20,),
              Row(children: [
           
              Text('Mothers Name- ',style: TextStyle(fontSize: 25),),
              Text(widget.m['mother_name'],style: TextStyle(fontSize: 25),),
              
              ],),
              SizedBox(height: 20,),
            ],
          ),
          SizedBox(height: 12),
        //  Column(
        //     children: [
        //                   Text(widget.allMarksheet[0].toString()),

        //       Text('Prn No- '),
        //       Text(widget.m['prn'].toString()),
        //     ],
            
        //   ),
        //   SizedBox(height: 12),
        //    Row(
        //     children: [
        //       Text('Seat_No- '),
        //       Text(widget.phonenum),
        //       ElevatedButton(onPressed:() {
                
        //       }, child: Text('Sem 1'))
        //     ],
            
        //   ),

        
          // SizedBox(height: 12),
          // Row(
          //   children: [
          //     Text('Sem- '),
          //     Text(widget.maildata),
          //   ],
            
          // ),
          SizedBox(height: 12),
        
          // DebugPrint(widget.allMarksheet);
          // if(widget.allMarksheet.length==1)
          // ListView(
          //   shrinkWrap: true,
          //   children:<Widget> [
          //     Row(
                
          //       children:<Widget> [
                  
          //         Container(
          //           child: ElevatedButton(onPressed: () {
                     
          //             // Navigator.push(context,
          //             //                     MaterialPageRoute(builder: (context) => PdfViewerPage(widget.allMarksheet[0].toString())));
                      
          //           }, child: Text('Sem 1 marksheet')),
          //         ),
          //       ],
                
          //     ),
          //   ],
          // ),
          // if(widget.allMarksheet.length==2)
          // Row(
            
          //   children: <Widget>[
              
          //     Container(
          //       child: ElevatedButton(onPressed: () {
          //       // Navigator.push(context,
          //       //                   MaterialPageRoute(builder: (context) => PdfViewerPage(widget.allMarksheet[0].toString())));
          //       }, child: Text('Sem 1 marksheet')),
          //     ),
          //     Container(
          //       child: ElevatedButton(onPressed: () {
          //         // Navigator.push(context,
          //         //                 MaterialPageRoute(builder: (context) => PdfViewerPage(widget.allMarksheet[1].toString())));
          //       }, child: Text('Sem 2 marksheet')),
          //     )
          //   ],
            
          // ),
      
      
      
      
      
      
      
      
      
      
        
          // for(int i=0;i<widget.allMarksheet.length;i++)
          // Row(
            
          //   children: [
              
          //     ElevatedButton(onPressed:launchPdf(widget.allMarksheet[i].toString()), child: Text('Sem ${i+1} marksheet'))
          //   ],
            
          // ),
          // FloatingActionButton(
          //   child: Text('Add to contact',style: TextStyle(fontSize: 10.0,),),
          //         backgroundColor: Colors.blue,
          //         foregroundColor: Colors.white,
            
          //   onPressed: ()  {
          //     // var newPerson=Contact();
          //     // newPerson.givenName=fname+lname;
          //     // newPerson.phones=[Item(label: 'mobile',value: phonenum)];
          //     // newPerson.emails=[Item(label: 'work',value: maildata)];
              
          //     //   await ContactsService.addContact(newPerson);
                
          //     //   var contacts = await ContactsService.getContacts();
          //     //     //  call all of contacts
          //     //   setState(() {
          //     //     var name = contacts;
          //     //   });
          //     saveContactInPhone(fname,lname,phonenum,maildata);
          //   },
             
          // )
        ],
        
      ),
    );
  }
  
  // void _launchURL(String _url) async {
  //   if (await canLaunch(_url)) {
  //     await launch(_url, forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  //   } else {
  //     throw 'Could not launch $_url';
  //   }
  // }
}