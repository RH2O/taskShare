import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_test/services/auth_services.dart';
import 'package:login_test/constants/constant.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  String email = '';
  String password = '';
  String name = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            //color: Colors.red,
            height: MediaQuery.of(context).size.height,

            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    ///////////////////////////////////////////// The Brand Name
                    SizedBox(height: 70),
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
                    SizedBox(height: 50),
                    ////////////////////////////////////////// Name feild

                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Please Enter Your Name' : null,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Your Name',
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    SizedBox(height: 40),

                    //////////////////////////////// Email Feild
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Please Enter An Email' : null,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),

                    SizedBox(height: 40),
                    //////////////////////////////////////////////// Password Feild
                    TextFormField(
                      obscureText: true,
                      validator: (value) =>
                          value.length < 5 ? 'Please Enter 5+ chars' : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 60),

                    //////////////////////////////////////////////////// sign up button

                    Container(
                      width: MediaQuery.of(context).size.width / 1.199,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(11, 196, 131, 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic reg = await _auth.register(email, password);
                            if (reg != null) {
                              Navigator.of(context).pop();
                            }
                          } else {
                            setState(() {
                              error =
                                  'You Should Enter Valid Email And Password';
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Material(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text('Sign UP'),

//               // Email Feild
//               TextFormField(
//                 validator: (value) =>
//                     value.isEmpty ? 'Please Enter An Email' : null,
//                 decoration: textInputDecoration.copyWith(
//                   hintText: 'Email',
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     email = value;
//                   });
//                 },
//               ),
//               // Password Feild
//               TextFormField(
//                 validator: (value) =>
//                     value.length < 5 ? 'Please Enter 5+ chars' : null,
//                 decoration: textInputDecoration.copyWith(hintText: 'PassWord'),
//                 onChanged: (value) {
//                   setState(() {
//                     password = value;
//                   });
//                 },
//               ),

//               // send Button

//               RaisedButton(
//                 child: Text('Register'),
//                 onPressed: () async {
//                   if (_formKey.currentState.validate()) {
//                     await _auth.register(email, password);
//                   } else {
//                     setState(() {
//                       error = 'You Should Enter Valid Email And Password';
//                     });
//                   }
//                 },
//               ),

//               // Text(error)
//             ],
//           ),
//         ),
//       ),
//     );
