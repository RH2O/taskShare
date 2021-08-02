import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_test/services/db.dart';
import 'package:login_test/ui/pages/add_task_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

////////////////////////////////////////////// Shared Page

class SharedPage extends StatefulWidget {
  _SharedPageState createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  String _collectionId = FirebaseAuth.instance.currentUser.uid;

  SharedPreferences prefs;

  saveData(String currentCollection) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('collectionId', currentCollection);
  }

  getData() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      _collectionId = prefs.getString('collectionId') ??
          FirebaseAuth.instance.currentUser.uid;
    });
  }

  void updateInformation(String collectionId) {
    if (collectionId != null) {
      setState(() {
        _collectionId = collectionId;
        saveData(_collectionId);
      });
    } else {
      setState(() {
        _collectionId = FirebaseAuth.instance.currentUser.uid;
      });
    }
  }

  void moveToSecondPage() async {
    final collectionId = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddShared();
      }),
    );
    updateInformation(collectionId);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(11, 196, 131, 1),
        onPressed: () {
          moveToSecondPage();
        },
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('shared')
                .doc('all')
                .collection(_collectionId)
                // .where('done', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data.docs
                        .map<Widget>((DocumentSnapshot document) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(11, 196, 131, 1),
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  'Title: ${document.data()['title']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    decoration: document.data()['done']
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => DBServices()
                                      .removeShared(document.id, _collectionId),
                                  child: Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    document.data()['done'] == true
                                        ? DBServices().unCheckShared(
                                            document.id, _collectionId)
                                        : DBServices().updateShared(
                                            document.id, _collectionId);
                                  },
                                  child: document.data()['done']
                                      ? Icon(Icons.check_box, size: 30)
                                      : Icon(Icons.crop_square, size: 30),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      style: TextStyle(
                                          color: Colors.brown[900],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                      text: 'Description : ',
                                    ),
                                    TextSpan(
                                      text: '${document.data()['description']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList());
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
