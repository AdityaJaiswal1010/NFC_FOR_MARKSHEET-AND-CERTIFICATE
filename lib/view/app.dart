// // import 'dart:html';
// import 'dart:io';


// import 'package:app/repository/repository.dart';
// import 'package:app/view/ScanMifareClassic.dart';
// import 'package:app/view/about.dart';
// import 'package:app/view/common/form_row.dart';
// import 'package:app/view/ndef_format.dart';
// import 'package:app/view/ndef_write.dart';
// import 'package:app/view/ndef_write_lock.dart';
// import 'package:app/view/tag_read.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

// class App extends StatefulWidget {
//   static Future<Widget> withDependency() async {
//     final repo = await Repository.createInstance();
//     return MultiProvider(
//       providers: [
//         Provider<Repository>.value(
//           value: repo,
//         ),
//       ],
      
//       child: App(),
//     );
//   }

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: _Home(),
//       theme: _themeData(Brightness.light),
//       darkTheme: _themeData(Brightness.dark),
//     );
//   }
// }

// class _Home extends StatefulWidget {
//   @override
//   State<_Home> createState() => _HomeState();
// }

// class _HomeState extends State<_Home> {
//   bool isPressed = true;
//   TextEditingController regnoController=TextEditingController();
//   List <String> headers=[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       appBar: AppBar(
//         // backgroundColor: Colors.transparent,
//         title: Center(
//           child: Row(
//             children: [
//               // Icon(FontAwesomeIcons.nfcSymbol),
//               Image.asset('assets/tinkertech.jpg',fit: BoxFit.cover, height: 32),
//               Text('  Smart Docs' ,textAlign: TextAlign.center,),
//             ],
//           ),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(2),
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 30,),
//               Center(
                
//                 child: Container(
                  
//                   height: 350,
//                   width: 350,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: Color(0xFFAA00FF),
//                     boxShadow: const[
//                       BoxShadow(
//                         blurRadius: 30,
//                         offset: Offset(-28, -28),
//                         color: Colors.white,
                        
//                       ),
//                       BoxShadow(
//                         blurRadius: 30,
//                         offset: Offset(28, 28),
//                         color: Color(0xFFA7A9AF),
//                       )
//                     ]
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(
//                           builder: (context) => TagReadPage.withDependency(),
//                         ));
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Image.asset("assets/animation_lkh7vorm_small.gif", 
//                         // gaplessPlayback: true, 
//                         // fit: BoxFit.fill,
//                         // height: 300,
//                         // width: 300,
//                         // ),
//                         Center(child: Text('Scan Smart Doc',style: TextStyle(fontSize: 50),textAlign: TextAlign.center,),)
//                       ],
//                     ),
//                   )
//       //             child: FormRow(
                        
//       //                   emoji: Icon(FontAwesomeIcons.eye),
                        
//       //                   title: Image.asset("assets/animation_lkh7vorm_small.gif", 
//       // gaplessPlayback: true, 
//       // fit: BoxFit.fill
//       // ),
//       //                   trailing: Icon(Icons.chevron_right),
//       //                   onTap: () => Navigator.push(context, MaterialPageRoute(
//       //                     builder: (context) => TagReadPage.withDependency(),
//       //                   )),
//       //                 ),
//                 ),
//               ),
//               SizedBox(height: 50,),
//               Center(
//                 child: Column(
//                   children: [
//                     Text('Admin Login'),
//                     TextField(
//                       controller: regnoController,
//                       decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Reg No',
//                   ),
//                     ),
//                     ElevatedButton(onPressed:() async {
//                       var adminList=await FirebaseFirestore.instance.collection('admin').doc('F0BED80evF2AMUSso7mH').get();
//                       Map<String,dynamic> mdata=adminList.data()!;
//                       List<dynamic> alladmin=mdata['admins'];
//                       if(alladmin.contains(regnoController.text.toString())){
//                         Navigator.push(context, MaterialPageRoute(
//                           builder: (context) => NdefWritePage.withDependency(),
//                         ));
//                       }
//                       else{
//                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Admin'),));return null;
//                       }
//                     }, child: Text('Enter'))
//                   ],
//                 )
//               ),
//               SizedBox(height: 30,),
//               //scan mifare classic card

//             //   Center(
                
//             //     child: Container(
//             //       height: 350,
//             //       width: 350,
//             //       decoration: BoxDecoration(
                    
//             //         borderRadius: BorderRadius.circular(30),
//             //         color: Colors.amber,
//             //         boxShadow: const[
//             //           BoxShadow(
//             //             blurRadius: 30,
//             //             offset: Offset(-28, -28),
//             //             color: Colors.white,
                        
//             //           ),
//             //           BoxShadow(
//             //             blurRadius: 30,
//             //             offset: Offset(28, 28),
//             //             color: Color(0xFFA7A9AF),
//             //           )
//             //         ]
//             //       ),
//             //       child: ElevatedButton(
                    
//             //         onPressed: () {
//             //           Navigator.push(context, MaterialPageRoute(
//             //   builder: (context) => ScanMifareClassic(),
//             // ));
//             //         },
//             //         child: Column(
//             //           mainAxisAlignment: MainAxisAlignment.center,
//             //           crossAxisAlignment: CrossAxisAlignment.center,
//             //           children: [
//             //             // Image.asset("assets/animation_lkh7vorm_small.gif", 
//             //             // gaplessPlayback: true, 
//             //             // fit: BoxFit.fill,
//             //             // height: 300,
//             //             // width: 300,
//             //             // ),
//             //             Center(child: Text('Scan MiFare Tag',style: TextStyle(fontSize: 50,color: Colors.black),textAlign: TextAlign.center,),)
//             //           ],
//              //         ),
//             //       )
      
//             //     ),
//             //   ),







//       //         Center(
                
//       //           child: Container(
                  
//       //             height: 350,
//       //             width: 350,
//       //             decoration: BoxDecoration(
//       //               borderRadius: BorderRadius.circular(30),
//       //               color: Color(0xFFAA00FF),
//       //               boxShadow: const[
//       //                 BoxShadow(
//       //                   blurRadius: 30,
//       //                   offset: Offset(-28, -28),
//       //                   color: Colors.white,
                        
//       //                 ),
//       //                 BoxShadow(
//       //                   blurRadius: 30,
//       //                   offset: Offset(28, 28),
//       //                   color: Color(0xFFA7A9AF),
//       //                 )
//       //               ]
//       //             ),
//       //             child: ElevatedButton(
//       //               onPressed: () {
//       //                 Navigator.push(context, MaterialPageRoute(
//       //                     builder: (context) => NdefWritePage.withDependency(),
//       //                   ));
//       //               },
//       //               child: Column(
//       //                 mainAxisAlignment: MainAxisAlignment.center,
//       //                 crossAxisAlignment: CrossAxisAlignment.center,
//       //                 children: [
//       //                   // Image.asset("assets/animation_lkh9buac_small.gif", 
//       //                   // gaplessPlayback: true, 
//       //                   // fit: BoxFit.fill,
//       //                   // height: 300,
//       //                   // width: 300,
//       //                   // ),
//       //                   Text('Write Into Smart Doc',style: TextStyle(fontSize: 50),textAlign: TextAlign.center,)
//       //                 ],
//       //               ),
//       //             )
//       // //             child: FormRow(
                        
//       // //                   emoji: Icon(FontAwesomeIcons.eye),
                        
//       // //                   title: Image.asset("assets/animation_lkh7vorm_small.gif", 
//       // // gaplessPlayback: true, 
//       // // fit: BoxFit.fill
//       // // ),
//       // //                   trailing: Icon(Icons.chevron_right),
//       // //                   onTap: () => Navigator.push(context, MaterialPageRoute(
//       // //                     builder: (context) => TagReadPage.withDependency(),
//       // //                   )),
//       // //                 ),
//       //           ),
//       //         ),
//             ],
//           )
//           // FormSection(children: [
//           //   FormSection(
//           //     children: [
//           //       Container(
//           //         color: Color(0xFFAA00FF),
//           //         child: FormRow(
                    
//           //           emoji: Icon(FontAwesomeIcons.eye),
//           //           title: Text('  NFC Tag - Read'),
//           //           trailing: Icon(Icons.chevron_right),
//           //           onTap: () => Navigator.push(context, MaterialPageRoute(
//           //             builder: (context) => TagReadPage.withDependency(),
//           //           )),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//             // FormSection(
//             //   children: [
//             //     Container(
//             //       color: Color(0xFF00E5FF),
//             //       child: FormRow(
//             //         emoji: Icon(FontAwesomeIcons.pen),
//             //         title: Text('  NFC Tag - Write'),
//             //         trailing: Icon(Icons.chevron_right),
//             //         onTap: () => Navigator.push(context, MaterialPageRoute(
//             //           builder: (context) => NdefWritePage.withDependency(),
//             //         )),
//             //       ),
//             //     ),
                
//             //   ],
//             // ),
//             // FormSection(
//             //   children: [
//             //     Container(
//             //       color: Color(0xFFff4667),
//             //       child: FormRow(
//             //         emoji: Icon(FontAwesomeIcons.lock),
//             //         title: Text('  Export Csv Data'),
//             //         trailing: Icon(Icons.chevron_right),
//             //         onTap: () => exportData()
//             //       ),
//             //     ),
//             //   ],
//             // ),
//           //   if (Platform.isAndroid)
            
//           //     // FormSection(
//           //     //   children: [
//           //     //     FormRow(
//           //     //       emoji: Icon(FontAwesomeIcons.nfcDirectional),
//           //     //       title: Text('  NFC Tag - Format'),
//           //     //       trailing: Icon(Icons.chevron_right),
//           //     //       onTap: () => Navigator.push(context, MaterialPageRoute(
//           //     //         builder: (context) => NdefFormatPage.withDependency(),
//           //     //       )),
//           //     //     ),
//           //     //   ],
//           //     // ),
//           // ]),
//           // FormSection(children: [
//           //   FormRow(
//           //     emoji: Icon(Icons.open_in_new),
//           //     title: Text('  About'),
//           //     trailing: Icon(Icons.chevron_right),
//           //     onTap: () => Navigator.push(context, MaterialPageRoute(
//           //       builder: (context) => AboutPage(),
//           //     )),
//           //   ),
//           // ]),
//         // ],
//         //   ),
//         ],
//       ),
//     );
//   }
  
//   void exportData() async{
//     // final CollectionReference colref=FirebaseFirestore.instance.collection('forms');
//     final myData = await rootBundle.loadString('lib/res/marksheet.csv'); 

//     List<List<dynamic>> csvTable=CsvToListConverter().convert(myData);
//     List<List<dynamic>> data=[];
//     data=csvTable;
//     for(var i=0;i<data[0].length;i++)
//     {
//       setState(() {
//         headers.add(data[0][i]);
//       });
//     }
    
//     Map<String,String>? m={};
//     List<String> ls=[];
//     // 
//     // FirebaseFirestorDocumentSnapshot response = await FirebaseFirestore.instance.collection('entry').doc('l1nqyFzkPCKoUqhU1eML').get(); 
//     // m=response['map'];e.instance.collection('entry').doc('l1nqyFzkPCKoUqhU1eML').snapshots(data)
//     //   (QuerySnapshot? querySnapshot){
//     //   querySnapshot!.docs.forEach((document) { 
//     //     setState(() {
            
//     //         m=document['map'];
  
      
//     //     });
//     //   });
//     // }
//     // );
//     // if(m!.isNotEmpty)
//     // {
//     //   for(var i=0;i<m.length;i++)
//     // {
//     //   setState(() {
//     //     // ls.add(m[i]?.key);
//     //     m!.keys.forEach((key) {
//     //     ls.add(key.toString());
//     //   });
//     //   });
//     // }
//     // }
//     m['12345']='kCzCGjOzxuL034JneCKx';
//     FirebaseFirestore.instance.collection('entry').doc('l1nqyFzkPCKoUqhU1eML').set({
//       'map': m
//     });
//     print(headers);
//     print(m);
//     print(ls);
//     // for(var i=1;i<data.length;i++){
//     //   FirebaseFirestore.instance.collection('forms').add({
//     //     'name': data[i][0],
//     //     'email': data[i][1],

//     //   });
//     // }
//     int flag=1;
    
//     for(var i=1;i<data.length;i++)
//     {
      
      
//       // var docId=FirebaseFirestore.instance.collection('forms').doc();
//       // var docIdForUsers=FirebaseFirestore.instance.collection('users').doc();
//     setState(() {
//       flag=1;
//     });
//         FirebaseFirestore.instance.collection('forms').add({
//           for(var k=0;k<data[i].length;k++)
          
//                           headers[k]: data[i][k],
//                         }).then((DocumentReference docId){
//                           // for(int i=0;i<ls.length;i++)
//                           // {
//                           //   if(ls[i].toString()==data[i][0].toString())
//                           //   {
//                           //     setState(() {
//                           //       flag=0;
                                
//                           //     });
                              
//                           //   }
//                           //   if(flag==0)
//                           //     break;
//                           // }
//                           // print(flag);
//                          if(m.containsKey(data[i][0].toString())){
//                           FirebaseFirestore.instance.collection('users').doc(m[data[i][0]].toString()).update({
//                             'childid': FieldValue.arrayUnion([docId.toString()])
//                           });
//                           // setState(() {
//                           //   flag=1;
//                           // });
//                          }
//                          else{
//                           FirebaseFirestore.instance.collection('users').add({
//                           headers[0]: data[i][0],
//                           'childid': FieldValue.arrayUnion([docId.id.toString()]),
//                           headers[1]: data[i][1],
//                           headers[2]: data[i][2],
//                           headers[3]: data[i][3],
//                           headers[4]: data[i][4],
//                           // headers[5]: data[i][5],
//                           // headers[6]: data[i][6],
                        
//                       }).then((DocumentReference docRef) {
//                         setState(() {
//                           // m?.addAll({data[i][0].toString(): docRef.id.toString()});
                          
//                           m[data[i][0].toString()]=docRef.id.toString();
//                           ls.add(data[i][0].toString());
//                           print('------------------------------------------------------------');
//                           print(m);
//                           print(ls);
//                         });
//                       });
//                          }
//                         });
//     }
    
//   }
// }

// ThemeData _themeData(Brightness brightness) {
//   return ThemeData(
//     brightness: brightness,
//      // Matches app icon color.
//     primarySwatch:  MaterialColor(0xFF4D8CFE, <int, Color>{
//       50: Color(0xFFEAF1FF),
//       100: Color(0xFFCADDFF),
//       200: Color(0xFFA6C6FF),
//       300: Color(0xFF82AFFE),
//       400: Color(0xFF689DFE),
//       500: Color(0xFF4D8CFE),
//       600: Color(0xFF4684FE),
//       700: Color(0xFF3D79FE),
//       800: Color(0xFF346FFE),
//       900: Color(0xFF255CFD),
//     }),
//     appBarTheme: AppBarTheme(
//       systemOverlayStyle: SystemUiOverlayStyle.light,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       isDense: true,
//       border: OutlineInputBorder(),
//       contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//       errorStyle: TextStyle(height: 0.75),
//       helperStyle: TextStyle(height: 0.75),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
//       minimumSize: Size.fromHeight(40),
//     )),
//     scaffoldBackgroundColor: brightness == Brightness.dark
//       ? Colors.black
//       : null,
//     cardColor: brightness == Brightness.dark
//       ? Color.fromARGB(255, 28, 28, 30)
//       : null,
//     dialogTheme: DialogTheme(
//       backgroundColor: brightness == Brightness.dark
//         ? Color.fromARGB(255, 28, 28, 30)
//         : null,
//     ),
//     highlightColor: brightness == Brightness.dark
//       ? Color.fromARGB(255, 44, 44, 46)
//       : null,
//     splashFactory: NoSplash.splashFactory,
//   );
// }





































// import 'dart:io';
// import 'package:app/repository/repository.dart';
// import 'package:app/view/CloneDbContent.dart';
// import 'package:app/view/ImgByteImg.dart';
// import 'package:app/view/ScanMifareClassic.dart';
// import 'package:app/view/about.dart';
// import 'package:app/view/common/form_row.dart';
// import 'package:app/view/ndef_format.dart';
// import 'package:app/view/ndef_write.dart';
// import 'package:app/view/ndef_write_lock.dart';
// import 'package:app/view/paymentScreen.dart';
// import 'package:app/view/tag_read.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

// class App extends StatefulWidget {
//   static Future<Widget> withDependency() async {
//     final repo = await Repository.createInstance();
//     return MultiProvider(
//       providers: [
//         Provider<Repository>.value(
//           value: repo,
//         ),
//       ],
//       child: App(),
//     );
//   }

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: _Home(),
//       theme: ThemeData(
//         primaryColor: Color(0xFF4D8CFE),
//         hintColor: Colors.black,
//         scaffoldBackgroundColor: Color(0xFFF5F5F5),
//         appBarTheme: AppBarTheme(
//           color: Color(0xFF4D8CFE),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             primary: Color(0xFF4D8CFE),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           ),
//         ),
//         textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//             primary: Color(0xFF4D8CFE),
//           ),
//         ),
//       ),
//       darkTheme: ThemeData.dark(),
//     );
//   }
// }

// class _Home extends StatefulWidget {
//   @override
//   State<_Home> createState() => _HomeState();
// }

// class _HomeState extends State<_Home> {
//   bool isPressed = true;
//   TextEditingController regnoController = TextEditingController();
//   List<String> headers = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             'Smart Docs',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(20),
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 30),
//               Center(
//                 child: Container(
//                   height: 200,
//                   width: 200,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: Color(0xFFFFA726), // Orange color
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 8,
//                         offset: Offset(0, 2),
//                         color: Colors.grey.withOpacity(0.3),
//                       ),
//                     ],
//                   ),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TagReadPage.withDependency(),
//                         ),
//                       );
//                     },
//                     borderRadius: BorderRadius.circular(30),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           FontAwesomeIcons.nfcSymbol,
//                           size: 50,
//                           color: Colors.black,
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           'Scan Smart Doc',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.push(
//                     context,
//                     PageRouteBuilder(
//                       pageBuilder: (context, animation, secondaryAnimation) =>
//                           NdefWriteLockPage.withDependency(),
//                       transitionsBuilder:
//                           (context, animation, secondaryAnimation, child) {
//                         var begin = Offset(0.0, 1.0);
//                         var end = Offset.zero;
//                         var curve = Curves.easeInOut;
//                         var tween = Tween(begin: begin, end: end)
//                             .chain(CurveTween(curve: curve));
//                         return SlideTransition(
//                           position: animation.drive(tween),
//                           child: child,
//                         );
//                       },
//                     ),
//                   );
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(FontAwesomeIcons.userLock, color: Colors.white),
//                     SizedBox(width: 20),
//                     Text('Write Lock', style: TextStyle(fontSize: 18)),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.push(
//                     context,
//                     PageRouteBuilder(
//                       pageBuilder: (context, animation, secondaryAnimation) =>
//                           PaymentScreen(),
//                       transitionsBuilder:
//                           (context, animation, secondaryAnimation, child) {
//                         var begin = Offset(0.0, 1.0);
//                         var end = Offset.zero;
//                         var curve = Curves.easeInOut;
//                         var tween = Tween(begin: begin, end: end)
//                             .chain(CurveTween(curve: curve));
//                         return SlideTransition(
//                           position: animation.drive(tween),
//                           child: child,
//                         );
//                       },
//                     ),
//                   );
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(FontAwesomeIcons.moneyCheckAlt, color: Colors.white),
//                     SizedBox(width: 20),
//                     Text('Payment', style: TextStyle(fontSize: 18)),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               Text(
//                 'Admin Login',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: regnoController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   labelText: 'Enter Admin ID',
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   var adminList = await FirebaseFirestore.instance
//                       .collection('admin')
//                       .doc('F0BED80evF2AMUSso7mH')
//                       .get();
//                   Map<String, dynamic> mdata = adminList.data()!;
//                   List<dynamic> alladmin = mdata['admins'];
//                   if (alladmin.contains(regnoController.text.toString())) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => NdefWritePage.withDependency(),
//                       ),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Invalid Admin'),
//                       ),
//                     );
//                     return null;
//                   }
//                 },
//                 child: Text('Enter'),
//               ),
//               SizedBox(height: 30),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }




































import 'dart:io';
import 'package:app/repository/repository.dart';
import 'package:app/view/CloneDbContent.dart';
import 'package:app/view/ImgByteImg.dart';
import 'package:app/view/ScanMifareClassic.dart';
import 'package:app/view/about.dart';
import 'package:app/view/common/form_row.dart';
import 'package:app/view/ndef_format.dart';
import 'package:app/view/ndef_write.dart';
import 'package:app/view/ndef_write_lock.dart';
import 'package:app/view/paymentScreen.dart';
import 'package:app/view/tag_read.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  static Future<Widget> withDependency() async {
    final repo = await Repository.createInstance();
    return MultiProvider(
      providers: [
        Provider<Repository>.value(
          value: repo,
        ),
      ],
      child: App(),
    );
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    _Home(),
    _Explore(), // Moved Admin Login functionality here
    // PlaceholderWidget('Chat Page'), // Replace with your chat page
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Admin',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.chat),
            //   label: 'Chat',
            // ),
          ],
        ),
      ),
      theme: ThemeData(
        primaryColor: Color(0xFF4D8CFE),
        hintColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        appBarTheme: AppBarTheme(
          color: Color(0xFF4D8CFE),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF4D8CFE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Color(0xFF4D8CFE),
          ),
        ),
      ),
      darkTheme: ThemeData.dark(),
    );
  }
}

class _Home extends StatefulWidget {
  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Welcome to Smart Docs',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/tinkertech.jpg', // Replace with the actual image URL
                      height: 150,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Scan Smart Doc',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TagReadPage.withDependency(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF4D8CFE), // Changed the color to blue
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        ),
                        child: Text('Scan Now', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Featured',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildFeatureItem(
                    'assets/tinkertech.jpg',
                    FontAwesomeIcons.userLock,
                    'Write Lock',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NdefWriteLockPage.withDependency(),
                        ),
                      );
                    },
                  ),
                  _buildFeatureItem(
                    'assets/tinkertech.jpg',
                    FontAwesomeIcons.moneyCheckAlt,
                    'Payment',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
      String imageUrl, IconData iconData, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFF4D8CFE), // Added color to the widget buttons
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 40, color: Colors.white), // Icon color to white
            SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white), // Text color to white
            ),
          ],
        ),
      ),
    );
  }
}

class _Explore extends StatefulWidget {
  @override
  State<_Explore> createState() => _ExploreState();
}

class _ExploreState extends State<_Explore> {
  TextEditingController regnoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Explore',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Login',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: regnoController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Enter Admin RegNo',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var adminList = await FirebaseFirestore.instance
                    .collection('admin')
                    .doc('F0BED80evF2AMUSso7mH')
                    .get();
                Map<String, dynamic> mdata = adminList.data()!;
                List<dynamic> alladmin = mdata['admins'];
                if (alladmin.contains(regnoController.text.toString())) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NdefWritePage.withDependency(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid Admin'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF4D8CFE), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: Text('Login', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text;

  PlaceholderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: TextStyle(fontSize: 24)),
    );
  }
}
