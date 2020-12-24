import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPrev extends StatefulWidget {
  WebViewPrev({Key key}) : super(key: key);

  @override
  _WebViewPrevState createState() => _WebViewPrevState();
}

class _WebViewPrevState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebviewScaffold(
          url: "https://m.youtube.com/",
        ),
      ),
    );
  }
}
