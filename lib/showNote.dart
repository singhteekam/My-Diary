import 'package:MyDiary/customButton.dart';
import 'package:MyDiary/home.dart';
import 'package:MyDiary/updateNote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowNote extends StatefulWidget {
  final date, time, title, content, currentDocument;
  ShowNote(
      {this.date, this.time, this.title, this.content, this.currentDocument});
  @override
  _ShowNoteState createState() => _ShowNoteState();
}

class _ShowNoteState extends State<ShowNote> {
  final db = Firestore.instance;

  deleteNote() {
    db.collection("Notes").document(widget.currentDocument).delete();
    Fluttertoast.showToast(msg: "Deleted Successfully",backgroundColor: Colors.black);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Note")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(
                    Icons.date_range,
                    color: Colors.pink,
                  ),
                  title: Text(widget.date,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.pink)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: ListTile(
                  leading: Icon(Icons.timer, color: Colors.pink),
                  title: Text(widget.time,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.pink)),
                ),
              ),
            ),
            Divider(
              thickness: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Wrap(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Title: ",
                    textScaleFactor: 2,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    widget.title,
                    textScaleFactor: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  )
                ],
              )),
            ),
            Divider(
              thickness: 3,
            ),
            Text(
              "Content: ",
              textScaleFactor: 2,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  decoration: TextDecoration.underline),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.content,
                textScaleFactor: 1.5,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomBtn(
                text: "Update".toUpperCase(),
                color: Colors.green,
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateNote(
                        title: widget.title,
                        content: widget.content,
                        fdate: widget.date,
                        ftime: widget.time,
                        currentDocument: widget.currentDocument,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomBtn(text: "Delete".toUpperCase(),color: Colors.red ,callback: deleteNote,)
            )
          ],
        ),
      ),
      backgroundColor: Colors.pink,
    );
  }
}
