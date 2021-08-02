import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:login_test/ui/home.dart';
import 'package:login_test/ui/authenticate/loginVeiw.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return LogInScreen();
    } else
      return HomePage();
  }
}
