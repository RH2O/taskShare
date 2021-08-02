import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_test/constants/constant.dart';
import 'package:login_test/services/auth_services.dart';
import 'package:login_test/ui/authenticate/signUpVeiw.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  ////////////////////////////////////// The Brand Name
                  SizedBox(height: 60),
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
                  SizedBox(height: 50),

                  //////////////////////////////// Email Feild
                  TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Please Enter An Email' : null,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Email',
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value.trim();
                      });
                    },
                  ),

                  SizedBox(height: 50),
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

                  //////////////////////////////////////////////////// signin button

                  Container(
                    width: MediaQuery.of(context).size.width / 1.199,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(11, 196, 131, 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic a = await _auth.signIn(email, password);
                          if (a == null) {
                            setState(() {
                              error = 'something went wrong';
                            });
                          }
                        } else {
                          setState(() {
                            error = 'You Should Enter Valid Email And Password';
                          });
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 40),

                  //////////////////////////////////////////// Sign in With google

                  Container(
                    width: MediaQuery.of(context).size.width / 1.199,
                    child: ElevatedButton(
                      // color: Colors.white,
                      // shape: StadiumBorder(),
                      // padding: EdgeInsets.symmetric(vertical: 12),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 40, right: 35),
                            child: SvgPicture.asset(
                              'assets/icons/google-symbol.svg',
                              height: 35,
                            ),
                          ),
                          Text(
                            'Sign In With Google',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        await _auth.signInWithGoogle();
                      },
                    ),
                  ),
                  ////////////////////////////////////////////////// go to signUp
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t Have an Acount ?',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Register();
                          }));
                        },
                        child: Text(
                          ' Sign Up',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(11, 196, 131, 1),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
