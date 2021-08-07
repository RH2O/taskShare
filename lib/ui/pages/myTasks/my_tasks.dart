import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_test/services/db.dart';
import 'package:login_test/ui/pages/myTasks/add_task_page.dart';
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 196, 131, 1),
        // elevation: 0,
        title: Text(
          'My Tasks',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(11, 196, 131, 1),
        child: Icon(
          Icons.add,
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
                .collection('myTasks')
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
                                      // DBServices().removeTask(document.id),
                                      showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Delete This Task'),
                                      content: const Text('Are You Sure ?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            DBServices()
                                                .removeTask(document.id);

                                            Navigator.pop(context, 'Cancel');
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                        ? DBServices()
                                            .checkToggle(document.id, false)
                                        : DBServices()
                                            .checkToggle(document.id, true);
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
