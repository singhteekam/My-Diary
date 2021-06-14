import 'package:flutter/material.dart';

class FontsAndColor extends StatefulWidget {
  @override
  _FontsAndColorState createState() => _FontsAndColorState();
}

class _FontsAndColorState extends State<FontsAndColor> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Fonts and Colors")
      ),

      body: Column(
        children: <Widget>[
          Container(
            child: Text("hi")
          )
        ],
      ),
    );
  }
}