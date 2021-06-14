
import 'dart:io';

import 'package:MyDiary/customButton.dart';
import 'package:MyDiary/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Note extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {

  String title, content,ftime,fdate;
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();

  TextEditingController titleController= TextEditingController();
  TextEditingController contentController= TextEditingController();


  final fb = Firestore.instance;
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
    initUser();
    ftime= time.toIso8601String().substring(11,19);
    fdate=date.toIso8601String().substring(0,10);
    titleController..text="";
    contentController..text="";
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  saveToDB() {
    fb.collection("Notes").add({
      "Name": user.displayName,
      "Email": user.email,
      "Title": titleController.text,
      "Content": contentController.text,
      "Date": fdate,
      "Time": ftime ,
      "Created": DateTime.now().toIso8601String().substring(0,19)
    }).then((value) { 
      print("Saved Successfully to notes");
      Fluttertoast.showToast(msg: "Saved Successfully",backgroundColor: Colors.black);
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>new MyHomePage()));
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: ListTile(
                  leading: Icon(Icons.date_range,color: Colors.pink),
                  title: Text("$fdate",textScaleFactor: 1.2,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.pink),),
                  trailing: IconButton(
                      icon: Icon(Icons.arrow_drop_down,color: Colors.pink),
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1900, 1, 1),
                            maxTime: DateTime(2999, 12, 31),
                            theme: DatePickerTheme(
                                headerColor: Colors.orange,
                                backgroundColor: Colors.blue,
                                itemStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle:
                                    TextStyle(color: Colors.white, fontSize: 16)),
                            onChanged: (date) {
                          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (d) {
                          print('confirm $d');
                          setState(() {
                            date = d;
                            fdate=date.toIso8601String().substring(0,10);
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      }),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: ListTile(
                  leading: Icon(Icons.timer,color: Colors.pink),
                  title: Text("$ftime",textScaleFactor: 1.2,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.pink)),
                  trailing: IconButton(
                      icon: Icon(Icons.arrow_drop_down,color: Colors.pink),
                      onPressed: () {
                        DatePicker.showTimePicker(context, showTitleActions: true,
                            onChanged: (date) {
                          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (t) {
                          print('confirm $t');
                          setState(() {
                            time = t;
                            ftime=time.toIso8601String().substring(11,19);
                          });
                        }, currentTime: DateTime.now());

                    //   DatePicker.showTime12hPicker(context, showTitleActions: true, onChanged: (date) {
                    //   print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                    // }, onConfirm: (t) {
                    //   print('confirm $date');
                    //   setState(() {
                    //     time = t;
                    //     ftime=time.toIso8601String().substring(11,19);
                    //   });
                    // }, currentTime: DateTime.now());
                      }),
                ),
              ),
            ),
            Text("Title: ",textScaleFactor: 2,
              style: TextStyle(  
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                child:  TextField(
                  controller: titleController,
                  style: TextStyle(color: Colors.pink),
                    keyboardType: TextInputType.text,
                    onChanged: (value) => title = value,
                    decoration: InputDecoration(
                      // labelText: "Add Title",
                      hintText: "Add title",
                      hintStyle: TextStyle(color: Colors.black38),
                      border: const OutlineInputBorder(),
                    ),
                  ),
              ),
            ),
            Text("Content: ",textScaleFactor: 2,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                child: TextField(
                  controller: contentController,
                  maxLines: 20,
                  minLines: 10,
                  style: TextStyle(color: Colors.pink),
                  // keyboardType: TextInputType.text,
                  onChanged: (value) => content = value,
                  decoration: InputDecoration(
                    // labelText: "Content",
                    // labelStyle: TextStyle(color: Colors.pink[200]),
                    hintText: "Add Content",
                    hintStyle: TextStyle(color: Colors.black38),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            
            CustomBtn(
              text: "Save".toUpperCase(),
              callback: saveToDB,
              color: Colors.green,
            )
          ],
        ),
      ),

      backgroundColor: Colors.pink,
    );
  }
}
