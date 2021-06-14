import 'package:MyDiary/customButton.dart';
import 'package:MyDiary/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateNote extends StatefulWidget {

  String title,content,fdate,ftime;
  final String currentDocument;
  UpdateNote({this.title,this.content,this.fdate,this.ftime,this.currentDocument});

  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {

  //  String title, content,ftime,fdate;
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();

  TextEditingController titleController= TextEditingController();
  TextEditingController contentController= TextEditingController();

  final fb = Firestore.instance;
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    String ft=widget.title;
    String fc=widget.content;
    titleController..text=ft;
    contentController..text=fc;
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  updateToDB() {
    fb.collection("Notes").document(widget.currentDocument).updateData({
      "Title": titleController.text,
      "Content": contentController.text,
      "Date": widget.fdate,
      "Time": widget.ftime ,
      "Last Updated": DateTime.now().toIso8601String().substring(0,19)
    }).then((value) { 
      print("Updated Successfully to notes");
      Fluttertoast.showToast(msg: "Updated Successfully",backgroundColor: Colors.black);
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>new MyHomePage()));
      });
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Note")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                child: ListTile(
                  leading: Icon(Icons.date_range,color: Colors.pink,),
                  title: Text(widget.fdate,textScaleFactor: 1.2,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.pink)),
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
                            widget.fdate=date.toIso8601String().substring(0,10);
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
                  title: Text(widget.ftime,textScaleFactor: 1.2,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.pink)),
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
                            widget.ftime=time.toIso8601String().substring(11,19);
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
                     style: TextStyle(color: Colors.pink),
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => widget.title = value,
                    decoration: InputDecoration(
                      // hintText: "Title",
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
                   style: TextStyle(color: Colors.pink),
                  controller: contentController,
                  maxLines: 20,
                  minLines: 10,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => widget.content = value,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            CustomBtn(
              text: "Save".toUpperCase(),
              callback: updateToDB,
              color: Colors.green,
            )
          ],
        ),
      ),
      backgroundColor: Colors.pink,
    );
  }
}