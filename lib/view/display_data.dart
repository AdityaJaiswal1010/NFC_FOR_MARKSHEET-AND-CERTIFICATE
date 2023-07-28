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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Reg_No - '),
                    
                    Text(widget.fname),
                  ],
                  
                ),
                SizedBox(height: 12),
               Row(
                  children: [
                    Text('Prn No- '),
                    Text(widget.m['prn'].toString()),
                  ],
                  
                ),
                SizedBox(height: 12),
                 Row(
                  children: [
                    Text('Seat_No- '),
                    Text(widget.phonenum),
                  ],
                  
                ),
                // SizedBox(height: 12),
                // Row(
                //   children: [
                //     Text('Sem- '),
                //     Text(widget.maildata),
                //   ],
                  
                // ),
                SizedBox(height: 12),
                // DebugPrint(widget.allMarksheet);
      //           if(widget.allMarksheet.length==1)
      //           Row(
                  
      //             children: [
                    
      //               ElevatedButton(onPressed: () {
                     
      // SfPdfViewer.network(widget.allMarksheet[0].toString());
        
      //               }, child: Text('Sem 1 marksheet')),
      //             ],
                  
      //           ),
      //           if(widget.allMarksheet.length==2)
      //           Row(
                  
      //             children: [
                    
      //               ElevatedButton(onPressed: () {
      //               SfPdfViewer.network(widget.allMarksheet[0].toString());
      //               }, child: Text('Sem 1 marksheet')),
      //               ElevatedButton(onPressed: () {
      //                 SfPdfViewer.network(widget.allMarksheet[1].toString());
      //               }, child: Text('Sem 2 marksheet'))
      //             ],
                  
      //           ),










      
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