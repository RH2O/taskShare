import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_test/services/db.dart';
import 'package:login_test/ui/pages/shared%20tasks/add_group_ID.dart';
import 'package:login_test/ui/pages/shared%20tasks/create_group.dart';
import 'package:login_test/ui/pages/shared%20tasks/one_group_tasks.dart';
import 'package:share/share.dart';
import 'package:unicorndial/unicorndial.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  var uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    ////// floating action button list icons
    var childButtons = [
      UnicornButton(
          hasLabel: true,
          labelText: "Add list",
          currentButton: FloatingActionButton(
            heroTag: "add",
            backgroundColor: Colors.green,
            mini: true,
            child: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddTasksGroup();
              }));
            },
          )),
      UnicornButton(
          hasLabel: true,
          labelText: "Create list",
          currentButton: FloatingActionButton(
            heroTag: "create",
            backgroundColor: Colors.green,
            mini: true,
            child: Icon(Icons.create),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CreateTasksGroup();
              }));
            },
          ))
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.4),
          parentButtonBackground: Color.fromRGBO(11, 196, 131, 1),
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 196, 131, 1),
        // elevation: 0,
        title: Text(
          'Shared Groups',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('userGroups')
                  .doc(uid)
                  .collection('groups')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      physics: BouncingScrollPhysics(),
                      children: snapshot.data.docs
                          .map<Widget>((DocumentSnapshot document) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (builder) {
                              return GroupTasks(
                                  groupID: document.id,
                                  groupName: document.data()['name']);
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                //color: Color.fromRGBO(11, 196, 131, 1),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      document
                                              .data()['name']
                                              .toString()
                                              .trim()
                                              .isNotEmpty
                                          ? '${document.data()['name']}'
                                          : '${document.id}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(39, 47, 37, 1),
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
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
                                          title:
                                              const Text('Delete This group'),
                                          content: const Text('Are You Sure ?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                DBServices()
                                                    .removeGroup(document.id);

                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        size: 22,
                                        color: Color.fromRGBO(39, 47, 37, .8),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share('${document.id}');
                                      },
                                      child: Icon(
                                        Icons.share,
                                        size: 22,
                                        color: Color.fromRGBO(39, 47, 37, .8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList());
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
