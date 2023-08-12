import 'dart:async';

import 'package:app/view/ndef_write.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class successRegNo extends StatefulWidget {
  const successRegNo({Key? key}) : super(key: key);

  @override
  State<successRegNo> createState() => _successRegNoState();
}

class _successRegNoState extends State<successRegNo> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      // Navigator.push(context, MaterialPageRoute(
      //                     builder: (context) => NdefWritePage.withDependency(),
      //                   ));
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       fit: BoxFit.cover,
        //       image: NetworkImage(
        //           "https://i.pinimg.com/564x/b0/4c/c6/b04cc64b420bdcedee3cc48160abc3f5.jpg")),
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/animation_lkipfwjq_small.gif", 
                        gaplessPlayback: true, 
                        fit: BoxFit.fill,
                        height: 300,
                        width: 300,
                        ),
              // Icon(FontAwesomeIcons.tasks),
              SizedBox(
                width: 20,
              ),
              Text(
                "Valid",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Reg No",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
