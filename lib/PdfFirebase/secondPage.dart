import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class ViewPdf extends StatefulWidget {
  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  PDFDocument doc;
  @override
  Widget build(BuildContext context) {
    //get data from first class
    String data = ModalRoute.of(context).settings.arguments;
    // ignore: non_constant_identifier_names
    ViewNow() async {
      doc = await PDFDocument.fromURL(data);
      setState(() {});
    }

    // ignore: non_constant_identifier_names
    // ignore: missing_return
    // ignore: non_constant_identifier_names
    Widget Loading() {
      ViewNow();
      if (doc == null) {
        return Text(
          "loading...",
          textAlign: TextAlign.center,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Retrieve Pdf"),
      ),
      body: doc == null ? Loading() : PDFViewer(document: doc),
    );
  }
}
