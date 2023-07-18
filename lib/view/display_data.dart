import 'package:flutter/material.dart';

class DisplayNfcData extends StatefulWidget {
  final Map<String, dynamic> m;
  final String maildata;
  final List<String> allcgpi;
  final String fname;
  final String phonenum;
  const DisplayNfcData(this.m, this.maildata, this.allcgpi, this.fname, this.phonenum, {Key? key}) : super(key: key);

  @override
  State<DisplayNfcData> createState() => _DisplayNfcDataState();
}

class _DisplayNfcDataState extends State<DisplayNfcData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              SizedBox(height: 12),
              Row(
                children: [
                  Text('Sem- '),
                  Text(widget.maildata),
                ],
                
              ),
              SizedBox(height: 12),
              for(int i=0;i<widget.allcgpi.length;i++)
              Row(
                
                children: [
                  Text('Sem ${i} Cgpa- '),
                  Text(widget.allcgpi[i]),
                ],
                
              ),
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
}