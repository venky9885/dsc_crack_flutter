import 'package:flutter/material.dart';
//import './quiz/quize/services/auth.dart';
import './quiz/quize/services/auth.dart';

//UserService userService = UserService();
//
//}
class WebViewPreva extends StatefulWidget {
  WebViewPreva({Key key}) : super(key: key);

  @override
  _WebViewPrevStatea createState() => _WebViewPrevStatea();
}

class _WebViewPrevStatea extends State {
  @override
  void initState() {
    super.initState();
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //UserService userService = UserService();
              //userService.
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
