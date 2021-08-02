import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_test/services/db.dart';
import 'package:login_test/ui/pages/add_task_page.dart';
import 'package:provider/provider.dart';

class MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  var isDone = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(11, 196, 131, 1),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddTask();
          }));
        },
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc('all')
                .collection(user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data.docs
                        .map<Widget>((DocumentSnapshot document) {
                      return Container(
                        decoration: BoxDecoration(
                            // color: Color.fromRGBO(11, 196, 131, 1),
                            color: Colors.white,
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
                                  '${document.data()['title']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(39, 47, 37, 1),
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w900,
                                    decoration: document.data()['done']
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () =>
                                      DBServices().removeTask(document.id),
                                  child: Icon(
                                    Icons.delete,
                                    size: 28,
                                    color: Color.fromRGBO(39, 47, 37, .8),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    document.data()['done'] == true
                                        ? DBServices().unCkeck(document.id)
                                        : DBServices().update(document.id);
                                  },
                                  child: document.data()['done']
                                      ? Icon(
                                          Icons.check_box,
                                          size: 28,
                                          color: Color.fromRGBO(39, 47, 37, .8),
                                        )
                                      : Icon(Icons.crop_square, size: 28),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: .3,
                              color: Colors.black,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 5),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Color.fromRGBO(39, 47, 37, .8),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${document.data()['description']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        decoration: document.data()['done']
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
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
