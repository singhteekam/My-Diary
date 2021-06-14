import 'package:MyDiary/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInNotes extends StatefulWidget {
  @override
  _SignInNotesState createState() => _SignInNotesState();
}

class _SignInNotesState extends State<SignInNotes> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  FirebaseUser _user;

  @override
  initState() {
    super.initState();
    isLoggedIn();
  }



  isLoggedIn() async {
    _user = await _auth.currentUser();
    if (_user != null) {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage()));
    }
  }

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)) as FirebaseUser;

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
                child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("My Diary",textScaleFactor: 3,style: GoogleFonts.berkshireSwash(),),

                Text("v1.0.0",textScaleFactor: 2,style: GoogleFonts.berkshireSwash(),),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SignInButton(
                    Buttons.GoogleDark,
                    // text: "Sign In with Google",
                    onPressed: () => _signIn().whenComplete(() =>
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => MyHomePage()))),
                  ),
                )
              ]),
        ),
      ),

      backgroundColor: Colors.pink,

      // body: SingleChildScrollView(
      //   child: Stack(
      //     alignment: Alignment.bottomCenter,
      //     children: <Widget>[
      //       Image.asset(
      //         "assets/myDiary.jpg",
      //         fit: BoxFit.cover,
      //         width: MediaQuery.of(context).size.width,
      //         height: MediaQuery.of(context).size.height,
      //       ),
      //       Padding(
      //         padding: EdgeInsets.only(
      //             bottom: MediaQuery.of(context).size.height * 0.17),
      //         child: SignInButton(
      //           Buttons.GoogleDark,
      //           // text: "Sign In with Google",
      //           onPressed: () => _signIn().whenComplete(() =>
      //               Navigator.pushReplacement(
      //                   context,
      //                   new MaterialPageRoute(
      //                       builder: (BuildContext context) => MyHomePage()))),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
