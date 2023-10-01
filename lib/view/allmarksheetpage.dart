
import 'dart:io';
import 'dart:typed_data';

import 'package:app/view/pdfview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
class AllMarksheetPage extends StatefulWidget {
  final List<String> allMarkSheet;
  const AllMarksheetPage(this.allMarkSheet, {Key? key}) : super(key: key);

  @override
  State<AllMarksheetPage> createState() => _AllMarksheetPageState();
}

class _AllMarksheetPageState extends State<AllMarksheetPage> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Center(
        child: Row(
          children: [
                                        Image.asset('assets/tinkertech.jpg',fit: BoxFit.cover, height: 32),

            Text('    Marksheet'),
          ],
        ),
      ),),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            ElevatedButton(onPressed:() async {
              print(widget.allMarkSheet[0].toString());
              print('00000000000000000000000000000000000000');
              // PDFDocument doc=await PDFDocument.fromURL(widget.allMarkSheet[0].toString()); 
              Navigator.push(context, MaterialPageRoute(
                        builder: (context) => View(widget.allMarkSheet[0].toString().trim(),'1'),
                      ));
              // NetworkImage(widget.allMarkSheet[0].toString());
              // PdfViewerPage(widget.allMarkSheet[0].toString());
              // SfPdfViewer.network(widget.allMarkSheet[0].toString(),controller: _pdfViewerController,);
            },  child: Text('Sem 1')),
            ElevatedButton(onPressed:() async {
              print(widget.allMarkSheet[1].toString());
              print('00000000000000000000000000000000000000');
              // PDFDocument doc=await PDFDocument.fromURL(widget.allMarkSheet[0].toString()); 
              Navigator.push(context, MaterialPageRoute(
                        builder: (context) => View(widget.allMarkSheet[1].toString().trim(),'2'),
                      ));
              // NetworkImage(widget.allMarkSheet[0].toString());
              // PdfViewerPage(widget.allMarkSheet[0].toString());
              // SfPdfViewer.network(widget.allMarkSheet[0].toString(),controller: _pdfViewerController,);
            },  child: Text('Sem 2')),
            ElevatedButton(onPressed:() async {
              print(widget.allMarkSheet[2].toString());
              print('00000000000000000000000000000000000000');
              // PDFDocument doc=await PDFDocument.fromURL(widget.allMarkSheet[0].toString()); 
              Navigator.push(context, MaterialPageRoute(
                        builder: (context) => View(widget.allMarkSheet[2].toString().trim(),'3'),
                      ));
              // NetworkImage(widget.allMarkSheet[0].toString());
              // PdfViewerPage(widget.allMarkSheet[0].toString());
              // SfPdfViewer.network(widget.allMarkSheet[0].toString(),controller: _pdfViewerController,);
            },  child: Text('Sem 3')),
            ElevatedButton(onPressed:() async {
              print(widget.allMarkSheet[3].toString());
              print('00000000000000000000000000000000000000');
              // PDFDocument doc=await PDFDocument.fromURL(widget.allMarkSheet[0].toString()); 
              Navigator.push(context, MaterialPageRoute(
                        builder: (context) => View(widget.allMarkSheet[3].toString().trim(),'4'),
                      ));
              // NetworkImage(widget.allMarkSheet[0].toString());
              // PdfViewerPage(widget.allMarkSheet[0].toString());
              // SfPdfViewer.network(widget.allMarkSheet[0].toString(),controller: _pdfViewerController,);
            },  child: Text('Sem 4')),
            ElevatedButton(onPressed:() async {
              print(widget.allMarkSheet[4].toString());
              print('00000000000000000000000000000000000000');
              // PDFDocument doc=await PDFDocument.fromURL(widget.allMarkSheet[0].toString()); 
              Navigator.push(context, MaterialPageRoute(
                        builder: (context) => View(widget.allMarkSheet[4].toString().trim(),'5'),
                      ));
              // NetworkImage(widget.allMarkSheet[0].toString());
              // PdfViewerPage(widget.allMarkSheet[0].toString());
              // SfPdfViewer.network(widget.allMarkSheet[0].toString(),controller: _pdfViewerController,);
            },  child: Text('Sem 5')),
            ElevatedButton(onPressed:() async {
              print(widget.allMarkSheet[5].toString());
              print('00000000000000000000000000000000000000');
              // PDFDocument doc=await PDFDocument.fromURL(widget.allMarkSheet[0].toString()); 
              Navigator.push(context, MaterialPageRoute(
                        builder: (context) => View(widget.allMarkSheet[5].toString().trim(),'6'),
                      ));
              // NetworkImage(widget.allMarkSheet[0].toString());
              // PdfViewerPage(widget.allMarkSheet[0].toString());
              // SfPdfViewer.network(widget.allMarkSheet[0].toString(),controller: _pdfViewerController,);
            },  child: Text('Sem 6')),
            
             ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text('Back')),
                             Container(
            padding: EdgeInsets.all(16.0), // Adjust padding as needed
            child: Image.asset('assets/tinkertech.jpg'),
          ),
            
          ],
        ),
      ),
    );
  }
}
// class View extends StatefulWidget {
  
//   final String u;
//   const View(this.u, {Key? key}) : super(key: key);

//   @override
//   State<View> createState() => _ViewState();
// }

// class _ViewState extends State<View> {
//   @override
//   Widget build(BuildContext context) {
//     Uint8List? _documentBytes;
//     void getPdfBytes(String path) async {
  
//     HttpClient client = HttpClient();
//     final Uri url = Uri.base.resolve(path);
//     final HttpClientRequest request = await client.getUrl(url);
//     final HttpClientResponse response = await request.close();
//     _documentBytes = await consolidateHttpClientResponseBytes(response);
//     setState(() async {
//       _documentBytes = await consolidateHttpClientResponseBytes(response);
//     });
//     // return _documentBytes;
  
// }
//     getPdfBytes(widget.u);
//     // PdfViewerController? _pdfViewerController;
//     // PDFDocument document = PDFDocument.fromURL(url);
//     Widget child = const Center(child: CircularProgressIndicator());
//   if (_documentBytes != null) {
//     child = SfPdfViewer.memory(
//       _documentBytes!,
//     );
//   }
//   return Scaffold(
//     appBar: AppBar(title: const Text('Syncfusion Flutter PDF Viewer')),
//     body: child,
//   );
//   }
//    void openWebPage(String url) {
//     Uri webpage = Uri.parse(url);
//     Intent intent = new Intent(Intent.ACTION_VIEW, webpage);
//     if (intent.resolveActivity(getPackageManager()) != null) {
//         startActivity(intent);
//     }
// }
  
// }




// class View extends StatefulWidget {
//   final String url;
//   final String sem_no;
//   const View(this.url, this.sem_no, {Key? key}) : super(key: key);

//   @override
//   State<View> createState() => _ViewState();
// }

// class _ViewState extends State<View> {
//   Future<void> secureScreen() async{
//     await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
//   }
//   @override 
//   void initState(){
//     secureScreen();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Marksheet - ${widget.sem_no}'),),
//       body: Center(
//         child: InteractiveViewer(
//           boundaryMargin: EdgeInsets.all(80),
//       panEnabled: false,
//       scaleEnabled: true,
//       minScale: 1.0,
//       maxScale: 2.2,
          
          
//           child:Image.network(widget.url,fit: BoxFit.fitWidth,)
//           // child:url_launcher(widget.url);
//         ),
//       ),
//     );
//   }
// }


class View extends StatefulWidget {
  final String url;
  final String sem_no;
  const View(this.url, this.sem_no, {Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    secureScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marksheet - ${widget.sem_no}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(80),
              panEnabled: false,
              scaleEnabled: true,
              minScale: 1.0,
              maxScale: 2.2,
              child: Image.network(widget.url, fit: BoxFit.fitWidth),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Add this line to navigate back
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}
