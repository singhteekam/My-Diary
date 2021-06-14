
import 'package:MyDiary/googleSIgnIn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  // setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        // textTheme: GoogleFonts.actorTextTheme(
        //     Theme.of(context).textTheme,
        //   )
      ),
      debugShowCheckedModeBanner: false,
      home: SignInNotes(),
    );
  }
}


