import 'dart:convert';


import 'dart:typed_data';

import 'package:app/model/record.dart';
import 'package:app/model/write_record.dart';
import 'package:app/repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      type: seatNo.toString(),
      // number:numController.text,
      data: Uint8List.fromList(utf8.encode(allres[emailController.text.toString()].toString())),
      
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
        title: Text('Edit Info'),
      ),
      body: Form(
        key: Provider.of<EditExternalModel>(context, listen: false).formKey,
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: Provider.of<EditExternalModel>(context, listen: false).emailController,
              decoration: InputDecoration(labelText: 'Enter Reg. No',  helperText: ''),
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
              onPressed: () => Provider.of<EditExternalModel>(context, listen: false).save()
                .then((_) => Navigator.pop(context))
                .catchError((e) => print('=== $e ===')),
            ),
          ],
        ), 
     ),
);
}
}