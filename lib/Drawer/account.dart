import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final firestore = Firestore.instance;
  int count=0;

  @override
  void initState() {
    super.initState();
    initUser();
    fetchNotes();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  fetchNotes() async {
    await firestore
        .collection("Notes")
        .getDocuments()
        .then((fetchData) {
      fetchData.documents.forEach((fetchData) {
        if (user.email == fetchData.data["Email"]) {
          count++;
        }
        setState(() {});
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            user.photoUrl != null
                ? Center(
                    child: ClipOval(
                    child: Image.network(
                      user.photoUrl,
                      fit: BoxFit.fill,
                    ),
                  ))
                : Icon(Icons.person),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.displayName,
                textScaleFactor: 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Email: " + user.email,
                textScaleFactor: 1.3,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Account Verified: " + user.isEmailVerified.toString(),
                textScaleFactor: 1.3,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "User ID: " + user.uid,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Number of Notes: " + count.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.pink,
    );
  }
}
