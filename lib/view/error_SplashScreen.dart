import 'dart:async';

import 'package:app/view/ndef_write.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class errorSplashScreen extends StatefulWidget {
  const errorSplashScreen({Key? key}) : super(key: key);

  @override
  State<errorSplashScreen> createState() => _errorSplashScreenState();
}

class _errorSplashScreenState extends State<errorSplashScreen> {
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
              Image.asset("assets/animation_lkipglzm_small.gif", 
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
                "Invalid",
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
