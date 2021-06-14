import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "My Diary",
                  textScaleFactor: 4,
                  style: GoogleFonts.berkshireSwash()
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "v1.0.0",
                  textScaleFactor: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Contact: teekams10999@gmail.com",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.pink,
    );
  }
}
