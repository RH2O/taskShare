import 'package:flutter/material.dart';
import 'package:login_test/constants/constant.dart';
import 'package:login_test/services/db.dart';

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
                        DBServices()
                            .addTask(
                              title,
                              description,
                            )
                            .then((value) => print(value.id));
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
