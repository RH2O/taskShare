import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_test/constants/constant.dart';
import 'package:login_test/services/db.dart';

class AddTasksGroup extends StatefulWidget {
  @override
  _AddTasksGroupState createState() => _AddTasksGroupState();
}

class _AddTasksGroupState extends State<AddTasksGroup> {
  var error = '';
  var groupName = '';
  TextEditingController _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: _text,
              decoration: textInputDecoration.copyWith(hintText: 'Group ID'),
              onChanged: (val) {
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'give this group a name'),
              onChanged: (val) {
                setState(() {
                  groupName = val;
                });
              },
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(11, 196, 131, 1),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: StadiumBorder(),
                ),
                child: Text(
                  'Add this tasks group',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                onPressed: () {
                  var docRef = FirebaseFirestore.instance
                      .collection('groups')
                      .doc(_text.text);
                  docRef.get().then((docSnapshot) => {
                        if (docSnapshot.exists)
                          setState(() {
                            DBServices().addUserGroups(_text.text, groupName);
                            Navigator.pop(context);
                          })
                        else
                          setState(() {
                            error = 'ID is not valid';
                          })
                      });
                }),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              error,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ));
  }
}
