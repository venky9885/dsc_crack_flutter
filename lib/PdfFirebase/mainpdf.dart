import 'package:flutter/material.dart';
import '../PdfFirebase/FirstPage.dart';
// ignore: unused_import

/*void main() {
  runApp(MyApp());
}*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}
