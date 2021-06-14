import 'package:MyDiary/showNote.dart';
import 'package:flutter/material.dart';

class SearchNotes extends StatelessWidget {

  final searchTitle,searchContent,searchDate,searchTime,searchDocs;
  final VoidCallback callback;
  SearchNotes({this.searchTitle,this.searchContent,this.searchDate,this.searchTime,this.searchDocs,this.callback});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchTitle.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowNote(
                                title: searchTitle[index],
                                content: searchContent[index],
                                date: searchDate[index],
                                time: searchTime[index],
                                currentDocument: searchDocs[index],
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
                              searchTitle[index],
                              maxLines: 2,
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.pink),
                            ),
                            subtitle: Text(
                              searchContent[index],
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(color: Colors.pink),
                            ),
                            trailing: Column(
                              children: <Widget>[
                                Text(
                                  searchDate[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.pink),
                                ),
                                Text(
                                  searchTime[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.pink),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
  }
}