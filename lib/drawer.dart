import 'package:MyDiary/Drawer/about.dart';
import 'package:MyDiary/Drawer/account.dart';
import 'package:MyDiary/Drawer/feedback.dart';
import 'package:MyDiary/Drawer/styling.dart';
import 'package:MyDiary/googleSIgnIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ShowDrawer extends StatefulWidget {
  @override
  _ShowDrawerState createState() => _ShowDrawerState();
}

class _ShowDrawerState extends State<ShowDrawer> {
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    print("User Signed Out");
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => SignInNotes()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: user == null
            ? Center(child: CircularProgressIndicator())
            : ListView(
                //padding: const EdgeInsets.only(top:520),
                children: <Widget>[
                    new UserAccountsDrawerHeader(
                      accountName: new Text(user.displayName),
                      accountEmail: new Text(user.email),
                      currentAccountPicture: new CircleAvatar(
                        backgroundColor:
                            Theme.of(context).platform == TargetPlatform.iOS
                                ? Colors.deepPurple
                                : Colors.grey,
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                    ),
                    ListTile(
                        onTap: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyAccount())),
                        leading: Icon(Icons.account_circle),
                        title: Text("Account")),

                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FontsAndColor(),
                          )),
                      leading: Icon(Icons.color_lens),
                      title: Text("Fonts and Colors"),
                    ),

                    ListTile(
                      onTap: signOut,
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Sign Out"),
                    ),
                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedBack(),
                          )),
                      leading: Icon(Icons.feedback),
                      title: Text("Feedback"),
                    ),

                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => About(),
                          )),
                      leading: Icon(Icons.error),
                      title: Text("About"),
                    )
                  ])
                  );
  }
}
