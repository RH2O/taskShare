import 'package:flutter/material.dart';
import 'package:login_test/constants/constant.dart';
import 'package:login_test/services/db.dart';

class CreateTasksGroup extends StatefulWidget {
  @override
  _CreateTasksGroupState createState() => _CreateTasksGroupState();
}

class _CreateTasksGroupState extends State<CreateTasksGroup> {
  var groupName = '';

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
                  'Create New Group',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                onPressed: () {
                  DBServices().createNewGroup(groupName);
                  Navigator.pop(context);
                }),
          ),
          SizedBox(height: 20),
        ],
      ),
    ));
  }
}
