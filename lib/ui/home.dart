import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:login_test/ui/pages/shared%20tasks/groups_page.dart';
import 'pages/myTasks/my_tasks.dart';
import 'pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

////// bottom sections
class _HomePageState extends State<HomePage> {
  var pages = [
    MyTask(),
    GroupsPage(),
    Settings(),
  ];
///////// app bar title
  // var titles = ['My Tasks', 'Shared Tasks', 'Settings'];

  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(11, 196, 131, 1),
      //   elevation: 0,
      //   title: Text(
      //     titles[selectedIndex],
      //     style: TextStyle(
      //       fontFamily: 'Nunito',
      //       fontWeight: FontWeight.w900,
      //     ),
      //   ),
      // ),
      body: pages[selectedIndex],
      ////////////////////////////////////////////////////////////////// bottom nav bar

      bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white,
            // selectedItemBorderColor: Colors.yellow,
            selectedItemBackgroundColor: Color.fromRGBO(11, 196, 131, 1),
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
          ),
          selectedIndex: selectedIndex,
          onSelectTab: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            FFNavigationBarItem(
              iconData: Icons.person,
              label: 'Mine',
            ),
            FFNavigationBarItem(
              iconData: Icons.people,
              label: 'Shared',
            ),
            FFNavigationBarItem(
              iconData: Icons.settings,
              label: 'Settings',
            ),
          ]),
    );
  }
}
