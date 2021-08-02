import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_test/constants/constant.dart';

///////////////// policy

class Policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                width: 400,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      'Privacy Policy',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "TaskShare built the TaskShare app as a Free app. This SERVICE is provided by TaskShare at no cost and is intended for use as is."
                        " This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service."
                        "If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used"
                        "for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy."
                        "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at TaskShare unless otherwise defined in this Privacy Policy.",
                        textAlign: TextAlign.left),
                    SizedBox(height: 20),
                    Text(
                      'Information Collection and Use',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to none. The information that I request will be retained on your device and is not collected by me in any way."
                        "The app does use third party services that may collect information used to identify you.Link to privacy policy of third party service providers used by the app",
                        textAlign: TextAlign.left),
                    Text(
                      'Log Data',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device"
                        "Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.",
                        textAlign: TextAlign.left),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

/////////////////////////////////////// help

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                width: 400,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      'Contact',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "If you have any questions or suggestions about this app, do not hesitate to contact me at abdrhf20@gmail.com.",
                        textAlign: TextAlign.center),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////// sugg Page

class SuggPage extends StatelessWidget {
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
                decoration: textInputDecoration.copyWith(hintText: 'Your Name'),
              ),
              SizedBox(height: 50),
              TextField(
                maxLines: 5,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Suggestions'),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  // color: Color.fromRGBO(11, 196, 131, .8),
                  // shape: StadiumBorder(),
                  child: Text(
                    'Send Suggestions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 16),
                  ),
                  onPressed: () {}),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////// about
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                width: 400,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      'About',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "This App Was Made By Abdulrahman Alwani, You Can Contact My On : abdrhf20@gmail.com For any Help Or Suggestions",
                        textAlign: TextAlign.center),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
