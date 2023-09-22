import 'package:app/view/Details.dart';
import 'package:app/view/common/readDetailPage.dart';
import 'package:app/view/display_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform, sleep;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:logging/logging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:contacts_service/contacts_service.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:ndef/ndef.dart' as ndef;

class ScanMifareClassic extends StatefulWidget {
  const ScanMifareClassic({Key? key}) : super(key: key);

  @override
  State<ScanMifareClassic> createState() => _ScanMifareClassicState();
}

class _ScanMifareClassicState extends State<ScanMifareClassic> with SingleTickerProviderStateMixin {
  String _platformVersion = '';
  String firebaseinstanceid='';
        TextEditingController regnoController=TextEditingController();
      NFCAvailability _availability = NFCAvailability.not_supported;
      NFCTag? _tag;
      int result=1;
      String? _result, _writeResult,maindata;
      late TabController _tabController;
      List<ndef.NDEFRecord>? _records;

      @override
      void dispose() {
        _tabController.dispose();
        super.dispose();
      }

      @override
      void initState() {
        super.initState();
        if (!kIsWeb)
          _platformVersion =
              '${Platform.operatingSystem} ${Platform.operatingSystemVersion}';
        else
          _platformVersion = 'Web';
        initPlatformState();
        _tabController = new TabController(length: 2, vsync: this);
        _records = [];
      }

      // Platform messages are asynchronous, so we initialize in an async method.
      Future<void> initPlatformState() async {
        NFCAvailability availability;
        try {
          availability = await FlutterNfcKit.nfcAvailability;
        } on PlatformException {
          availability = NFCAvailability.not_supported;
        }

        // If the widget was removed from the tree while the asynchronous platform
        // message was in flight, we want to discard the reply rather than calling
        // setState to update our non-existent appearance.
        if (!mounted) return;

        setState(() {
          // _platformVersion = platformVersion;
          _availability = availability;
        });
      }

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          home: Scaffold(
            
            appBar: AppBar(
              
              
              title:  Center(child: Row(
                children: [
                                      Image.asset('assets/tinkertech.jpg',fit: BoxFit.cover, height: 32),

                  Text('    Verify'),
                ],
              )),
            ),
            body: Scrollbar(
                child: SingleChildScrollView(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                  const SizedBox(height: 20),
                  // TextField(
                  //     controller: regnoController,
                  //     decoration: InputDecoration(
                  //   border: OutlineInputBorder(),
                  //   labelText: 'Reg No',
                  // ),
                  //   ),
                  // Text('Running on: $_platformVersion\nNFC: $_availability'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        NFCTag tag = await FlutterNfcKit.poll();
                        setState(() {
                          _tag = tag;
                        });
                        await FlutterNfcKit.setIosAlertMessage("Working on it...");
                        if (tag.standard == "ISO 14443-4 (Type B)") {
                          String result1 =
                              await FlutterNfcKit.transceive("00B0950000");
                          String result2 = await FlutterNfcKit.transceive(
                              "00A4040009A00000000386980701");
                          setState(() {
                            _result = '1: $result1\n2: $result2\n';
                          });
                        } else if (tag.type == NFCTagType.iso18092) {
                          String result1 =
                              await FlutterNfcKit.transceive("060080080100");
                          setState(() {
                            _result = '1: $result1\n';
                          });
                        } else if (tag.type == NFCTagType.mifare_ultralight ||
                            tag.type == NFCTagType.mifare_classic ||
                            tag.type == NFCTagType.iso15693) {    
                          var ndefRecords = await FlutterNfcKit.readNDEFRecords();
                          var ndefString = '';
                          for (int i = 0; i < ndefRecords.length; i++) {
                            ndefString += '${i + 1}: ${ndefRecords[i]}\n';
                          }
                          setState(() {
                            _result = ndefString;
                          });
                        } else if (tag.type == NFCTagType.webusb) {
                          var r = await FlutterNfcKit.transceive(
                              "00A4040006D27600012401");
                          print(r);
                        }
                      } catch (e) {
                        setState(() {
                          _result = 'error: $e';
                        });
                      }

                      // Pretend that we are working
                      if (!kIsWeb) sleep(new Duration(seconds: 1));
                      await FlutterNfcKit.finish(iosAlertMessage: "Finished!");
                      var tagidget=await FirebaseFirestore.instance.collection('tagid').doc('XV3TXph2MLT0cBzuWNr5').get();
                      var tagmapget= await FirebaseFirestore.instance.collection('tagmap').doc('jYBWvFrpb1QjIwBHhql7').get();
                      var entrypointkey= await FirebaseFirestore.instance.collection('entry').doc('l1nqyFzkPCKoUqhU1eML').get();
                      Map<String,dynamic> mtagidget=tagidget.data()!;
                      Map<String,dynamic> mtagmapget=tagmapget.data()!;
                      Map<String,dynamic> mentrypointkey=entrypointkey.data()!;
                      Map<dynamic,dynamic> alltagidget=mtagidget['Mappingidtoid'];
                      Map<dynamic,dynamic> alltagmapget=mtagmapget['Mapping'];
                      Map<dynamic,dynamic> allentrypointkey=mentrypointkey['map'];
                      dynamic regno=alltagidget[_tag!.id];
                      print('herreeeeeeeeeeeeeeeeee');
                      print(regno);
                      dynamic dbtagid=alltagmapget[regno.toString()];
                      print(dbtagid);
                      //now verify the correctness of db tag id and actual chip if same give data
                      if(dbtagid.toString()==_tag!.id.toString())
                      {
                        dynamic instanceid= allentrypointkey[regno.toString()];
                        print(instanceid.toString());
                        setState(() {
                          firebaseinstanceid=instanceid.toString();
                        });
                      }
                      else{
                        setState(() {
                          result=0;
                        });
                      }
                      

                      // //map reg no to chip id
                      // FirebaseFirestore.instance.collection('tagmap').doc('jYBWvFrpb1QjIwBHhql7').update({
                      //   'Mapping':{regnoController.text.toString():_tag!.id}
                      // });
                      // // map chip id to reg no
                      // FirebaseFirestore.instance.collection('tagid').doc('XV3TXph2MLT0cBzuWNr5').update({
                      //   'Mappingidtoid':{_tag!.id:regnoController.text.toString()}
                      // });
                    },
                    child: Text('Click here to verify your tag'),
                    
                  ),
                  const SizedBox(height: 10),
                  
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _tag != null
                          ? Text(
                              'ID: ${_tag!.id}\n ${maindata.toString()}\n instance id ${firebaseinstanceid}')
                          : const Text('No tag polled yet.')),
                          ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text('Back')),
                          ElevatedButton(onPressed: () async {
                            // List<String> _sector = await NfcClassicMifare.readSector(sectorIndex:1);
                            // print(_sector.toString());
                            linkToPage(firebaseinstanceid.toString(),result);
                          }, child: Text('View Result')),
                          
                ]
                
                )))),
                
          ),
        );
      } 
      Future<void> linkToPage(String maildata,int result) async {
    print('-----------------------');
if (result==0){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Tag'),));return;

}
          print(maildata.toString());
          String refid=maildata.toString().trim();
          var resultData= await FirebaseFirestore.instance.collection('users').doc(refid).get();
          Map<String, dynamic> m=resultData.data()!;
          String rno=m['reg_no'].toString();
          print(rno);
          String prnno=m['prn'].toString();
          String seatno=m['seat_no'].toString();
          List<dynamic> childidList=m['childid'];
          print(childidList);
          List<String> allcgpi=[];
          List<dynamic> refmarksheet=m['allmarksheet'];
          List<String> allMarkSheet=[];
          for(var i=0;i<refmarksheet.length.toInt();i++)
          {
            setState(() {
              allMarkSheet.add(refmarksheet[i.toInt()].toString());
            });
            
          }
          print(childidList.length.toInt());
          for(var i=0;i<childidList.length.toInt();i++){
            var r= await FirebaseFirestore.instance.collection('forms').doc(childidList[i].toString().trim()).get();
            Map<String,dynamic> mdata=r.data()!;
            if(allcgpi.length==childidList.length.toInt())
              break;
            setState(() {
              allcgpi.add(mdata['sgpi'].toString());
            });
          }
          print('before');
          print(allcgpi);
          print('after');
          print('---------------');
          print(allMarkSheet);
          Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                       Details(maildata.toString(),rno.toString(),prnno.toString(),result,seatno),
                    ));
  }
}
    