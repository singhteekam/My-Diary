
import 'package:MyDiary/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {

  final db= Firestore.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController feedbackController= TextEditingController();
  TextEditingController recomm= TextEditingController();

  sendFeedback(){
    db.collection("Feedback").add(
      {
        "Feedback": feedbackController.text,
        "Any Recommendation": recomm.text
      }
    ).then((value) {
      print("Feedback Sent Succesfully");
      Fluttertoast.showToast(msg: "Feedback Sent",backgroundColor: Colors.black);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                  child: TextFormField(
                    style: TextStyle(color: Colors.pink),
                    controller: feedbackController,
                    decoration: InputDecoration(
                        labelText: 'Feedback',
                        labelStyle: TextStyle(color:Colors.black38),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                  child: TextFormField(
                    style: TextStyle(color: Colors.pink),
                    controller: recomm,
                    decoration: InputDecoration(
                      labelText: 'Any Recommendation?',
                      labelStyle: TextStyle(color:Colors.black38),
                       border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                  ),
                ),
              ),

              CustomBtn(
                text: "Submit",
                color: Colors.green,
                callback: () {
                  if (_formKey.currentState.validate()){
                  sendFeedback();
                  }
                },
              )
            ]),
          ),
        ),
      ),

      backgroundColor: Colors.pink,
    );
  }
}
