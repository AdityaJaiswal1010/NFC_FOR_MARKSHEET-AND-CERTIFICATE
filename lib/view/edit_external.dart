import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encryptor/encryptor.dart';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:app/constant/key.dart';
import 'package:app/model/record.dart';
import 'package:app/model/write_record.dart';
import 'package:app/repository/repository.dart';
import 'package:app/view/successRegNo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart'  as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'error_SplashScreen.dart';

class EditExternalModel with ChangeNotifier {
  EditExternalModel(this._repo, this.old) {
    if (old == null) return;
    final record = ExternalRecord.fromNdef(old!.record);
    firstController.text = record.domain;
    lastController.text = record.type;
    emailController.text = record.dataString;
    // numController.text=record.number;
  }

  final Repository _repo;
  final WriteRecord? old;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  // final TextEditingController numController=TextEditingController();
  final TextEditingController emailController = TextEditingController();
  

  Future<Object> save() async {
     

    var response = await FirebaseFirestore.instance.collection('entry').doc('l1nqyFzkPCKoUqhU1eML').get(); 
    
    Map<String, dynamic> m=response.data()!;
  print(m['map']);
  Map<String,dynamic> allres=m['map'];
  // print(m.keys.runtimeType);
  print(allres['12345']);
  print(allres[emailController.text.toString()]);
  var userresponse= await FirebaseFirestore.instance.collection('users').doc(allres[emailController.text.toString()].toString()).get();
  Map<String,dynamic> um=userresponse.data()!;
  int regNo=um['reg_no'];
  int seatNo=um['seat_no'];
  String image=um['image'];
  final resp = await http.get(Uri.parse(image.toString()));
  final bytes = resp.bodyBytes;
  Uint8List? imageByte = Uint8List.fromList(bytes);
  print('Actual Image byte size ${imageByte.length}');
  print(imageByte);
  String base64String = base64Encode(imageByte);
  print('String ${base64String.length}');
  print(base64String);
  String candidateDetails=um['candidate_name']+','+um['father_name']+','+um['mother_name']+','+um['university']+','+um['degree']+','+um['program'];
  String degree=um['degree'];
  String sub_name='';
  String sub_code='';
  String sub_grade='';
  String sub_marks;
    String finalString='';
    String actualStringToBeStored='';
  for(int i=0;i<um['childid'].length;i++)
  {
    String childid=um['childid'][i];
  var childidDetailData= await FirebaseFirestore.instance.collection('forms').doc(childid.toString()).get();
  Map<String,dynamic> childDetail= childidDetailData.data()!;
  String course_1_name=childDetail['course_name_1'];
  String course_2_name=childDetail['course_name_2'];
  String course_3_name=childDetail['course_name_3'];
  String course_4_name=childDetail['course_name_4'];
  finalString+=course_1_name+','+course_2_name+','+course_3_name+','+course_4_name+',';
  // finalString+='00000000000000'+BE_Comps[course_1_name]!.toString()+','+BE_Comps[course_2_name]!.toString()+','+BE_Comps[course_3_name]!.toString()+','+BE_Comps[course_4_name]!.toString()+',';
  String course_1_code=childDetail['course_code_1'];
  String course_2_code=childDetail['course_code_2'];
  String course_3_code=childDetail['course_code_3'];
  String course_4_code=childDetail['course_code_4'];
  finalString+=course_1_code+','+course_2_code+','+course_3_code+','+course_4_code+',';
  String course_1_grade=childDetail['grade_1'];
  String course_2_grade=childDetail['grade_2'];
  String course_3_grade=childDetail['grade_3'];
  String course_4_grade=childDetail['grade_4'];
  finalString+=course_1_grade+','+course_2_grade+','+course_3_grade+','+course_4_grade+',';
  String course_1_marks=childDetail['marks_obtained_UA_1'].toString();
  String course_2_marks=childDetail['marks_obtained_UA_2'].toString();
  String course_3_marks=childDetail['marks_obtained_UA_3'].toString();
  String course_4_marks=childDetail['marks_obtained_UA_4'].toString();
  finalString+=course_1_marks+','+course_2_marks+','+course_3_marks+','+course_4_marks+',';
  actualStringToBeStored+=finalString;
  finalString='';
  // String course_1_max_marks=childDetail['max_marks_CA_1'].toString();
  // String course_2_max_marks=childDetail['max_marks_CA_2'].toString();
  // String course_3_max_marks=childDetail['max_marks_CA_3'].toString();
  // String course_4_max_marks=childDetail['max_marks_CA_4'].toString();
  // String course_1_credit=childDetail['credit_grade_point_1'].toString();
  // String course_2_credit=childDetail['credit_grade_point_2'].toString();
  // String course_3_credit=childDetail['credit_grade_point_3'].toString();
  // String course_4_credit=childDetail['credit_grade_point_4'].toString();
  }

  print(actualStringToBeStored);
  // final String encryptionKey = 'my 32 length key................';
  // final key = encrypt.Key.fromUtf8(encryptionKey);
  // final iv = encrypt.IV.fromLength(16);
  // final encrypter = encrypt.Encrypter(encrypt.AES(key));
  // final encrypted = encrypter.encrypt(actualStringToBeStored, iv: iv);

  // print(decrypted); 
  // print(encrypted.base64);
  // actualStringToBeStored=encrypted.base64.toString();






  //newest semi errored enc code
  print('here is the actual data');
  print(actualStringToBeStored.substring(0,actualStringToBeStored.length-1));
    var key = 'Key to encrypt and decrpyt the plain text';
  var encrypted = Encryptor.encrypt(key, actualStringToBeStored.substring(0,actualStringToBeStored.length-1));
  actualStringToBeStored='['+encrypted.toString().trim()+']{'+base64String+'}';
  print('after encryption');
  print(actualStringToBeStored);
  // String actualData=course_1_name+','+course_2_name+','+course_1_code+','+course_2_code+','+course_1_grade+','+course_2_grade+','+course_1_marks+','+course_2_marks+','+course_1_max_marks+','+course_2_max_marks+','+course_1_credit+','+course_2_credit;
  Map<String,String> converted={};
for (var item in m.keys)
  converted[item.toString()] = m[item].toString();
// Map<String, String> stringQueryParameters = Map<String, String>();
// m.forEach((key, value) => stringQueryParameters[key] = value!.toString());

// print(stringQueryParameters); // 12345
print(converted.runtimeType);
  var ref=converted[firstController.text.toString()].toString();
  print(ref.toString());
  //  DocumentSnapshot result = await FirebaseFirestore.instance.collection('users').doc(ref).get(); 
  //  print(result['reg_no'].toString());
  //  print(ref.toString());
    if (!formKey.currentState!.validate())
      throw('Form is invalid.');

    final record = ExternalRecord(
     
      // domain: ref.toString(),
      domain: regNo.toString(),
      // type: result['reg_no'].toString(),
      type: candidateDetails.toString(),
      // number:numController.text,
      data: Uint8List.fromList(utf8.encode(actualStringToBeStored.toString())),
      
    );

    return _repo.createOrUpdateWriteRecord(WriteRecord(
      id: old?.id,
      record: record.toNdef(),
    ));
  }
}

class EditExternalPage extends StatelessWidget {
  static Widget withDependency([WriteRecord? record]) => ChangeNotifierProvider<EditExternalModel>(
    create: (context) => EditExternalModel(Provider.of(context, listen: false), record),
    child: EditExternalPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Row(
          children: [
                                                  // Image.asset('assets/tinkertech.jpg',fit: BoxFit.cover, height: 32),

            Text('    Edit Info'),
          ],
        )),
      ),
      body: Form(
        key: Provider.of<EditExternalModel>(context, listen: false).formKey,
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: Provider.of<EditExternalModel>(context, listen: false).emailController,
              decoration: InputDecoration(labelText: 'Enter Reg No',  helperText: ''),
              keyboardType: TextInputType.text,
              validator: (value) => value?.isNotEmpty != true ? 'Required' : null,
            ),
            SizedBox(height: 12),
            // TextFormField(
            //   controller: Provider.of<EditExternalModel>(context, listen: false).lastController,
            //   decoration: InputDecoration(labelText: 'Phone', helperText: ''),
            //   keyboardType: TextInputType.text,
            //   validator: (value) => value?.isNotEmpty != true ? 'Required' : null,
            // ),
            // SizedBox(height: 12),
            // // TextFormField(
            // //   controller: Provider.of<EditExternalModel>(context, listen: false).numController,
            // //   decoration: InputDecoration(labelText: 'Phone', helperText: ''),
            // //   keyboardType: TextInputType.number,
            // //   validator: (value) => value?.isNotEmpty != true ? 'Required' : null,
            // // ),
            // // SizedBox(height: 12),
            // TextFormField(
            //   controller: Provider.of<EditExternalModel>(context, listen: false).emailController,
            //   decoration: InputDecoration(labelText: 'Email', helperText: ''),
            //   keyboardType: TextInputType.text,
            //   validator: (value) => value?.isNotEmpty != true ? 'Required' : null,
            // ),
            // SizedBox(height: 12),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                var response = await FirebaseFirestore.instance.collection('entry').doc('l1nqyFzkPCKoUqhU1eML').get(); 
    
    Map<String, dynamic> m=response.data()!;
  print(m['map']);
  Map<String,dynamic> allres=m['map'];
  // print(m.keys.runtimeType);
  print(allres['12345']);
  print('the provider');
  print(Provider.of<EditExternalModel>(context, listen: false).emailController.text.toString());
  String temp=Provider.of<EditExternalModel>(context, listen: false).emailController.text.toString();
   if(allres[temp.toString()]==null || allres[temp.toString()]=='')
    Navigator.push(context, MaterialPageRoute(
                          builder: (context) => errorSplashScreen()));
    else{
Provider.of<EditExternalModel>(context, listen: false).save()
                .then((_) => Navigator.push(context, MaterialPageRoute(
                          builder: (context) => successRegNo())))
                .catchError((e) => print('=== $e ==='));
    }
                
              } 
            ),
          ],
        ), 
     ),
);
}
}

