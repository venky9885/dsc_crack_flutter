import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:quizapp2/helper/constants.dart';
import '../services/auth.dart';

//import 'package:quizapp2/services/database.dart';
//import 'package:quizapp2/widget/widget.dart';
//import '../views/home.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up "),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign in'),
              onPressed: () {
                widget.toggleView();
              })
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                //key: _formKey,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    validator: (val) =>
                        val.length < 6 ? 'Enter Password Correctly' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.pink,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() => error = 'Please Enter Correctly');
                          }
                        }
                      }),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ))),
    );
  }
}
/*class SignUp extends StatefulWidget {
  final Function toogleView;

  SignUp({this.toogleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  // text feild
  bool _loading = false;
  String email = '', password = '', name = "";

  getInfoAndSignUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      await authService
          .signUpWithEmailAndPassword(email, password)
          .then((value) {
        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        databaseService.addData(userInfo);

        Constants.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: _loading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  Spacer(),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter an Name" : null,
                            decoration: InputDecoration(hintText: "Name"),
                            onChanged: (val) {
                              name = val;
                            },
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            validator: (val) => validateEmail(email)
                                ? null
                                : "Enter correct email",
                            decoration: InputDecoration(hintText: "Email"),
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) => val.length < 6
                                ? "Password must be 6+ characters"
                                : null,
                            decoration: InputDecoration(hintText: "Password"),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              getInfoAndSignUp();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have and account? ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 17)),
                              GestureDetector(
                                onTap: () {
                                  widget.toogleView();
                                },
                                child: Container(
                                  child: Text('Sign In',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          decoration: TextDecoration.underline,
                                          fontSize: 17)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}*/ //--------------------
/*class SignUp extends StatefulWidget {
  //final Function toogleView;

  //SignUp({this.toogleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  // text feild
  bool _isloading = false;
  String email, password, name;

  //var userInfo;

  //get userInfo => null;

  signUp() async {
    if (_formKey.currentState.validate()) {
      await authService
          .signUpWithEmailAndPassword(email, password)
          .then((value) {
        if (value != null) {
          setState(() {
            _isloading = false;
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        }
        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        databaseService.addData(userInfo);

        Constants.saveUserLoggedInSharedPreference(true); //maketrue

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: _isloading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  Spacer(),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter an Name" : null,
                            decoration: InputDecoration(hintText: "Name"),
                            onChanged: (val) {
                              name = val;
                            },
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            validator: (val) => validateEmail(email)
                                ? null
                                : "Enter correct email",
                            decoration: InputDecoration(hintText: "Email"),
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) => val.length < 6
                                ? "Password must be 6+ characters"
                                : null,
                            decoration: InputDecoration(hintText: "Password"),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              signUp();
                            },
                            //child

                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have and account? ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 17)),
                              GestureDetector(
                                onTap: () {
                                  //widget.toogleView();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginSixPage()));
                                },
                                child: Container(
                                  child: Text('Sign In',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          decoration: TextDecoration.underline,
                                          fontSize: 17)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
*/
