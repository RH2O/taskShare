import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_test/constants/constant.dart';
import 'package:login_test/services/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String title = '';
  String description = '';
  static String error = '';
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 50),
              TextField(
                controller: _text,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Task Title'),
                onChanged: (val) {
                  setState(() {
                    title = val;
                  });
                },
              ),
              SizedBox(height: 50),
              TextField(
                maxLines: 5,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Description'),
                onChanged: (val) {
                  setState(() {
                    description = val;
                  });
                },
              ),
              SizedBox(height: 60),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(11, 196, 131, 1),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      // color: Colors.black54,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_text.text.length > 25) {
                        error = 'Title must be less than 25 Charecters';
                      } else if (_text.text.isEmpty) {
                        error = 'Title Cant Be Empty';
                      } else {
                        DBServices().addTask(
                          title,
                          description,
                        );
                        Navigator.pop(context);
                      }
                    });
                  }),
              SizedBox(height: 40),
              Center(
                child: Text(
                  error,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////// add Shared button

class AddShared extends StatefulWidget {
  @override
  _AddSharedState createState() => _AddSharedState();
}

class _AddSharedState extends State<AddShared> {
  String title = '';
  String description = '';
  String error = '';
  String errorB = '';
  String taskId = '';
  String searchId = '';
  String errorID = '';
  String selectedCollection = '';
  final _text = TextEditingController();
  SharedPreferences prefs;

  saveData(String currentCollection) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('collection', currentCollection);
  }

  getData() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      taskId = prefs.getString('collection') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Material(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: _text,
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Task Title',
                  ),
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextField(
                  maxLines: 3,
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Description',
                  ),
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                ),
                SizedBox(
                  height: 35,
                  child: RadioListTile(
                    title: Text('Add To Your Shared'),
                    value: FirebaseAuth.instance.currentUser.uid,
                    groupValue: selectedCollection,
                    onChanged: (String val) {
                      setState(() {
                        selectedCollection = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: RadioListTile(
                    title: Text('Add To Others Shared'),
                    value: taskId,
                    groupValue: selectedCollection,
                    onChanged: (String val) {
                      setState(() {
                        selectedCollection = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(11, 196, 131, 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: StadiumBorder(),
                    ),
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_text.text.length > 25) {
                          error = 'Title must be less than 25 Charecters';
                        } else if (_text.text.isEmpty) {
                          error = 'Title Can Not Be Empty';
                        } else if (selectedCollection.isEmpty) {
                          error = 'Set Shared Id To Show Others Shared';
                        } else {
                          DBServices().addShared(
                              title, description, selectedCollection);
                          Navigator.pop(context);
                        }
                      });
                    }),
                Center(
                  child: Text(
                    error,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  height: 0.5,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                ),
                TextField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Shared Tasks Id'),
                  onChanged: (val) {
                    setState(() {
                      searchId = val;
                    });
                  },
                ),
                SizedBox(height: 10),
                ////////////////////////////////////////// button
                ElevatedButton(
                  // padding: EdgeInsets.all(15),
                  // color: Colors.white,
                  // shape: StadiumBorder(),
                  child: Text(
                    'Add Others Shared Tasks',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    final snapshot = await FirebaseFirestore.instance
                        .collection('users')
                        .doc('all')
                        .collection(searchId)
                        .get();
                    if (snapshot.docs.length == 0) {
                      setState(() {
                        errorID = 'Wrong Id';
                      });
                    } else {
                      setState(() {
                        taskId = searchId;
                        saveData(taskId);
                        //   Navigator.of(context).pop(taskId);
                      });
                    }
                  },
                ),
                Center(
                  child: Text(
                    errorID,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                SelectableText(
                  'Current Others Id Is : $taskId',
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 0.5,
                  color: Colors.black,
                  width: 280,
                ),
                SelectableText(
                  'Your Shared ID "You can share it with your freinds" : (${FirebaseAuth.instance.currentUser.uid})',
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),

                ////////////////////////////////buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      // padding: EdgeInsets.all(15),
                      // color: Colors.white,
                      // shape: StadiumBorder(),
                      child: Text(
                        'Set Your Shared',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(FirebaseAuth.instance.currentUser.uid);
                      },
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      // padding: EdgeInsets.all(15),
                      // color: Colors.white,
                      // shape: StadiumBorder(),
                      child: Text(
                        'Set Others Shared',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (taskId.isEmpty) {
                          errorB = 'You Must Add Others Id First';
                        } else {
                          Navigator.of(context).pop(taskId);
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    errorB,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
