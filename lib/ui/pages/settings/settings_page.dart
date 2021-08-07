import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_test/services/auth_services.dart';
import 'package:login_test/ui/pages/settings/settings_parts.dart';

//////////////////////////////////////////////////////////////////////// Settings Page
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(11, 196, 131, 1),
        // elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /////////////////////// Brand Name

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                    ),
                    children: [
                      TextSpan(
                        text: 'T',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                          fontSize: 40,
                          letterSpacing: -10,
                        ),
                      ),
                      TextSpan(text: 'ask'),
                      TextSpan(
                        text: 'S',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                          fontSize: 40,
                        ),
                      ),
                      TextSpan(text: 'hare'),
                    ],
                  ),
                ),

                /////// icon
                SizedBox(
                  width: 5,
                ),
                SvgPicture.asset(
                  'assets/icons/task.svg',
                  width: 35,
                  color: Colors.green,
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Policy();
                }));
              },
              child: ListTile(
                leading: Icon(
                  Icons.lock_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HelpPage();
                }));
              },
              child: ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'Help',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            ///// sugg
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SuggPage();
                }));
              },
              child: ListTile(
                leading: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  'Suggestions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            //////////////  about
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutPage();
                }));
              },
              child: ListTile(
                leading: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  'About',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            ////////////////////////////////////////////////////// log out
            GestureDetector(
              onTap: () async {
                await AuthServices().signOut();
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
