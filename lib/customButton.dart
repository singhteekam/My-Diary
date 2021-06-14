import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {

  final text;
  final color;
  final VoidCallback callback;
  CustomBtn({this.text,this.color,this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: color,
        elevation: 0.0,
        borderRadius: BorderRadius.circular(25.0),
        child: MaterialButton(
          minWidth: 200.0,
          height: 45.0,
          onPressed: callback,
          child: Text(text,textScaleFactor: 1.4,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}