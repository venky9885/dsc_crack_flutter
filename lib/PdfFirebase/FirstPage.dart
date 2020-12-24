import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../PdfFirebase/Modal.dart';
import '../PdfFirebase/secondPage.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Modal> itemList = List();
  final mainReference = FirebaseDatabase.instance.reference().child('Database');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Material  "),
      ),
      body: itemList.length == 0
          ? Text(
              "Loading....",
              textAlign: TextAlign.center,
            )
          : ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        // ignore: unused_local_variable
                        String passData = itemList[index].link;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewPdf(),
                                settings: RouteSettings(
                                  arguments: passData,
                                )));
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                              //height: 100,
                              /*decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('asset/bg999.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),*/
                              ),
                          Center(
                            //color: Colors.blue,
                            child: Container(
                              height: 140,
                              child: Card(
                                color: Colors.blue,
                                margin: EdgeInsets.all(15),
                                elevation: 7.0,
                                child: Center(
                                  child: Text(itemList[index].name),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getPdfAndUpload();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future getPdfAndUpload() async {
    // ignore: unused_local_variable
    var rng = new Random();
    String randomName = "";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      randomName += rng.nextInt(100).toString();
      //generate
    }
    // ignore: unused_local_variable
    File file = await FilePicker.getFile(type: FileType.custom);

    String fileName = '$randomName.pdf';
    savePdf(file.readAsBytesSync(), fileName);
    //function call
  }

  savePdf(List<int> asset, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    // ignore: unused_local_variable
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    documentFileUpload(url);
    //function call
  }

  // ignore: missing_return
  // ignore: non_constant_identifier_names
  // ignore: missing_return
  // ignore: non_constant_identifier_names
  String CreateCryptoRandomString([int length = 32]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
    //generate key
  }

  void documentFileUpload(String str) {
    var data = {
      "PDF": str,
      "FileName": "Pdf",
      //store data
    };
    mainReference.child(CreateCryptoRandomString()).set(data).then((v) {
      print("Store Successfully");
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    mainReference.once().then((DataSnapshot snap) {
      //print(snap);
      var data = snap.value;
      //print(data);
      itemList.clear();
      data.forEach((key, value) {
        Modal m = new Modal(value['PDF'], value['FileName']);
        itemList.add(m);
      });
      setState(() {
        // print("value is");
        // print(itemList.length);
      });
      //get data from firebase
    });
  }
}
/*class DataSource {
    Future getPdfAndUpload() async {
    // ignore: unused_local_variable
    var rng = new Random();
    String randomName = "";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      randomName += rng.nextInt(100).toString();
      //generate
    }
    // ignore: unused_local_variable
    File file = await FilePicker.getFile(type: FileType.custom);

    String fileName = '$randomName.pdf';
    savePdf(file.readAsBytesSync(), fileName);
    //function call
  }
  }
class UserService {
  getPdfAndUpload() {}
}*/
