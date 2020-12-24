import './pageClients.dart';
import 'PdfFirebase/mainpdf.dart';
import './quiz/quize/views/home.dart'; //quize
import './pageProducts.dart';

import 'package:flutter/material.dart';
//import 'home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

//void main() => runApp(
//MaterialApp(debugShowCheckedModeBanner: false, home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  final WebViewPrev _listProducts = WebViewPrev();
  final WebViewPreva _clients = new WebViewPreva();
  //final pagePlace _sites = new pagePlace();
  final MyApp _flutterpages = new MyApp();
  final Home _other = new Home();
  //final GlobalKey _bottomNavigatonKey = Globalkey();

  Widget _showPage = new WebViewPrev();
  Widget pageChooser(int page) {
    switch (page) {
      case 0:
        return _listProducts;
        break;
      case 1:
        return _flutterpages;
        break;

      case 2:
        return _other;
        break;
      //case 3:
      //return _other;
      //break;
      case 3:
        return _clients;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text("No pAGe to shpow"),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: pageIndex,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.add, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            //Icon(Icons.navigation, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.blueAccent,
          buttonBackgroundColor: Colors.blue,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
              _showPage = pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showPage,
          ),
        ));
  }
}
