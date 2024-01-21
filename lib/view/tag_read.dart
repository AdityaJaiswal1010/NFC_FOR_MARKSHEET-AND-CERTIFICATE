import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encryptor/encryptor.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:app/constant/key.dart';
import 'package:app/utility/extensions.dart';
import 'package:app/view/ViewAllMarksheet.dart';
import 'package:app/view/common/form_row.dart';
import 'package:app/view/common/nfc_session.dart';
import 'package:app/view/common/readDetailPage.dart';
import 'package:app/view/ndef_record.dart';
import 'package:app/view/viewDetailRecord.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:contacts_service/contacts_service.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'display_data.dart';

class TagReadModel with ChangeNotifier {
  NfcTag? tag;

  Map<String, dynamic>? additionalData;

  Future<String?> handleTag(NfcTag tag) async {
    this.tag = tag;
    additionalData = {};

    Object? tech;

    // todo: more additional data
    if (Platform.isIOS) {
      tech = FeliCa.from(tag);
      if (tech is FeliCa) {
        final polling = await tech.polling(
          systemCode: tech.currentSystemCode,
          requestCode: FeliCaPollingRequestCode.noRequest,
          timeSlot: FeliCaPollingTimeSlot.max1,
        );
        additionalData!['manufacturerParameter'] =
            polling.manufacturerParameter;
      }
    }

    notifyListeners();
    return '[Tag - Read] is completed.';
  }
}

class TagReadPage extends StatelessWidget {
  static Widget withDependency() => ChangeNotifierProvider<TagReadModel>(
        create: (context) => TagReadModel(),
        child: TagReadPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Row(
          children: [
            // Image.asset('assets/tinkertech.jpg', fit: BoxFit.cover, height: 32),
            Text('    Scan Smart Doc'),
          ],
        )),
      ),
      body: ListView(
        padding: EdgeInsets.all(2),
        children: [
          FormSection(
            children: [
              Center(
                child: Container(
                  
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(30),
                    // color: Theme.of(context).hintColor,
                    color: Colors.amber,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(5, 5),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    
                    onPressed: () {
                      startSession(
                  context: context,
                  handleTag: Provider.of<TagReadModel>(context, listen: false)
                      .handleTag,
                );
                style: ElevatedButton.styleFrom(
    backgroundColor: Colors.amber,
  );
                    },
                    child: Column(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.nfcSymbol,
                          size: 50,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Start Session',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // FormRow(
              //   title: Text('Start Session',
              //       style: TextStyle(
              //           color: Theme.of(context).colorScheme.primary)),
              //   onTap: () => startSession(
              //     context: context,
              //     handleTag: Provider.of<TagReadModel>(context, listen: false)
              //         .handleTag,
              //   ),
              // ),
            ],
          ),
          // consider: Selector<Tuple<{TAG}, {ADDITIONAL_DATA}>>
          Consumer<TagReadModel>(builder: (context, model, _) {
            final tag = model.tag;
            final additionalData = model.additionalData;
            if (tag != null && additionalData != null)
              return _TagInfo(tag, additionalData);
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

class _TagInfo extends StatefulWidget {
  _TagInfo(this.tag, this.additionalData);

  final NfcTag tag;

  final Map<String, dynamic> additionalData;

  @override
  State<_TagInfo> createState() => _TagInfoState();
}

class _TagInfoState extends State<_TagInfo> {
  int resultedvalue = 0;
  @override
  Widget build(BuildContext context) {
    List<String> subject = [];
    List<String> subjectCode = [];
    List<String> subjectGrade = [];
    List<String> subjectMarks = [];
    List<List<String>> allSubjects = [];
    List<List<String>> allSubjectCode = [];
    List<List<String>> allSubjectGrade = [];
    List<List<String>> allSubjectMarks = [];
    String imageData='';
    String uniqueRegNo = '';
    String personalDetails = '';
    int indexToMarksheetDetails = 0;
    String appender = '';
    int count = 0;
    String maildata = '';
    int callFlag = 1;
    String fname = '';
    String lname = '';
    int res = 0;
    String phonenum = '';
    final tagWidgets = <Widget>[];
    final ndefWidgets = <Widget>[];
    String comparefromchip = '';
    String comparefromdb = '';
    Object? tech;
    late Uint8List byteData = Uint8List(0);
    

    tech = Ndef.from(widget.tag);
    if (tech is Ndef) {
      final cachedMessage = tech.cachedMessage;
      final canMakeReadOnly = tech.additionalData['canMakeReadOnly'] as bool?;
      final type = tech.additionalData['type'] as String?;
      

      if (cachedMessage != null)
        Iterable.generate(cachedMessage.records.length).forEach((i) async {
          final record = cachedMessage.records[i];
          final info = NdefRecordInfo.fromNdef(record);
          String v = '${info.subtitle}';
          int latch = 0;
          String first = '';
          String last = '';
          for (int i = 0; i < v.length; i++) {
            if (v[i] == ']'||v[i]=='{') {
              break;
            }
            if (v[i] == ')') {
              first += v[i];

              latch = 1;
              i++;
              first += v[i];
              i++;
              first += v[i];
            } else if (latch == 1) {
              last += v[i];
            } else {
              first += v[i];
            }
          }
          print('here is actual enc data');
          print(last);
          print(first);
          var key = 'Key to encrypt and decrpyt the plain text';
          print('fetched encrypted part');
          print(last);
          var decrypted = Encryptor.decrypt(key, last.trim());
          print('actual data');
          print(decrypted.toString());

          String vari = first +
              decrypted.toString().trim()+
              ']';
          print(vari);
          print('here is the subtitle');
          print('${String.fromCharCodes(record.payload).length}');
          print(info.subtitle.length);
          String namedata = '';

          print(vari);
          print('vari length '+v.length.toString());
          print('last char'+v[v.length-1]);
          for (int i = 1; i < vari.length; i++) {
            if (vari[i] == ':') {
              setState(() {
                uniqueRegNo = namedata;
                namedata = '';
              });
            }
            if (vari[i] == ')') {
              setState(() {
                personalDetails = namedata;
                namedata = '';
                for (int temp = i; temp < vari.length; temp++) {
                  if (vari[temp] != '[') {
                    continue;
                  } else {
                    indexToMarksheetDetails = temp + 1;
                    break;
                  }
                }
              });
              break;
            }
            namedata += vari[i];
          }
          // for seperator
          String temp='';
          int c=0;
          for(int ind = indexToMarksheetDetails;ind<vari.length;ind++){
            
            if(vari[ind]==']')
            {
              temp+=vari[ind];
              break;
            }
             
            if(vari[ind]==',')
              {
                c++;
                if(c==16)
                {
                  c=0;
                  temp+=']';
                  temp+='[';
                  continue;
                }
              }
              
            temp+=vari[ind];
          }
          vari=temp;
          print('new vari');
          print(vari);
          for (int i = 0; i < vari.length; i++) {
            if (vari[i] == ',' && count < 4) {
              subject.add(appender);
              count++;
              appender = '';
              continue;
            }
            if (vari[i] == ',' && count < 8 && count >= 4) {
              subjectCode.add(appender);
              appender = '';
              count++;
              continue;
            }
            if (vari[i] == ',' && count < 12 && count >= 8) {
              subjectGrade.add(appender);
              appender = '';
              count++;
              continue;
            }
            if (vari[i] == ',' && count < 16 && count >= 12) {
              subjectMarks.add(appender);
              appender = '';
              count++;
              
              continue;
            }
            if (vari[i] == ']') {
              i++;
              count = 0;
              if (appender != '') subjectMarks.add(appender);
              appender = '';
              allSubjects.add(subject);
              allSubjectMarks.add(subjectMarks);
              allSubjectCode.add(subjectCode);
              allSubjectGrade.add(subjectGrade);
              subject = [];
              subjectCode = [];
              subjectGrade = [];
              subjectMarks = [];
              continue;
            }
            appender += vari[i];
            if(vari[i]=='{')
              {
                setState(() {
                  imageData=vari.substring(i+1,vari.length-1);
                });
                i=vari.length;
              }
          }
          int f=0;
          print('length of v'+v.length.toString());
          for (int ind = 0; ind < v.length; ind++) {
            if(v[ind]!='{')
            {

              continue;
            }
            if(v[ind]=='{')
            {
              imageData=v.substring(ind+1,v.length-1);
              print(imageData);
              break;
              // f=1;
              // continue;
            }
            
            if(f==1 && ind<v.length-1){
              print(v[ind]);
              setState(() {
                imageData=imageData+v[ind];
              });
              
            }
          }
          print(imageData.toString().length);
          print('all the detail data\n');
          print(imageData[imageData.length-1]);
          setState(() {
            byteData=base64Decode(imageData);
          });
          print(byteData);
          print(allSubjects);
          print(allSubjectCode);
          print(allSubjectGrade);
          print(allSubjectMarks);
          print(personalDetails);
          print(uniqueRegNo);

          allSubjects[0][0]='ENGINEERING MATHEMATICS-I';
          print('updated value');
          print(allSubjects);
          int j = 0;
          for (j = 0; j < namedata.length; j++) {
            if (namedata[j] == ' ') break;
            fname += namedata[j];
          }

          for (j = j + 1; j < namedata.length; j++) {
            if (namedata[j] == ' ') break;
            lname += namedata[j];
          }

          int flag = 1;
          for (int i = 1; i < vari.length; i++) {
            if (vari[i] == ')') break;
            if (flag == 1 && vari[i] != ':') continue;
            if (vari[i] == ':') {
              flag = 0;
              continue;
            }
            phonenum += vari[i];
          }

          flag = 1;
          for (int i = 1; i < vari.length; i++) {
            if (vari[i] != ')' && flag == 1) continue;
            if (vari[i] == ')') {
              flag = 0;
              continue;
            }
            if (flag == 0) {
              maildata += vari[i];
            }
          }
          print('heyyyyyyyyyyyyyyyyyyyy');
          setState(() {
            res = 0;
          });
          
          ndefWidgets.add(
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Registration Number - ',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      uniqueRegNo,
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                
                SizedBox(height: 12),
                // Row(
                //   children: [
                //     Text('Key- '),
                //     Text(maildata),
                //   ],

                // ),
                // SizedBox(height: 12),
                // for(int i=0;i<childidList.length;i++)
                // Row(

                //   children: [
                //     Text('Sem ${i} Cgpa- '),
                //     Text(allcgpi[i]),
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
        });
    }
    // res=(checkBothChipNDbId(widget.tag,fname)) as int ;
    print('gotttttttttttttttttttttt');
    // print(got);
    print(res);

    Future<int> rrrr = checkBothChipNDbId(widget.tag, uniqueRegNo);
    return Container(
      decoration: BoxDecoration(
                    borderRadius:BorderRadius.only(
       topLeft:Radius.circular(500),
       topRight :Radius.circular(500),
       bottomLeft :Radius.circular(500),
       bottomRight :Radius.circular(500),

      )),
      child: Column(
        
        children: [
          SizedBox(height: 50,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                  // primary: Color(0xFF00E5FF),
                  fixedSize: Size(250, 250)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReadRecordDetail(
                          ndefWidgets,
                          maildata,
                          fname,
                          lname,
                          phonenum,
                          rrrr,
                          resultedvalue,
                          uniqueRegNo,
                          allSubjects,
                          allSubjectCode,
                          allSubjectMarks,
                          allSubjectGrade,
                          personalDetails,
                          byteData
                          
                          ),
                    ));
              },
              child: Text(
                'Details',
                style: TextStyle(fontSize: 50,color: Colors.black),
              ))
        ],
      ),
    );

    //   return Column(
    //   children: [
    //     // FormSection(
    //     //   header: Text('TAG'),
    //     //   children: tagWidgets,
    //     // ),
    //     if (ndefWidgets.isNotEmpty)
    //       FormSection(
    //         header: Text('TAG'),
    //         children: ndefWidgets,
    //     //     if(callFlag==1){
    //     //   linkToPage(maildata,fname,lname,phonenum);
    //     //   setState(() {
    //     //     callFlag=0;
    //     //   });

    //     // }
    //       ),

    //       ElevatedButton(

    //       child: Text('View Detail Record',style: TextStyle(fontSize: 50),),
    //       style: ElevatedButton.styleFrom(
    //         // primary: Color(0xFF00E5FF),
    //         fixedSize: Size(250, 250)

    //       ),
    //       onPressed: () {
    //         Navigator.push(context, MaterialPageRoute(
    //                       builder: (context) => viewDetailRecord(maildata, fname, lname, phonenum)));
    //         // linkToPage(maildata, fname, lname, phonenum);
    //       },
    //     ),
    //     SizedBox(height: 50,),
    //     ElevatedButton(
    //       child: Text('View All Marksheets',style: TextStyle(fontSize: 50),),
    //       style: ElevatedButton.styleFrom(
    //         // primary: Color(0xFF00E5FF),
    //         fixedSize: Size(250, 250)
    //       ),
    //       onPressed: () {
    //         Navigator.push(context, MaterialPageRoute(
    //                       builder: (context) => ViewAllMarksheet(maildata, fname, lname, phonenum)));
    //         // linkToPage(maildata, fname, lname, phonenum);
    //       },
    //     ),
    //   ],
    // );

    //   return Column(
    //     children: [
    //       Text('Scam')
    //     ],
    //   );
  }

  Future<int> checkBothChipNDbId(NfcTag tag, String fname) async {
    String comparefromchip = '';
    String comparefromdb = '';
    var dbMap = await FirebaseFirestore.instance
        .collection('tagmap')
        .doc('jYBWvFrpb1QjIwBHhql7')
        .get();
    Map<String, dynamic> m = dbMap.data()!;
    Map<dynamic, dynamic> alldataofmap = m['Mapping'];

    String id =
        '${(NfcA.from(tag)?.identifier ?? NfcB.from(tag)?.identifier ?? NfcF.from(tag)?.identifier ?? NfcV.from(tag)?.identifier ?? Uint8List(0)).toHexString()}'
            .toString();
    String perfectid = '';
    int pointer = 0;
    for (int i = 1; i < id.length; i++) {
      if (id[i] == 'x') {
      } else if (id[i] == ' ') {
      } else {
        perfectid += id[i];
      }
    }
    print('perfecccccccccccccccccccccccct');
    print(perfectid);
    String actualid = '';
    int counter = 0;
    for (int i = 0; i < perfectid.length; i++) {
      counter = counter + 1;
      if (counter > 2) {
        counter = 0;
      } else {
        actualid += perfectid[i];
      }
    }
    print('below is actual id interpretes from chip');
    print(actualid);

    comparefromchip = actualid.toString();

    print(fname);
    print(alldataofmap[fname]);

    comparefromdb = alldataofmap[fname].toString();
    print('db id');
    print(comparefromdb);
    if (comparefromchip == comparefromdb) {
      print('yes chip matched');
      setState(() {
        resultedvalue = 1;
      });
      return 1;
    } else {
      print('chip unmatched');
      setState(() {
        resultedvalue = 0;
      });
      return 0;
    }
  }

  
}

Future<void> saveContactInPhone(
    String fname, String lname, String phonenum, String maildata) async {
  try {
    print("saving Conatct");
    PermissionStatus permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted) {
      await Permission.contacts.request();
      PermissionStatus permission = await Permission.contacts.status;

      if (permission == PermissionStatus.granted) {
        Contact newContact = new Contact();
        newContact.givenName = fname + lname;
        newContact.emails = [Item(label: "email", value: maildata)];

        newContact.phones = [Item(label: "mobile", value: phonenum)];

        await ContactsService.addContact(newContact);
      } else {
        //_handleInvalidPermissions(context);
      }
    } else {
      Contact newContact = new Contact();
      newContact.givenName = fname + lname;
      newContact.emails = [Item(label: "email", value: maildata)];

      newContact.phones = [Item(label: "mobile", value: phonenum)];

      await ContactsService.addContact(newContact);
    }
    print("object");
  } catch (e) {
    print(e);
  }
}

_savedata(String fname, String lname, String phonenum, String maildata) async {
  
}

String _getTechListString(NfcTag tag) {
  final techList = <String>[];
  if (tag.data.containsKey('nfca')) techList.add('NfcA');
  if (tag.data.containsKey('nfcb')) techList.add('NfcB');
  if (tag.data.containsKey('nfcf')) techList.add('NfcF');
  if (tag.data.containsKey('nfcv')) techList.add('NfcV');
  if (tag.data.containsKey('isodep')) techList.add('IsoDep');
  if (tag.data.containsKey('mifareclassic')) techList.add('MifareClassic');
  if (tag.data.containsKey('mifareultralight'))
    techList.add('MifareUltralight');
  if (tag.data.containsKey('ndef')) techList.add('Ndef');
  if (tag.data.containsKey('ndefformatable')) techList.add('NdefFormatable');
  return techList.join(' / ');
}

String _getMiFareClassicTypeString(int code) {
  switch (code) {
    case 0:
      return 'Classic';
    case 1:
      return 'Plus';
    case 2:
      return 'Pro';
    default:
      return 'Unknown';
  }
}

String _getMiFareUltralightTypeString(int code) {
  switch (code) {
    case 1:
      return 'Ultralight';
    case 2:
      return 'Ultralight C';
    default:
      return 'Unknown';
  }
}

String _getMiFareFamilyString(MiFareFamily family) {
  switch (family) {
    case MiFareFamily.unknown:
      return 'Unknown';
    case MiFareFamily.ultralight:
      return 'Ultralight';
    case MiFareFamily.plus:
      return 'Plus';
    case MiFareFamily.desfire:
      return 'Desfire';
    default:
      return 'Unknown';
  }
}

String _getNdefType(String code) {
  switch (code) {
    case 'org.nfcforum.ndef.type1':
      return 'NFC Forum Tag Type 1';
    case 'org.nfcforum.ndef.type2':
      return 'NFC Forum Tag Type 2';
    case 'org.nfcforum.ndef.type3':
      return 'NFC Forum Tag Type 3';
    case 'org.nfcforum.ndef.type4':
      return 'NFC Forum Tag Type 4';
    default:
      return 'Unknown';
  }
}
