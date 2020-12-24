import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './quiz/quize/models/user.dart';
//import './views/signin.dart';
import './quiz/quize/services/auth.dart';
import 'mai.dart';
import './quiz/quize/helper/authenticate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  //final user = Provider.of<User>(context);
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return BottomNavBar();
    }
  }
}
