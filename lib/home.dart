import 'package:MyDiary/Note.dart';
import 'package:MyDiary/drawer.dart';
import 'package:MyDiary/searchNotes.dart';
import 'package:MyDiary/showNote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Icon icon = Icon(Icons.search);
  Widget appTitle = Text("My Diary",);
  TextEditingController searchController = TextEditingController();
  // List searchresult = new List();
  bool isSearching = false;
  List<String> searchTitle = [], searchContent = [], searchDate = [], searchTime = [],searchDocs=[];

  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = Firestore.instance;

  List<String> title = [], content = [], fDate = [], fTime = [];
  List<String> _currentDocument = [];

  @override
  initState() {
    super.initState();
    isSearching = false;
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
        .orderBy(
          "Date",
        )
        .getDocuments()
        .then((fetchData) {
      fetchData.documents.forEach((fetchData) {
        if (user.email == fetchData.data["Email"]) {
          title.add(fetchData.data["Title"]);
          content.add(fetchData.data["Content"]);
          fDate.add(fetchData.data["Date"]);
          fTime.add(fetchData.data["Time"]);
          _currentDocument.add(fetchData.documentID);
        }
        setState(() {});
      });
      print((title.length).toString() + " fetched succussfully!!");
    });
  }

  searchNotes(String text) {
    setState(() {
      searchTitle.clear();
      searchContent.clear();
      searchDate.clear();
      searchTime.clear();
      searchDocs.clear();
      if (isSearching != null) {
        for (int i = 0; i < title.length; i++) {
          String data = title[i];
          String con= content[i];
          String dt= fDate[i];
          String tm= fTime[i];
          String cd= _currentDocument[i];
          if (data.toLowerCase().contains(text.toLowerCase())) {
            searchTitle.add(data);
            searchContent.add(con);
            searchDate.add(dt);
            searchTime.add(tm);
            searchDocs.add(cd);
          }
        }
      }
    });
  }

  void _handleSearchStart() {
    setState(() {
      isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appTitle = new Text(
        "My Diary",
        style: new TextStyle(color: Colors.white),
      );
      isSearching = false;
      searchController.clear();
      searchTitle.length=0;
      searchController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appTitle,
        actions: <Widget>[
          IconButton(
              icon: icon,
              onPressed: () {
                setState(() {
                  if (this.icon.icon == Icons.search) {
                    this.icon = new Icon(
                      Icons.close,
                      color: Colors.white,
                    );
                    this.appTitle = new TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintText: "Search Here...",
                      ),
                      onChanged: searchNotes,
                    );
                    _handleSearchStart();
                  } else {
                    _handleSearchEnd();
                  }
                });
              })
        ],
      ),
      drawer: ShowDrawer(),
      body: FutureBuilder(
        builder: (context, fetchSnap) {
          if (fetchSnap.connectionState == ConnectionState.none &&
              fetchSnap.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Container();
          }
          return searchTitle.length != 0 || searchController.text.isNotEmpty
              ? SearchNotes(
                searchTitle: searchTitle,
                searchContent: searchContent,
                searchDate: searchDate,
                searchTime: searchTime,
                searchDocs: searchDocs
              )

              : ListView.builder(
                  itemCount: title.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowNote(
                                title: title[index],
                                content: content[index],
                                date: fDate[index],
                                time: fTime[index],
                                currentDocument: _currentDocument[index],
                              ),
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            leading: Text(
                              (index + 1).toString(),
                              textScaleFactor: 2,
                              style: TextStyle(color: Colors.pink),
                            ),
                            title: Text(
                              title[index],
                              maxLines: 2,
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.pink),
                            ),
                            subtitle: Text(
                              content[index],
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(color: Colors.pink),
                            ),
                            trailing: Column(
                              children: <Widget>[
                                Text(
                                  fDate[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.pink),
                                ),
                                Text(
                                  fTime[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.pink),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
        future: null,
      ),
      backgroundColor: Colors.pink,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => Note(),
            )),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
